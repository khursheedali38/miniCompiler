# miniCompiler
C compiler for certain langauage constructs. Compiler for the following constructs:
+ `for` loop
+ `int` data type
+ `float` data type 
+ `void` data type
+ `char` data type
+ `if else` statements
+ arithmetic and logical operators

## Prerequisites
+ lex
+ yacc

## Installation
```
sudo apt-get update
sudo apt-get install flex
sudo apt-get install bison
```

## Running the test cases
```
run.sh
./a.out <filename>
```

Consider an example, say I would like to test the ICG phase, the the folowing command should be entered
```
./a.out test_cases/icg/test1.c
```

## Built With
+ flex
+ bison

## Authors
Mohammed Khursheed Ali Khan
