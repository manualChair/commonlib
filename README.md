![commonlib](commonlib.png)

Common LISP function library for AutoLISP Separate-namespace VLX

# INTRODUCTION

This library is created so that Common LISP standard functions can be used with AutoLISP. Since AutoLISP's standard functions are limited to the minimum necessary ones, to write a program, you often have to create basic functions. This library make up for function shortages and makes programming work more efficient. Functions of the Common LISP specification, which is ANSI, are sophisticated and useful.

The function specifications of the library conform to that of Common LISP as much as possible. Besides simple functions, it also includes language-level extensions that make it easy in AutoLISP to use common functions of Common LISP or other languages, such as structures and arrays. However, since the types of functions are limited to those that may be used in AutoCAD, it does not make AutoLISP a complete Common LISP. Some language specifications cannot be reproduced. Also, as you can see from other LISP specifications brought to AutoLISP, this library does not include functions like controlling AutoCAD and drawing figures.

On the other hand, in implementing Common LISP standard functions, some of the function specifications that I thought would be useful in AutoLISP have been expanded. In addition to the Common LISP standard functions, the library includes original functions that are likely to be useful. I have also added linear algebra functions for basic vectors and matrices.

The functions in this library have dependencies from simple to complex. These functions are loaded by using special include function that extends the load function. In loading mechanism, it's difficult to figure out what functions are loaded, and we don't need to understand function dependencies if you just use them. Therefore, The program created using these library functions is on the premise of finishing as a **Separate-namespace VLX application** that does not interfere with the AutoCAD user's existing AutoLISP execution environment.

In addition, please note that **there are changes library specifications in the future** for various reasons.

# ABOUT LICENSE

The function source code provided in this library is a **MIT license**. The MIT license is one of the open source software licenses that has few restrictions.

The outline of the MIT license is translated into this case as follows.
* No warranty!
* Anyone can use the source code of this library for free. You can freely distribute and change the source code, including commercial use, and create programs that use it.
* When redistributing or changing the source code of this library, the following copyright notices already included in these libraries must not be erased. Also, when you try to distribute your program created using this library, please display the following three copyright notice lines in appropriate place where we can confirm, such as another file for the license display that is included.
```
Copyright (c) 20xx manual chair japan
Released under the MIT license
https://opensource.org/licenses/mit-license.php
```
# LIBRARY USAGE

To use the functions of this library, use a unique include function that extends the load function. See below for the include function.

https://github.com/manualChair/include.git

The first line of the source code for each library function contains commented out statements using the include function to use this function. Copy and paste this to include the library functions in your program.

# LIBRARY FUNCTION REFERENCE

I'm writing.

# LIBRARY OVERVIEW

## List of Folders

Library source code is divided into folders by category. This folder follows the reference section at the end of Paul Graham's ANSI Common Lisp. In addition there are "common" and "linear_algebra" folders. The “common” folder contains unique functions commonly used in the library, and the “linear_algebra” folder contains functions related to linear algebra that do not exist in Common LISP.

## Namespace

Function naming conforms to Common LISP. It is written on the assumption that it will be finished up as **Separate-namespace VLX application**. Therefore, the true name of the function comes first in the unprefixed form, which is unusual in AutoLISP such as vl- vla-. So, There is the possibility of **conflicting** with your favorite symbol or function names. Examine the symbol name carefully.

Library functions are defined with the name of the main function followed by a ":" (colon) if the function requires its own sub functions.

Main Function	| Sub Function
---|---
FOO	|FOO:SUB etc.

If you see a sub function in this form in a source code, you can access it from anywhere, but it will not always work. **Access from the main function**.

Also, when there are multiple functions for a certain data type, some of the main functions have function names with ":" between them. For example, the vector:add and vector:sub functions for vector. These can be called from anywhere.

Data Type	|Callable Functions
---|---
vector	|vector:add vector:sub ...

These are the notations used to separate namespaces. In any case, if it is written in the function reference, it is the main function and can be called from anywhere. But anything not written is a sub function and should not be called.

## Principle of One Function Per File

In principle, each file consists of one function (one purpose). In this case, the sub function is considered to be included in the main function, and does not mean one function definition in one file. Exceptionally, the ones that are obviously used in sets have multiple main functions defined in one file.

In principle, the file name should be the same as the function name. However, in some functions, ":" (colon) has been replaced with "_" (underscore), and the inequality sign ">" has been omitted.

Function Name	|File Name
---|---
matrix:Inverse-Cofactor	|matrix_Inverse-Cofactor.LSP
string->list	|string-list.LSP

Functions written in file names starting with "_" (underscore) define only sub functions called from the main function. If it is referenced from multiple main functions (multiple files) or if the function is huge, it is split into separate files.

## Optional Arguments

Common LISP functions can be defined with optional arguments, but new functions defined in AutoLISP cannot define optional arguments, so all arguments must always be specified. Therefore, the code may be unnecessarily long, but in principle, if you do not use the optional argument, pass nil and it will be ignored.

