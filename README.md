# commonlib
Common LISP function library for AutoLISP Separate-namespace VLX
## Overview
This library is created so that Common LISP standard functions can be used with AutoLISP. Since AutoLISP's standard functions are limited to the minimum necessary ones, to write a program, you often have to create basic functions. This library make up for function shortages and makes programming work more efficient. Functions of the Common LISP specification, which is ANSI, are sophisticated and useful.

The function specifications of the library conform to that of Common LISP as much as possible. Besides simple functions, it also includes language-level extensions that make it easy in AutoLISP to use common functions of Common LISP or other languages, such as structures and arrays. However, since the types of functions are limited to those that may be used in AutoCAD, it does not make AutoLISP a complete Common LISP. Some language specifications cannot be reproduced. Also, as you can see from other LISP specifications brought to AutoLISP, this library does not include functions like controlling AutoCAD and drawing figures.

On the other hand, in implementing Common LISP standard functions, some of the function specifications that I thought would be useful in AutoLISP have been expanded. In addition to the Common LISP standard functions, the library includes original functions that are likely to be useful. I have also added linear algebra functions for basic vectors and matrices.

The functions in this library have dependencies from simple to complex. So if you want to use one function, use the *special mechanism of the library that automatically loads the necessary functions*. The loading mechanism and usage will be explained in the [　　　　　　　] section.

In loading mechanism, it's difficult to figure out what functions are loaded, and we don't need to understand function dependencies if you just use them. Therefore, The program created using these library functions is on the premise of finishing as a *Separate-namespace VLX application* that does not interfere with the AutoCAD user's existing AutoLISP execution environment.

## About license

The function source code provided in this library is a *MIT license*. The MIT license is one of the open source software licenses that has few restrictions.

The outline of the MIT license is translated into this case as follows.
* No warranty!
* Anyone can use the source code of this library for free. You can freely distribute and change the source code, including commercial use, and create programs that use it.
* When redistributing or changing the source code of this library, the following copyright notices already included in these libraries must not be erased. Also, when you try to distribute your program created using this library, please display the following three copyright notice lines in appropriate place where we can confirm, such as another file for the license display that is included.
```
Copyright (c) 2020 manual chair japan
Released under the MIT license
https://opensource.org/licenses/mit-license.php
```
Please note that *there are changes library specifications in the future* for various reasons.