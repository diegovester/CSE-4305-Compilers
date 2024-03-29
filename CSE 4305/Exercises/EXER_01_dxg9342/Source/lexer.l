  // Vester, Diego A.
  // dxg9342
  // 2023-12-01

  //---- DEFINITIONS  --------------------------------------------

%option header-file="lex.yy.h"

/* Our input is not from an interactive source. */
%option never-interactive
/* Don't generate the default rule. */
%option nodefault
/* We don't directly read the input. */
%option noinput
/* Don't include <unistd.h>. */
%option nounistd
/* We don't 'unput' a character back. */
%option nounput
/* Don't call yywrap() on EOF. */
%option noyywrap

/* These two options are doubled to get more detailed reports. */
/* Write performance report to stderr. */
%option perf-report perf-report
/* Write statistics summary to stderr. */
%option verbose verbose

/* Generate warning messages for goofs. */
%option warn

/* Maintain current line number in yylineno. */
%option yylineno

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Token IDs.  Theses are usually defined by bison.  Since this is
//    a simple flex-only solution, we define them ourselves.
//    The numbers start at 256 to avoid clashing with the literal
//    'single character' token categories.  (See the flex notes
//    for more info on that kind of token category.)
enum {
  tok_ID = 256,
  tok_INT_LIT,
  tok_HEX_LIT,
  tok_BIN_LIT,
  tok_OCT_LIT,
  tok_REAL_LIT,
};

// yylval is the union of all possible attributes that can be
//    returned by any category of token.  This is usually defined
//    for us by bison.  Since this is a simple flex-only solution,
//    we define it ourselves.
union {
  int   intval;
  char *strval;
  double realval;
} yylval;

// yylloc is the location of the token.  This is usually defined
//    for us by bison.  Since this is a simple flex-only solution,
//    we define it ourselves.
typedef struct {
  int first_line, first_column;
  int last_line, last_column;
} YYLTYPE;

YYLTYPE yylloc;

// flex doesn't track the column number automatically.  We keep
//    this up-to-date ourselves.
int yycolno;

// This action is peformed by yylex() at the beginning of every
//    action routine after yytext and yyleng are set but before
//    any user code is run.
// We use it to set the location of the token that was just
//    scanned and to keep yycolno up to date.
#define YY_USER_ACTION                              \
  yylloc.first_line = yylloc.last_line = yylineno;  \
  yylloc.first_column = yycolno;                    \
  yylloc.last_column = yycolno + yyleng - 1;        \
  yycolno += yyleng;
%}

/* Some definitions to make the REs below easier to understand. */
DIGIT       [0-9]
/* Make a definition for hex "digits" */
/* Allow a-f and A-F. Name it HEXIT -- for hex "digit" */
HEXIT       0x([0-9a-fA-F]+)
/*
As soon as that works, you are clearly omnipotent.  Make up
    another rule for binary integer literals.  These will start
    with 0b and have only 0 and 1 as possible "digits".*/
BINIT       0b([0-1]+)
WORD_CHAR   [_a-zA-Z0-9]
/*
With that done, do another rule to recognize octal integer
    literals.  These begin with 0o and have 0-7 as possible
    "digits".*/
OCTIT       0o([0-7]+)
/*Make a rule whose pattern matches such things as 1.234 or
        .123 or 123. or ...  These are digit strings with EXACTLY
        one decimal point somewhere in the middle or at the front
        or at the end.*/
REAL_LIT    ([0-9]*\.[0-9]+|[0-9]+\.[0-9]*)

%% //---- RULES --------------------------------------------------

{REAL_LIT}+  {
  //Use atof() to convert the characters indicated by yytext
  //      into a double and assign it to yylval.realval.
  yylval.realval = atof( yytext );

  // We successfully scanned an integer literal.
  return tok_REAL_LIT;
}

{DIGIT}+  {
  // An integer literal has the decimal value of the string of
  //  digits as its attribute.
  yylval.intval = (int) strtol( yytext, NULL, 10 );

  // We successfully scanned an integer literal.
  return tok_INT_LIT;
}

{HEXIT}+  {
  //Make a rule for hex literals.  This will look like the one
  //      for decimal literals in lines 90-97 but will have a
  //      pattern that recognizes such things as 0xaBc or 0x123 or
  //      0xDeadBeef or ...
  //
  //      Also, the strtol() call in the action routine should use
  //      16 for the base and it should start the conversion at
  //      yytext+2.  (Why?)

  yylval.intval = (int) strtol( yytext+2, NULL, 16 );

  // We successfully scanned an integer literal.
  return tok_HEX_LIT;
}