## Sequence

When you look at Common LISP functions from AutoLISP, you need to understand a new concept of "sequence" that AutoLISP does not have. A sequence is a one-dimensional collection of data. For example, a one-dimensional array, a one-dimensional list of LISPs, including strings. String are also one-dimensional arrays of character codes. And to make things even more complicated, Common LISP treats symbols like uppercase strings. In Common LISP, it look like symbol names can be considered as sequences, but it is not the right. It's confusing, so here, symbol are also treated as sequences.

Common LISP has a group that accepts sequences as function arguments. In this implementation of AutoLISP, functions that can handle sequences accept sequences. In other words, you can substitute a string or symbol Instead of giving a list as an argument, or you can give a list where a string is expected. These functions are located in the "strings" and "sequences" folders. On the other hand, there is a category only for the list, which is stored in the "conses" folder.

The data given in these arguments is eventually converted into a list inside the function and processed. In the end, the difference between the "strings" folder and the "sequences" folder that process in a list even if they are both sequences is that strings are intended to process strings, and arguments can be converted to strings even if they are lists , Sequences are intended to work with generic one-dimensional lists, and their arguments will accept general one-dimensional lists as well as strings and lists converted from strings. Note that conses that handle lists are more general-purpose that can handle lists other than one dimension.

In this library, strings and lists converted from strings are called "string-types" and are distinguished from just strings.

The differences between the folders are summarized below. If you want to work with lists or strings, look for functions in these folders to find the function you want.

Folder	|Target	|Description
---|---|---
conces	|List	|Lists, including multi-dimensional lists
strings	|Sequence	|Strings and one-dimensional lists that can be converted to string
sequences	|Sequence	|Generic one-dimensional lists, including strings and lists that can be converted to string

ActiveX variant types and safe arrays can also be handled as sequences if they represent strings or are one-dimensional arrays.

The functions in the "strings" folder have an extra argument that specifies the type of the return value, which has been modified from a string or list, if any, such as a list or string. Therefore, when connecting filter-type functions that perform various processing, it is possible to reduce the overhead of type conversion such as converting from a string to a list and back to a string.

If you use a function in the "sequences" folder, it will be returned according to the argument type in principle. For example, if you give a string, it will be returned as a string. In this case, if some processing is performed continuously with a filter type function, the overhead of type conversion is a concern. For this reason,  in parallel, I have prepared a core function that has a function name similar to Common LISP  and that has "-list" at the end of the name and that accepts only a list. And the regular function performs type conversion and leaves the processing to the core function. Using this hierarchy, for example, if you want to process string continuously, converting to a list in advance and using the function with "-list" at the end continuously can eliminate type conversion overhead. And finally, if you need a string, convert it from the list to a string.

## Type Conversion - coerce Function

Common LISP uses the coerce function for type conversion. In this library, too, the coerce function is frequently used in sequence processing. It extends the capabilities of AutoLISP beyond the numeric and string type conversions that cover AutoLISP's existing type conversion functions.

For example, AutoCAD's selection set and list of ename can be converted to each other with the coerce function. Furthermore, conversion to a safe array or variant type can be performed by specifying SAFEARRAY or VARIANT.

In addition, the source type is an AutoLISP type, but the destination type can specify some special types. The main thing is that if you specify LIST when converting a string to a list, it will be a list of integers representing ASCII character codes by the AutoLISP standard vl-string-> list function. However, if you specify the custom type SLIST, it will be converted to a custom structured list representing a string containing multibyte characters. Also, by specifying a special type VECTOR as the conversion destination, it can be converted to a flat one-dimensional safe array used by ActiveX functions from a multi-dimensional list.

Basically, the type symbols that can be specified for the source and destination types are as follows, depending on the type of AutoLISP. It is the same as the return value of the type function.

|Symbol
|---
|NIL INT REAL STR SYM LIST SUBR ENAME VLA-Object PICKSET VARIANT SAFEARRAY

In addition to the above, the following special symbols can be specified as conversion destinations.

Symbol	|Description
---|---
SLIST	|List that a string converted to with a multibyte character structure
VECTOR	|One-dimensional safe array
BOOL	|Symbols used in ActiveX :vlax-true and :vlax-false
CHAR	|Integer representing a single character or structure representing a multibyte character
STRC	|A single character string

## Multibyte Characters

In this library, the handling of character strings is internally converted into a list and processed. In that case, ASCII character codes and multibyte characters are processed separately. In other words, it supports Japanese kana and kanji. Currently supported are SHIFT_JIS and hexadecimal strings representing UNICODE character codes. And if it is a simple thing like SHIFT_JIS that can be determined only by looking at the character code, it can also support multi-byte characters of other foreign languages.

## Comparison of Real Numbers

Real numbers always include calculation errors. If there is a condition such as what to do if the comparison of real numbers in this library is equal, the comparison of real numbers will judge the value set in the global variable \*tolerance\* as an allowable value. Used in linear algebra-related functions.

(EOF)
