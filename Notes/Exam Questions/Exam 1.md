
# Question 1
**For a translator to be a true compiler, what does it analyze? What is the resemblance of the generated IR to the source code?**

"We'll use "compiling" to mean that a complete analysis of the source code is done by the translator."


# Question 2
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


# Question 3
**Does a compiler "stick around" after the program is compiled? Explain.**

# Question 4
**What is JIT? Explain**  
Just-In-Time Compilation
Compilation can be delayed until the last possible moment.
Allows for handling "on-the-fly" code, optimization based on run-time conditions, etc.

# Question 5
**What is REPL? Explain**
Read-Eval-Print Loop (REPL)

An interactive environment wherein the user types a line at a time which is then evaluated and results displayed.

- Read: Get Input from user
- Eval: Determine value
- Print: Display result to user
- Loop: Do again, until terminated

# Question 6
**Why would compiler compile down to assembler instead of machine code?**
1. To help insulate the code generation of the compiler. You eliminate the concerns of OS changes in your compiler code.
2. Assembler is architecture dependent. It is not portable. 

# Question 7
**What is a self-hosting compiler?**
A compiler written in its own language.
e.g. a C compiler written in C.

# Question 8
**What is a source-to-source compiler?**
A compiler that translates one high level langauge to another separate high level language.