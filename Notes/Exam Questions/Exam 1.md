# Some Questions

## Question 1
**A. What High-Level Language had the first commercially available compiler?**  
> FORTRAN

**B. Within 3 years, when was it made available?**  
> [FORTRAN released commercially in 1957.](https://www.thoughtco.com/history-of-fortran-1991415)

**C. This compiler promised three resulting advantages. Name two.**  
> [Speed and portability.](https://www.spiceworks.com/tech/tech-general/articles/what-is-fortran/)

**D. How long did it take to write this compiler?**  
> [Three years](https://www.spiceworks.com/tech/tech-general/articles/what-is-fortran/)

## Question 2
**A. Why can we say that all general purpose languages are computationally equivalent?**  
> While general-purpose languages may differ in terms of syntax, semantics, and libraries, they are all Turing-complete, which means they can solve the same class of computational problems.

**B. Does a compiler "stick around" while a program it compiled executes?**  
> No, a compiler typically does not "stick around" or remain active while a program it compiled is executing. Once a compiler has translated the high-level source code into machine code or bytecode, its primary role is complete, and it is no longer needed during program execution.

C. What's an advantage an interpreter has over a compiler?
> Portability and Ease of Debugging

D. What's an advantage a compiler has over an interpreter?
> Performance and improved security

## Question 3
**A. Could a REPL be created for C?**
> Yes, a Read-Eval-Print Loop (REPL) can be created for the C programming language, although it is less common than for some other languages.

**B. Justy your answer to [3]A.**
> The  Cling project is an interactive C/C++ interpreter built on top of Clang, a C/C++ compiler.

> This proves it is possible, though creating a full-featured C REPL can be complex and may require handling various issues.
* managing memory
* dealing with library dependencies
*  handling error messages from the compiler.
* C is a statically-typed language
* Handling data types and variables in a REPL can be challenging.

## Question 4
**A. What five items are required to define a finite automaton?**  
1. Alphabet (Σ)
2. States (Q)
3. Transition Function (δ)
4. Start State (q0)
5. Accepting States (F)

**B. What does it mean for a finite automaton to accept a string? (Two items to mention here.)**  
1. The entire input string is exhausted 
2. The automaton is in an accepting state

**C. What is required for a finite automaton to be deterministic? (Two items to mention here.)**  
1. Deterministic Transition Function  
There is at most one next state that the automaton can transition to

2. Unambiguous Path  
Given the same input string, the DFA will always end up in the same final state

## Question 5
A: Can a finite automaton accept an infinite-length string?  
No

B: Explain why or why not.  
The automaton would not halt, and therefore never reach an accepting state.

## Question 6
A: Can a finite automaton reject an infinite-length string?  
No

B: Explain why or why not.  
The automaton would never halt. It would be always be possible that perhaps the string could accept, but may just be a little longer, forever.

## Question 7
A: What are the five fundamental regular expressions?

B: What does + mean when applied to a regular expression? (Be specific!)

C: Even though ? is not one of the 5 fundamental REs, why is it acceptable to use it when writing REs? (Be specific!)

## Question 8
**Using only the 5 Basic REs and [], ?, + Write a Regular Expression that matches...**
A: ... a C identifier.

B: ... a decimal number with a . somewhere in the middle. (That is, has digits on both sides.)

C: ... a single-line string literal.

# Quiz 1 Questions

## Question 1
**For a translator to be a true compiler, what does it analyze? What is the resemblance of the generated IR to the source code?**

"We'll use "compiling" to mean that a complete analysis of the source code is done by the translator."


## Question 2
**What is an example of an operation in cpp?**  
cpp = contextual preprocessor  
Conditional Compilation  
#if Directive  
#ifdef Directive  
#ifndef Directive  
#else Directive  
#elif Directive  
#endif Directive  

[Source](https://www.geeksforgeeks.org/cc-preprocessors/#)


## Question 3
**Does a compiler "stick around" after the program is compiled? Explain.**

## Question 4
**What is JIT? Explain**  
Just-In-Time Compilation
Compilation can be delayed until the last possible moment.
Allows for handling "on-the-fly" code, optimization based on run-time conditions, etc.

## Question 5
**What is REPL? Explain**
Read-Eval-Print Loop (REPL)

An interactive environment wherein the user types a line at a time which is then evaluated and results displayed.

- Read: Get Input from user
- Eval: Determine value
- Print: Display result to user
- Loop: Do again, until terminated

## Question 6
**Why would compiler compile down to assembler instead of machine code?**
1. To help insulate the code generation of the compiler. You eliminate the concerns of OS changes in your compiler code.
2. Assembler is architecture dependent. It is not portable. 

## Question 7
**What is a self-hosting compiler?**
A compiler written in its own language.
e.g. a C compiler written in C.

## Question 8
**What is a source-to-source compiler?**
A compiler that translates one high level langauge to another separate high level language.

# Lecture Questions

## Phases of Compilation *** 
Date: 09-08-23
M00 Introduction
Memorize this slide

## Lexical Analysis

REAL_LITERAL ***
[0-9]*(([0-9][.])|([.][0-9]))[0-9]*
Professor: "Be able to do this with pen and paper"

## Regular Expressions (RE) ***
Date: 09-22-23
M01 Lexical Analysis
Empty set is not a regular expression. It is nothing.
"If you dont have an empty set as a regular expression?"
- an empty regular expression. empty. nothing.

## [Grammars and the Chomsky Language Hierarchy]
Date: 09-22-23
M01 Lexical Analysis
we can encode a turing machine in a finite number of 0s and 1s. ***
If we can do that, that means every possible turing machine can be equated with a binary number, which means an integer.


## Deterministic Finite Automaton Examples
Date: 09-29-23
M01 Lexical Analysis


## Nondeterministic Finite Automota (NFA)
Date:09-29-23
M01 Lexical Analysis
Does being non-deterministic increase the descriptive power of a Finite Automaton? ***
No! Why not?


# Psipser
 Review Chapter 1 and 2 from Psipser
	* Try to do every exercise
	* Be able to answer in 5 words or less

# Feyman Papers
*** Read the Feyman papers on Canvas
