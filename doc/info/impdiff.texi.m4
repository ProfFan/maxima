@c -*- Mode: texinfo -*-
@menu
* Functions and Variables for impdiff::
@end menu

@node Functions and Variables for impdiff,  , impdiff-pkg, impdiff-pkg
@section Functions and Variables for impdiff

@anchor{implicit_derivative}
@deffn {Function} implicit_derivative (@var{f},@var{indvarlist},@var{orderlist},@var{depvar})
This subroutine computes implicit derivatives of multivariable functions.
@var{f} is an array function, the indexes are the derivative degree in the @var{indvarlist} order;
@var{indvarlist} is the independent variable list; @var{orderlist} is the order desired; and 
@var{depvar} is the dependent variable.

To use this function write first @code{load("impdiff")}.

@opencatbox
@category{Differential calculus} @category{Share packages} @category{Package impdiff}
@closecatbox

@end deffn

