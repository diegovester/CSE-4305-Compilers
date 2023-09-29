# CSE4305 Exercise 00 Troubleshooting

This guide outlines the steps required to resolve issues encountered by Mac users while attempting to complete Exercise 00 on their machines. 
The issue pertains to running Exercise 0, specifically the "leaky" program, on MacOS, which fails to report memory leaks despite the inclusion of the ``fsanitize=address`` flag during compilation. This guide was tested on a MacOS machine running Ventura 13.5.1 on an M2 chip.

## Problem Description
When executing the "leaky" program on MacOS, it fails to detect memory leaks, whereas the "overread" program correctly generates the expected report as specified in the assignment. The problem stems from the fact that the version of Clang provided by Apple lacks support for the leak sanitizer, as discussed in [this StackOverflow post](https://stackoverflow.com/questions/53456304/mac-os-leaks-sanitizer/55778432#55778432).

## Solution
**1. Installing LLVM**
To enable the leak sanitizer, you need to download and install the latest version of Clang (LLVM), which does support this feature. Follow these steps:

a. Install LLVM using Homebrew:
```bash
brew install llvm
```

b. In your terminal, execute the following command to add the export path to your shell configuration file (e.g., ``~/.zshrc`` for the Zsh shell):
```bash
echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc
```

c. Apply the changes to your current shell session:
```bash
source ~/.zshrc 
```
> Note: If you are getting a ``"parse error near '\n'"`` error, ensure that the export path is on its own line in ``.zshrc``.

**2. Updating the Makefile**
Modify line 8 of the Makefile to utilize clang instead of gcc.

**3. Running the Leak Detector**
Proceed with the steps provided by the assignment to compile the C file, but execute it differently as specified in the [Clang documentation](https://clang.llvm.org/docs/AddressSanitizer.html#memory-leak-detection):
a. Compile the "leaky" program:
```bash
make clean ; make leaky.exe
```
b. Run the program with leak detection enabled using the following command:
```bash
ASAN_OPTIONS=detect_leaks=1 ./leaky.exe
```