{BINIT}+  {

  yylval.intval = (int) strtol( yytext+2, NULL, 16 );

  // We successfully scanned an integer literal.
  return tok_BIN_LIT;
}

{OCTIT}+  {


  yylval.intval = (int) strtol( yytext+2, NULL, 16 );

  // We successfully scanned an integer literal.
  return tok_OCT_LIT;
}





[_a-zA-Z]{WORD_CHAR}*  {
  // An id has a MALLOCed copy of the characters that make it up
  //  as its attribute.  Remember to free() this somewhere so you
  //  don't leak memory!
  yylval.strval = strdup( yytext );

  // We successfully scanned an id.
  return tok_ID;
}

[ \f\t\v]+  { /* Ignore intertoken whitespace */ }

[\r\n]+     {
  // \r and \n start new lines, so the column number has to be
  //  reset to 1.
  yycolno = 1; }

.       {
  // Ignore illegal characters after printing a spiffy and
  //  informative message.
  printf( "(%d:%d) Illegal character '%s' (0x%02x)\n",
    yylloc.first_line, yylloc.first_column, yytext, yytext[0] );
}

%% //---- USER CODE ----------------------------------------------

char *getFileContents( const char *fName )
{
  FILE *fp = fopen( fName, "r" );
  if ( fp == NULL ) {
    printf( "Unable to open '%s' for read.\n", fName );
    exit( -1 );
  }

  char   *buffer = NULL;
  size_t  len;
  ssize_t numBytes = getdelim( &buffer, &len, '\0', fp );

  fclose( fp );

  if ( numBytes == -1) {
    printf( "No contents read from '%s'?\n", fName );

    return strdup( "" );

  } else {
    printf( "%d byte%s read from '%s'.\n",
      (int) len, len == 1 ? "" : "s", fName );

    return buffer;
  }
}

//----------------------------------------------------------------
void printTokLoc()
{
  if ( yylloc.first_line == yylloc.last_line ) {
    if ( yylloc.first_column == yylloc.last_column ) {
      printf( "(%d:%d) ",
        yylloc.first_line, yylloc.first_column );
    } else {
      printf( "(%d:%d-%d) ",
        yylloc.first_line,
        yylloc.first_column, yylloc.last_column );
    }
  } else {
    printf( "(%d:%d-%d:%d) ",
      yylloc.first_line, yylloc.first_column,
      yylloc.last_line, yylloc.last_column );
  }
}

//----------------------------------------------------------------
int main( int argc, char *argv[] )
{
  char *inStr;

  switch ( argc ) {
    case 1 :
      inStr = strdup( "fred _ 15 1234.345 \"bob\" Maddog87" );
      break;

    case 2 :
      inStr = getFileContents( argv[1] );
      break;

    default :
      printf( "Usage: %s [ <inFileName> ]\n", argv[0] );
      return 0;
  }

  printf( "Tokens for \"%s\":\n", inStr );

  //--------------------------------------
  // Initialize the current location.
  //   flex updates yylineno automatically.
  //   We have to keep track of yycolno ourselves.
  yylineno = 1;
  yycolno  = 1;

  //--------------------------------------
  // Tell flex to use this char * as the source of the characters
  //  it should be scanning.
  yy_scan_string( inStr );

  //--------------------------------------
  // Get the tokens one-by-one.
  int tok;

  while ( ( tok = yylex() ) ) {
    printTokLoc();

    switch ( tok ) {
      case tok_ID:
        printf( "ID '%s'\n", yylval.strval );
        free( yylval.strval );
        break;

      case tok_INT_LIT:
        printf( "INTEGER_LITERAL %d\n", yylval.intval );
        break;

      case tok_HEX_LIT:
        printf( "HEX_LITERAL %d\n", yylval.intval );
        break;

      case tok_BIN_LIT:
        printf( "BIN_LITERAL %d\n", yylval.intval );
        break;

      case tok_OCT_LIT:
        printf( "OCT_LIT_YOUR_MOM %d\n", yylval.intval );
        break;
      
      case tok_REAL_LIT:
        printf( "REAL_LITERAL %f\n", yylval.realval );
        break;

      default:
        printf( "Unknown token category %d?\n", tok );
        break;
    }
  }

  //--------------------------------------
  // Get rid of the input string.
  free( inStr );

  //--------------------------------------
  // No errors!
  return 0;
}

//----------------------------------------------------------------
