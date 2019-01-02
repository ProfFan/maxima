@c -*- Mode: texinfo -*-
@menu
* Introduction to fast Fourier transform::                     
* Functions and Variables for fast Fourier transform::
* Functions for numerical solution of equations::
* Introduction to numerical solution of differential equations::
* Functions for numerical solution of differential equations::
@end menu

@c -----------------------------------------------------------------------------
@node Introduction to fast Fourier transform, Functions and Variables for fast Fourier transform, Numerical, Numerical
@section Introduction to fast Fourier transform
@c -----------------------------------------------------------------------------

The @code{fft} package comprises functions for the numerical (not symbolic)
computation of the fast Fourier transform.

@opencatbox
@category{Fourier transform} @category{Numerical methods} @category{Share packages} @category{Package fft}
@closecatbox

@c end concepts Numerical

@c -----------------------------------------------------------------------------
@node Functions and Variables for fast Fourier transform, Functions for numerical solution of equations, Introduction to fast Fourier transform, Numerical
@section Functions and Variables for fast Fourier transform
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{polartorect}
@deffn {Function} polartorect (@var{r}, @var{t})

Translates complex values of the form @code{r %e^(%i t)} to the form
@code{a + b %i}, where @var{r} is the magnitude and @var{t} is the phase.
@var{r} and @var{t} are 1-dimensional arrays of the same size.
The array size need not be a power of 2.

The original values of the input arrays are
replaced by the real and imaginary parts, @code{a} and @code{b}, on return.
The outputs are calculated as

@example
a = r cos(t)
b = r sin(t)
@end example

@mref{polartorect} is the inverse function of @mrefdot{recttopolar}

@code{load(fft)} loads this function.  See also @mrefdot{fft}

@opencatbox
@category{Package fft} @category{Complex variables}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{recttopolar}
@deffn {Function} recttopolar (@var{a}, @var{b})

Translates complex values of the form @code{a + b %i} to the form
@code{r %e^(%i t)}, where @var{a} is the real part and @var{b} is the imaginary
part.  @var{a} and @var{b} are 1-dimensional arrays of the same size.
The array size need not be a power of 2.

The original values of the input arrays are
replaced by the magnitude and angle, @code{r} and @code{t}, on return.
The outputs are calculated as

@example
r = sqrt(a^2 + b^2)
t = atan2(b, a)
@end example

The computed angle is in the range @code{-%pi} to @code{%pi}.

@code{recttopolar} is the inverse function of @mrefdot{polartorect}

@code{load(fft)} loads this function.  See also @mrefdot{fft}

@opencatbox
@category{Package fft} @category{Complex variables}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{inverse_fft}
@deffn {Function} inverse_fft (@var{y})

Computes the inverse complex fast Fourier transform.
@var{y} is a list or array (named or unnamed) which contains the data to
transform.  The number of elements must be a power of 2.
The elements must be literal numbers (integers, rationals, floats, or bigfloats)
or symbolic constants,
or expressions @code{a + b*%i} where @code{a} and @code{b} are literal numbers
or symbolic constants.

@code{inverse_fft} returns a new object of the same type as @var{y},
which is not modified.
Results are always computed as floats
or expressions @code{a + b*%i} where @code{a} and @code{b} are floats.
If bigfloat precision is needed the function @mref{bf_inverse_fft} can
be used instead as a drop-in replacement of @code{inverse_fft} that is
slower, but supports bfloats. 

The inverse discrete Fourier transform is defined as follows.
Let @code{x} be the output of the inverse transform.
Then for @code{j} from 0 through @code{n - 1},

@example
x[j] = sum(y[k] exp(-2 %i %pi j k / n), k, 0, n - 1)
@end example

As there are various sign and normalization conventions possible,
this definition of the transform may differ from that used by other mathematical software.

@code{load(fft)} loads this function.

See also @mref{fft} (forward transform), @mrefcomma{recttopolar} and
@mrefdot{polartorect}

Examples:

Real data.

@c ===beg===
@c load ("fft") $
@c fpprintprec : 4 $
@c L : [1, 2, 3, 4, -1, -2, -3, -4] $
@c L1 : inverse_fft (L);
@c L2 : fft (L1);
@c lmax (abs (L2 - L));
@c ===end===
@example
(%i1) load ("fft") $
(%i2) fpprintprec : 4 $
(%i3) L : [1, 2, 3, 4, -1, -2, -3, -4] $
(%i4) L1 : inverse_fft (L);
(%o4) [0.0, 14.49 %i - .8284, 0.0, 2.485 %i + 4.828, 0.0, 
                       4.828 - 2.485 %i, 0.0, - 14.49 %i - .8284]
(%i5) L2 : fft (L1);
(%o5) [1.0, 2.0 - 2.168L-19 %i, 3.0 - 7.525L-20 %i, 
4.0 - 4.256L-19 %i, - 1.0, 2.168L-19 %i - 2.0, 
7.525L-20 %i - 3.0, 4.256L-19 %i - 4.0]
(%i6) lmax (abs (L2 - L));
(%o6)                       3.545L-16
@end example

Complex data.

@c ===beg===
@c load ("fft") $
@c fpprintprec : 4 $
@c L : [1, 1 + %i, 1 - %i, -1, -1, 1 - %i, 1 + %i, 1] $
@c L1 : inverse_fft (L);
@c L2 : fft (L1);
@c lmax (abs (L2 - L));
@c ===end===
@example
(%i1) load ("fft") $
(%i2) fpprintprec : 4 $                 
(%i3) L : [1, 1 + %i, 1 - %i, -1, -1, 1 - %i, 1 + %i, 1] $
(%i4) L1 : inverse_fft (L);
(%o4) [4.0, 2.711L-19 %i + 4.0, 2.0 %i - 2.0, 
- 2.828 %i - 2.828, 0.0, 5.421L-20 %i + 4.0, - 2.0 %i - 2.0, 
2.828 %i + 2.828]
(%i5) L2 : fft (L1);
(%o5) [4.066E-20 %i + 1.0, 1.0 %i + 1.0, 1.0 - 1.0 %i, 
1.55L-19 %i - 1.0, - 4.066E-20 %i - 1.0, 1.0 - 1.0 %i, 
1.0 %i + 1.0, 1.0 - 7.368L-20 %i]
(%i6) lmax (abs (L2 - L));                    
(%o6)                       6.841L-17
@end example

@opencatbox
@category{Package fft}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{fft}
@deffn {Function} fft (@var{x})

Computes the complex fast Fourier transform.
@var{x} is a list or array (named or unnamed) which contains the data to
transform.  The number of elements must be a power of 2.
The elements must be literal numbers (integers, rationals, floats, or bigfloats)
or symbolic constants,
or expressions @code{a + b*%i} where @code{a} and @code{b} are literal numbers
or symbolic constants.

@code{fft} returns a new object of the same type as @var{x},
which is not modified.
Results are always computed as floats
or expressions @code{a + b*%i} where @code{a} and @code{b} are floats.
If bigfloat precision is needed the function @mref{bf_fft} can be used
instead as a drop-in replacement of @code{fft} that is slower, but
supports bfloats. In addition if it is known that the input consists
of only real values (no imaginary parts), @mref{real_fft} can be used
which is potentially faster.

The discrete Fourier transform is defined as follows.
Let @code{y} be the output of the transform.
Then for @code{k} from 0 through @code{n - 1},

@example
y[k] = (1/n) sum(x[j] exp(+2 %i %pi j k / n), j, 0, n - 1)
@end example

As there are various sign and normalization conventions possible,
this definition of the transform may differ from that used by other mathematical software.

When the data @var{x} are real,
real coefficients @code{a} and @code{b} can be computed such that

@example
x[j] = sum(a[k]*cos(2*%pi*j*k/n)+b[k]*sin(2*%pi*j*k/n), k, 0, n/2)
@end example

with

@example
a[0] = realpart (y[0])
b[0] = 0
@end example

and, for k from 1 through n/2 - 1,

@example
a[k] = realpart (y[k] + y[n - k])
b[k] = imagpart (y[n - k] - y[k])
@end example

and

@example
a[n/2] = realpart (y[n/2])
b[n/2] = 0
@end example

@code{load(fft)} loads this function.

See also @mref{inverse_fft} (inverse transform), @mrefcomma{recttopolar} and
@mrefdot{polartorect}. See @mref{real_fft} for FFTs of a real-valued
input, and @mref{bf_fft} and @mref{bf_real_fft} for operations on
bigfloat values.

Examples:

Real data.

@c ===beg===
@c load ("fft") $
@c fpprintprec : 4 $
@c L : [1, 2, 3, 4, -1, -2, -3, -4] $
@c L1 : fft (L);
@c L2 : inverse_fft (L1);
@c lmax (abs (L2 - L));
@c ===end===
@example
(%i1) load ("fft") $
(%i2) fpprintprec : 4 $
(%i3) L : [1, 2, 3, 4, -1, -2, -3, -4] $
(%i4) L1 : fft (L);
(%o4) [0.0, - 1.811 %i - .1036, 0.0, .6036 - .3107 %i, 0.0, 
                         .3107 %i + .6036, 0.0, 1.811 %i - .1036]
(%i5) L2 : inverse_fft (L1);
(%o5) [1.0, 2.168L-19 %i + 2.0, 7.525L-20 %i + 3.0, 
4.256L-19 %i + 4.0, - 1.0, - 2.168L-19 %i - 2.0, 
- 7.525L-20 %i - 3.0, - 4.256L-19 %i - 4.0]
(%i6) lmax (abs (L2 - L));
(%o6)                       3.545L-16
@end example

Complex data.

@c ===beg===
@c load ("fft") $
@c fpprintprec : 4 $
@c L : [1, 1 + %i, 1 - %i, -1, -1, 1 - %i, 1 + %i, 1] $
@c L1 : fft (L);
@c L2 : inverse_fft (L1);
@c lmax (abs (L2 - L));
@c ===end===
@example
(%i1) load ("fft") $
(%i2) fpprintprec : 4 $
(%i3) L : [1, 1 + %i, 1 - %i, -1, -1, 1 - %i, 1 + %i, 1] $
(%i4) L1 : fft (L);
(%o4) [0.5, .3536 %i + .3536, - 0.25 %i - 0.25, 
0.5 - 6.776L-21 %i, 0.0, - .3536 %i - .3536, 0.25 %i - 0.25, 
0.5 - 3.388L-20 %i]
(%i5) L2 : inverse_fft (L1);
(%o5) [1.0 - 4.066E-20 %i, 1.0 %i + 1.0, 1.0 - 1.0 %i, 
- 1.008L-19 %i - 1.0, 4.066E-20 %i - 1.0, 1.0 - 1.0 %i, 
1.0 %i + 1.0, 1.947L-20 %i + 1.0]
(%i6) lmax (abs (L2 - L));
(%o6)                       6.83L-17
@end example

Computation of sine and cosine coefficients.

@c ===beg===
@c load ("fft") $
@c fpprintprec : 4 $
@c L : [1, 2, 3, 4, 5, 6, 7, 8] $
@c n : length (L) $
@c x : make_array (any, n) $
@c fillarray (x, L) $
@c y : fft (x) $
@c a : make_array (any, n/2 + 1) $
@c b : make_array (any, n/2 + 1) $
@c a[0] : realpart (y[0]) $
@c b[0] : 0 $
@c for k : 1 thru n/2 - 1 do
@c    (a[k] : realpart (y[k] + y[n - k]),
@c     b[k] : imagpart (y[n - k] - y[k]));
@c a[n/2] : y[n/2] $
@c b[n/2] : 0 $
@c listarray (a);
@c listarray (b);
@c f(j) := sum (a[k] * cos (2*%pi*j*k / n) + b[k] * sin (2*%pi*j*k / n), k, 0, n/2) $
@c makelist (float (f (j)), j, 0, n - 1);
@c ===end===
@example
(%i1) load ("fft") $
(%i2) fpprintprec : 4 $
(%i3) L : [1, 2, 3, 4, 5, 6, 7, 8] $
(%i4) n : length (L) $
(%i5) x : make_array (any, n) $
(%i6) fillarray (x, L) $
(%i7) y : fft (x) $
(%i8) a : make_array (any, n/2 + 1) $
(%i9) b : make_array (any, n/2 + 1) $
(%i10) a[0] : realpart (y[0]) $
(%i11) b[0] : 0 $
(%i12) for k : 1 thru n/2 - 1 do
   (a[k] : realpart (y[k] + y[n - k]),
    b[k] : imagpart (y[n - k] - y[k]));
(%o12)                        done
(%i13) a[n/2] : y[n/2] $
(%i14) b[n/2] : 0 $
(%i15) listarray (a);
(%o15)          [4.5, - 1.0, - 1.0, - 1.0, - 0.5]
(%i16) listarray (b);
(%o16)           [0, - 2.414, - 1.0, - .4142, 0]
(%i17) f(j) := sum (a[k]*cos(2*%pi*j*k/n) + b[k]*sin(2*%pi*j*k/n), 
                    k, 0, n/2) $
(%i18) makelist (float (f (j)), j, 0, n - 1);
(%o18)      [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]
@end example

@opencatbox
@category{Package fft}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{real_fft}
@deffn {Function} real_fft (@var{x})

Computes the fast Fourier transform of a real-valued sequence
@var{x}.  This is equivalent to performing @code{fft(x)}, except that
only the first @code{N/2+1} results are returned, where @code{N} is
the length of @var{x}.  @code{N} must be power of two.

No check is made that @var{x} contains only real values.

The symmetry properites of the Fourier transform of real sequences to
reduce he complexity.  In particular the first and last output values
of @code{real_fft} are purely real.  For larger sequencyes, @code{real_fft}
may be computed more quickly than @code{fft}.

Since the output length is short, the normal @mref{inverse_fft} cannot
be directly used.  Use @mref{inverse_real_fft} to compute the inverse.
@opencatbox
@category{Package fft}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{inverse_real_fft}
@deffn {Function} inverse_real_fft (@var{y})
Computes the inverse Fourier transfrom of @var{y}, which must have a
length of @code{N/2+1} where @code{N} is a power of two.  That is, the
input @var{x} is expected to be the output of @code{real_fft}.

No check is made to ensure that the input has the correct format.
(The first and last elements must be purely real.)

@opencatbox
@category{Package fft}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{bf_inverse_fft}
@deffn {Function} bf_inverse_fft (@var{y})

Computes the inverse complex fast Fourier transform.  This is the
bigfloat version of @mref{inverse_fft} that converts the input to
bigfloats and returns a bigfloat result.
@opencatbox
@category{Package fft}
@closecatbox
@end deffn

@anchor{bf_fft}
@deffn {Function} bf_fft (@var{y})

Computes the forward complex fast Fourier transform.  This is the
bigfloat version of @mref{fft} that converts the input to
bigfloats and returns a bigfloat result.
@opencatbox
@category{Package fft}
@closecatbox
@end deffn

@anchor{bf_real_fft}
@deffn {Function} bf_real_fft (@var{x})

Computes the forward fast Fourier transform of a real-valued input
returning a bigfloat result.  This is the bigfloat version of
@code{real_fft}.

@opencatbox
@category{Package fft}
@closecatbox
@end deffn

@anchor{bf_inverse_real_fft}
@deffn {Function} bf_inverse_real_fft (@var{y})
Computes the inverse fast Fourier transfrom with a real-valued
bigfloat output.  This is the bigfloat version of @code{inverse_real_fft}.

@opencatbox
@category{Package fft}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@node Functions for numerical solution of equations, Introduction to numerical solution of differential equations, Functions and Variables for fast Fourier transform, Numerical
@section Functions for numerical solution of equations
@c -----------------------------------------------------------------------------

@anchor{horner}
@deffn  {Function} horner @
@fname{horner} (@var{expr}, @var{x}) @
@fname{horner} (@var{expr})

Returns a rearranged representation of @var{expr} as in Horner's rule, using
@var{x} as the main variable if it is specified.  @code{x} may be omitted in
which case the main variable of the canonical rational expression form of
@var{expr} is used.

@code{horner} sometimes improves stability if @code{expr} is
to be numerically evaluated.  It is also useful if Maxima is used to
generate programs to be run in Fortran.  See also @mrefdot{stringout}

@c ===beg===
@c expr: 1e-155*x^2 - 5.5*x + 5.2e155;
@c expr2: horner (%, x), keepfloat: true;
@c ev (expr, x=1e155);
@c ev (expr2, x=1e155);
@c ===end===
@example
(%i1) expr: 1e-155*x^2 - 5.5*x + 5.2e155;
                           2
(%o1)             1.e-155 x  - 5.5 x + 5.2e+155
(%i2) expr2: horner (%, x), keepfloat: true;
(%o2)         1.0 ((1.e-155 x - 5.5) x + 5.2e+155)
(%i3) ev (expr, x=1e155);
Maxima encountered a Lisp error:

 arithmetic error FLOATING-POINT-OVERFLOW signalled

Automatically continuing.
To enable the Lisp debugger set *debugger-hook* to nil.
(%i4) ev (expr2, x=1e155);
(%o4)                 7.00000000000001e+154
@end example

@opencatbox
@category{Numerical methods}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{find_root}
@anchor{bf_find_root}
@anchor{find_root_error}
@anchor{find_root_abs}
@anchor{find_root_rel}
@deffn  {Function} find_root (@var{expr}, @var{x}, @var{a}, @var{b}, [@var{abserr}, @var{relerr}])
@deffnx {Function} find_root (@var{f}, @var{a}, @var{b}, [@var{abserr}, @var{relerr}])
@deffnx {Function} bf_find_root (@var{expr}, @var{x}, @var{a}, @var{b}, [@var{abserr}, @var{relerr}])
@deffnx {Function} bf_find_root (@var{f}, @var{a}, @var{b}, [@var{abserr}, @var{relerr}])
@deffnx {Option variable} find_root_error
@deffnx {Option variable} find_root_abs
@deffnx {Option variable} find_root_rel

Finds a root of the expression @var{expr} or the function @var{f} over the
closed interval @math{[@var{a}, @var{b}]}.  The expression @var{expr} may be an
equation, in which case @mref{find_root} seeks a root of
@code{lhs(@var{expr}) - rhs(@var{expr})}.

Given that Maxima can evaluate @var{expr} or @var{f} over
@math{[@var{a}, @var{b}]} and that @var{expr} or @var{f} is continuous,
@code{find_root} is guaranteed to find the root,
or one of the roots if there is more than one.

@code{find_root} initially applies binary search.
If the function in question appears to be smooth enough,
@code{find_root} applies linear interpolation instead.

@code{bf_find_root} is a bigfloat version of @code{find_root}.  The
function is computed using bigfloat arithmetic and a bigfloat result
is returned.  Otherwise, @code{bf_find_root} is identical to
@code{find_root}, and the following description is equally applicable
to @code{bf_find_root}.

The accuracy of @code{find_root} is governed by @code{abserr} and
@code{relerr}, which are optional keyword arguments to
@code{find_root}.  These keyword arguments take the form
@code{key=val}.  The keyword arguments are

@table @code
@item abserr
Desired absolute error of function value at root.  Default is
@code{find_root_abs}.
@item relerr
Desired relative error of root.  Default is @code{find_root_rel}.
@end table

@code{find_root} stops when the function in question evaluates to
something less than or equal to @code{abserr}, or if successive
approximants @var{x_0}, @var{x_1} differ by no more than @code{relerr
* max(abs(x_0), abs(x_1))}.  The default values of
@code{find_root_abs} and @code{find_root_rel} are both zero.

@code{find_root} expects the function in question to have a different sign at
the endpoints of the search interval.
When the function evaluates to a number at both endpoints
and these numbers have the same sign,
the behavior of @code{find_root} is governed by @code{find_root_error}.
When @code{find_root_error} is @code{true},
@code{find_root} prints an error message.
Otherwise @code{find_root} returns the value of @code{find_root_error}.
The default value of @code{find_root_error} is @code{true}.

If @var{f} evaluates to something other than a number at any step in the search
algorithm, @code{find_root} returns a partially-evaluated @code{find_root}
expression.

The order of @var{a} and @var{b} is ignored; the region in which a root is
sought is @math{[min(@var{a}, @var{b}), max(@var{a}, @var{b})]}.

Examples:

@c PREVIOUS EXAMPLE STUFF -- MAY WANT TO BRING TRANSLATE BACK INTO THE EXAMPLE
@c f(x):=(mode_declare(x,float),sin(x)-x/2.0);
@c interpolate(sin(x)-x/2,x,0.1,%pi)       time= 60 msec
@c interpolate(f(x),x,0.1,%pi);            time= 68 msec
@c translate(f);
@c interpolate(f(x),x,0.1,%pi);            time= 26 msec
@c interpolate(f,0.1,%pi);                 time=  5 msec

@c ===beg===
@c f(x) := sin(x) - x/2;
@c find_root (sin(x) - x/2, x, 0.1, %pi);
@c find_root (sin(x) = x/2, x, 0.1, %pi);
@c find_root (f(x), x, 0.1, %pi);
@c find_root (f, 0.1, %pi);
@c find_root (exp(x) = y, x, 0, 100);
@c find_root (exp(x) = y, x, 0, 100), y = 10;
@c log (10.0);
@c fpprec:32;
@c 32;
@c bf_find_root (exp(x) = y, x, 0, 100), y = 10;
@c log(10b0);
@c ===end===
@example
(%i1) f(x) := sin(x) - x/2;
                                        x
(%o1)                  f(x) := sin(x) - -
                                        2
(%i2) find_root (sin(x) - x/2, x, 0.1, %pi);
(%o2)                   1.895494267033981
(%i3) find_root (sin(x) = x/2, x, 0.1, %pi);
(%o3)                   1.895494267033981
(%i4) find_root (f(x), x, 0.1, %pi);
(%o4)                   1.895494267033981
(%i5) find_root (f, 0.1, %pi);
(%o5)                   1.895494267033981
(%i6) find_root (exp(x) = y, x, 0, 100);
                            x
(%o6)           find_root(%e  = y, x, 0.0, 100.0)
(%i7) find_root (exp(x) = y, x, 0, 100), y = 10;
(%o7)                   2.302585092994046
(%i8) log (10.0);
(%o8)                   2.302585092994046
(%i9) fpprec:32;
(%o9)                           32
(%i10) bf_find_root (exp(x) = y, x, 0, 100), y = 10;
(%o10)                  2.3025850929940456840179914546844b0
(%i11) log(10b0);
(%o11)                  2.3025850929940456840179914546844b0
@end example

@opencatbox
@category{Algebraic equations} @category{Numerical methods}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{newton}
@deffn {Function} newton (@var{expr}, @var{x}, @var{x_0}, @var{eps})

Returns an approximate solution of @code{@var{expr} = 0} by Newton's method,
considering @var{expr} to be a function of one variable, @var{x}.
The search begins with @code{@var{x} = @var{x_0}}
and proceeds until @code{abs(@var{expr}) < @var{eps}}
(with @var{expr} evaluated at the current value of @var{x}).

@code{newton} allows undefined variables to appear in @var{expr},
so long as the termination test @code{abs(@var{expr}) < @var{eps}} evaluates
to @code{true} or @code{false}.
Thus it is not necessary that @var{expr} evaluate to a number.

@code{load(newton1)} loads this function.

See also @mrefcomma{realroots} @mrefcomma{allroots} @mref{find_root} and
@ref{mnewton-pkg}

Examples:

@c ===beg===
@c load ("newton1");
@c newton (cos (u), u, 1, 1/100);
@c ev (cos (u), u = %);
@c assume (a > 0);
@c newton (x^2 - a^2, x, a/2, a^2/100);
@c ev (x^2 - a^2, x = %);
@c ===end===
@example
(%i1) load ("newton1");
(%o1)  /maxima/share/numeric/newton1.mac
(%i2) newton (cos (u), u, 1, 1/100);
(%o2)                   1.570675277161251
(%i3) ev (cos (u), u = %);
(%o3)                 1.2104963335033529e-4
(%i4) assume (a > 0);
(%o4)                        [a > 0]
(%i5) newton (x^2 - a^2, x, a/2, a^2/100);
(%o5)                  1.00030487804878 a
(%i6) ev (x^2 - a^2, x = %);
                                           2
(%o6)                6.098490481853958e-4 a
@end example

@opencatbox
@category{Algebraic equations} @category{Numerical methods}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@node Introduction to numerical solution of differential equations, Functions for numerical solution of differential equations, Functions for numerical solution of equations, Numerical
@section Introduction to numerical solution of differential equations
@c -----------------------------------------------------------------------------

The Ordinary Differential Equations (ODE) solved by the functions in this
section should have the form,
@ifnottex
@example
       dy
       -- = F(x,y)
       dx
@end example
@end ifnottex
@tex
$${{dy}\over{dx}} = F(x,y)$$
@end tex
which is a first-order ODE. Higher order differential equations of order
@var{n} must be written as a system of @var{n} first-order equations of that
kind. For instance, a second-order ODE should be written as a system of two
equations
@ifnottex
@example
       dx               dy
       -- = G(x,y,t)    -- = F(x,y,t) 
       dt               dt
@end example
@end ifnottex
@tex
$${{dx}\over{dt}} = G(x,y,t) \qquad {{dy}\over{dt}} = F(x,y,t)$$
@end tex

The first argument in the functions will be a list with the expressions on
the right-side of the ODE's. The variables whose derivatives are represented
by those expressions should be given in a second list. In the case above those
variables are @var{x} and @var{y}. The independent variable, @var{t} in the
examples above, might be given in a separated option. If the expressions
given do not depend on that independent variable, the system is called
autonomous.

@opencatbox
@category{Differential equations} @category{Numerical methods} @category{Plotting}
@closecatbox


@c -----------------------------------------------------------------------------
@node Functions for numerical solution of differential equations, , Introduction to numerical solution of differential equations, Numerical
@section Functions for numerical solution of differential equations
@c -----------------------------------------------------------------------------
@deffn {Function} plotdf @
@fname{plotdf} (@var{dydx}, options@dots{}) @
@fname{plotdf} (@var{dvdu}, [@var{u},@var{v}], options@dots{}) @
@fname{plotdf} ([@var{dxdt},c@var{dydt}], options@dots{}) @
@fname{plotdf} ([@var{dudt},c@var{dvdt}], [@var{u},c@var{v}], options@dots{})

The function @code{plotdf} creates a two-dimensional plot of the direction
field (also called slope field) for a first-order Ordinary Differential
Equation (ODE) or a system of two autonomous first-order ODE's.

Plotdf requires Xmaxima, even if its run from a Maxima session in
a console, since the plot will be created by the Tk scripts in Xmaxima.
If Xmaxima is not installed plotdf will not work.

@var{dydx}, @var{dxdt} and @var{dydt} are expressions that depend on
@var{x} and @var{y}. @var{dvdu}, @var{dudt} and @var{dvdt} are
expressions that depend on @var{u} and @var{v}. In addition to those two
variables, the expressions can also depend on a set of parameters, with
numerical values given with the @code{parameters} option (the option
syntax is given below), or with a range of allowed values specified by a
@var{sliders} option.

Several other options can be given within the command, or selected in
the menu. Integral curves can be obtained by clicking on the plot, or
with the option @code{trajectory_at}. The direction of the integration
can be controlled with the @code{direction} option, which can have
values of @emph{forward}, @emph{backward} or @emph{both}. The number of
integration steps is given by @code{nsteps}; at each integration
step the time increment will be adjusted automatically to produce
displacements much smaller than the size of the plot window. The
numerical method used is 4th order Runge-Kutta with variable time steps.

@b{Plot window menu:}

The menu bar of the plot window has the following seven icons:

An X. Can be used to close the plot window.

A wrench and a screwdriver. Opens the configuration menu with several
fields that show the ODE(s) in use and various other settings. If a pair
of coordinates are entered in the field @emph{Trajectory at} and the
@key{enter} key is pressed, a new integral curve will be shown, in
addition to the ones already shown.

Two arrows following a circle. Replots the direction field with the
new settings defined in the configuration menu and replots only the last
integral curve that was previously plotted.

Hard disk drive with an arrow. Used to save a copy of the
plot, in Postscript format, in the file specified in a field of the
box that appears when that icon is clicked.

Magnifying glass with a plus sign. Zooms in the plot.

Magnifying glass with a minus sign. Zooms out the plot. The plot can be
displaced by holding down the right mouse button while the mouse is
moved.

Icon of a plot. Opens another window with a plot of the two variables
in terms of time, for the last integral curve that was plotted.

@b{Plot options:}

Options can also be given within the @code{plotdf} itself, each one being
a list of two or more elements. The first element in each option is the name
of the option, and the remainder is the value or values assigned to the
option.

The options which are recognized by @code{plotdf} are the following:

@itemize @bullet
@item
@dfn{nsteps} defines the number of steps that will be used for the
independent variable, to compute an integral curve. The default value is
100.

@item
@dfn{direction} defines the direction of the independent
variable that will be followed to compute an integral curve. Possible
values are @code{forward}, to make the independent variable increase
@code{nsteps} times, with increments @code{tstep}, @code{backward}, to
make the independent variable decrease, or @code{both} that will lead to
an integral curve that extends @code{nsteps} forward, and @code{nsteps}
backward. The keywords @code{right} and @code{left} can be used as
synonyms for @code{forward} and @code{backward}.
The default value is @code{both}.

@item
@dfn{tinitial} defines the initial value of variable @var{t} used
to compute integral curves. Since the differential equations are
autonomous, that setting will only appear in the plot of the curves as
functions of @var{t}. 
The default value is 0.

@item
@dfn{versus_t} is used to create a second plot window, with a
plot of an integral curve, as two functions @var{x}, @var{y}, of the
independent variable @var{t}. If @code{versus_t} is given any value
different from 0, the second plot window will be displayed. The second
plot window includes another menu, similar to the menu of the main plot
window.
The default value is 0.

@item
@dfn{trajectory_at} defines the coordinates @var{xinitial} and
@var{yinitial} for the starting point of an integral curve.
The option is empty by default.

@item
@dfn{parameters} defines a list of parameters, and their
numerical values, used in the definition of the differential
equations. The name and values of the parameters must be given in a
string with a comma-separated sequence of pairs @code{name=value}.

@item
@dfn{sliders} defines a list of parameters that will be changed
interactively using slider buttons, and the range of variation of those
parameters. The names and ranges of the parameters must be given in a
string with a comma-separated sequence of elements @code{name=min:max}

@item
@dfn{xfun} defines a string with semi-colon-separated sequence
of functions of @var{x} to be displayed, on top of the direction field.
Those functions will be parsed by Tcl and not by Maxima.

@item
@dfn{x} should be followed by two numbers, which will set up the minimum
and maximum values shown on the horizontal axis. If the variable on the
horizontal axis is not @var{x}, then this option should have the name of
the variable on the horizontal axis.
The default horizontal range is from -10 to 10.

@item
@dfn{y} should be followed by two numbers, which will set up the minimum
and maximum values shown on the vertical axis. If the variable on the
vertical axis is not @var{y}, then this option should have the name of
the variable on the vertical axis.
The default vertical range is from -10 to 10.

@item
@dfn{xaxislabel} will be used to identify the horizontal axis. Its default value is the name of the first state variable.

@item
@dfn{yaxislabel} will be used to identify the vertical axis. Its default value is the name of the second state variable.

@item
@dfn{number_of_arrows} should be set to a square number and defines the approximate
density of the arrows being drawn. The default value is 225.
@end itemize

@strong{Examples:}

@itemize @bullet
@item
To show the direction field of the differential equation @math{y' = exp(-x) + y} and the solution that goes through @math{(2, -0.1)}:
@c ===beg===
@c plotdf(exp(-x)+y,[trajectory_at,2,-0.1])$
@c ===end===
@example
(%i1) plotdf(exp(-x)+y,[trajectory_at,2,-0.1])$
@end example

@ifnotinfo
@image{figures/plotdf1,8cm}
@end ifnotinfo

@item
To obtain the direction field for the equation @math{diff(y,x) = x - y^2} and the solution with initial condition @math{y(-1) = 3}, we can use the command:
@c ===beg===
@c plotdf(x-y^2,[xfun,"sqrt(x);-sqrt(x)"],
@c          [trajectory_at,-1,3], [direction,forward],
@c          [y,-5,5], [x,-4,16])$
@c ===end===
@example
@group
(%i1) plotdf(x-y^2,[xfun,"sqrt(x);-sqrt(x)"],
         [trajectory_at,-1,3], [direction,forward],
         [y,-5,5], [x,-4,16])$
@end group
@end example

The graph also shows the function @math{y = sqrt(x)}. 

@ifnotinfo
@image{figures/plotdf2,8cm}
@end ifnotinfo

@item
The following example shows the direction field of a harmonic oscillator,
defined by the two equations @math{dz/dt = v} and @math{dv/dt = -k*z/m},
and the integral curve through @math{(z,v) = (6,0)}, with a slider that
will allow you to change the value of @math{m} interactively (@math{k} is
fixed at 2):
@c ===beg===
@c plotdf([v,-k*z/m], [z,v], [parameters,"m=2,k=2"],
@c            [sliders,"m=1:5"], [trajectory_at,6,0])$
@c ===end===
@example
@group
(%i1) plotdf([v,-k*z/m], [z,v], [parameters,"m=2,k=2"],
           [sliders,"m=1:5"], [trajectory_at,6,0])$
@end group
@end example

@ifnotinfo
@image{figures/plotdf3,8cm}
@end ifnotinfo

@item
To plot the direction field of the Duffing equation, @math{m*x''+c*x'+k*x+b*x^3 = 0}, we introduce the variable @math{y=x'} and use:
@c ===beg===
@c plotdf([y,-(k*x + c*y + b*x^3)/m],
@c              [parameters,"k=-1,m=1.0,c=0,b=1"],
@c              [sliders,"k=-2:2,m=-1:1"],[tstep,0.1])$
@c ===end===
@example
@group
(%i1) plotdf([y,-(k*x + c*y + b*x^3)/m],
             [parameters,"k=-1,m=1.0,c=0,b=1"],
             [sliders,"k=-2:2,m=-1:1"],[tstep,0.1])$
@end group
@end example

@ifnotinfo
@image{figures/plotdf4,8cm}
@end ifnotinfo

@item
The direction field for a damped pendulum, including the
solution for the given initial conditions, with a slider that
can be used to change the value of the mass @math{m}, and with a plot of
the two state variables as a function of time:

@c ===beg===
@c plotdf([w,-g*sin(a)/l - b*w/m/l], [a,w],
@c         [parameters,"g=9.8,l=0.5,m=0.3,b=0.05"],
@c         [trajectory_at,1.05,-9],[tstep,0.01],
@c         [a,-10,2], [w,-14,14], [direction,forward],
@c         [nsteps,300], [sliders,"m=0.1:1"], [versus_t,1])$
@c ===end===
@example
@group
(%i1) plotdf([w,-g*sin(a)/l - b*w/m/l], [a,w],
        [parameters,"g=9.8,l=0.5,m=0.3,b=0.05"],
        [trajectory_at,1.05,-9],[tstep,0.01],
        [a,-10,2], [w,-14,14], [direction,forward],
        [nsteps,300], [sliders,"m=0.1:1"], [versus_t,1])$
@end group
@end example

@ifnotinfo
@image{figures/plotdf5,8cm}@image{figures/plotdf6,8cm}
@end ifnotinfo

@end itemize

@opencatbox
@category{Differential equations} @category{Plotting} @category{Numerical methods}
@closecatbox

@end deffn

@deffn {Function} ploteq (@var{exp}, ...options...)

Plots equipotential curves for @var{exp}, which should be an expression
depending on two variables. The curves are obtained by integrating the
differential equation that define the orthogonal trajectories to the solutions
of the autonomous system obtained from the gradient of the expression given.
The plot can also show the integral curves for that gradient system (option
fieldlines).

This program also requires Xmaxima, even if its run from a Maxima session in
a console, since the plot will be created by the Tk scripts in Xmaxima.
By default, the plot region will be empty until the user clicks in a point
(or gives its coordinate with in the set-up menu or via the trajectory_at option).

Most options accepted by plotdf can also be used for ploteq and the plot
interface is the same that was described in plotdf.

Example:

@c ===beg===
@c V: 900/((x+1)^2+y^2)^(1/2)-900/((x-1)^2+y^2)^(1/2)$
@c ploteq(V,[x,-2,2],[y,-2,2],[fieldlines,"blue"])$
@c ===end===
@example
(%i1) V: 900/((x+1)^2+y^2)^(1/2)-900/((x-1)^2+y^2)^(1/2)$
(%i2) ploteq(V,[x,-2,2],[y,-2,2],[fieldlines,"blue"])$
@end example

Clicking on a point will plot the equipotential curve that passes by that point
(in red) and the orthogonal trajectory (in blue).

@opencatbox
@category{Differential equations} @category{Plotting} @category{Numerical methods}
@closecatbox

@end deffn

@deffn {Function} rk @
@fname{rk} (@var{ODE}, @var{var}, @var{initial}, @var{domain}) @
@fname{rk} ([@var{ODE1}, @dots{}, @var{ODEm}], [@var{v1}, @dots{}, @var{vm}], [@var{init1}, @dots{}, @var{initm}], @var{domain})

The first form solves numerically one first-order ordinary differential
equation, and the second form solves a system of m of those equations,
using the 4th order Runge-Kutta method. @var{var} represents the dependent
variable. @var{ODE} must be an expression that depends only on the independent
and dependent variables and defines the derivative of the dependent
variable with respect to the independent variable.

The independent variable is specified with @code{domain}, which must be a
list of four elements as, for instance:
@example
[t, 0, 10, 0.1]
@end example
the first element of the list identifies the independent variable, the
second and third elements are the initial and final values for that
variable, and the last element sets the increments that should be used
within that interval.

If @var{m} equations are going to be solved, there should be @var{m}
dependent variables @var{v1}, @var{v2}, ..., @var{vm}. The initial values
for those variables will be @var{init1}, @var{init2}, ..., @var{initm}.
There will still be just one independent variable defined by @code{domain},
as in the previous case. @var{ODE1}, ..., @var{ODEm} are the expressions
that define the derivatives of each dependent variable in
terms of the independent variable. The only variables that may appear in
those expressions are the independent variable and any of the dependent
variables. It is important to give the derivatives @var{ODE1}, ...,
@var{ODEm} in the list in exactly the same order used for the dependent
variables; for instance, the third element in the list will be interpreted
as the derivative of the third dependent variable.

The program will try to integrate the equations from the initial value
of the independent variable until its last value, using constant
increments. If at some step one of the dependent variables takes an
absolute value too large, the integration will be interrupted at that
point. The result will be a list with as many elements as the number of
iterations made. Each element in the results list is itself another list
with @var{m}+1 elements: the value of the independent variable, followed
by the values of the dependent variables corresponding to that point.

To solve numerically the differential equation

@ifnottex
@example
          dx/dt = t - x^2
@end example
@end ifnottex
@tex
$${{dx}\over{dt}} = t - x^2$$ 
@end tex

With initial value x(t=0) = 1, in the interval of t from 0 to 8 and with
increments of 0.1 for t, use:

@c ===beg===
@c results: rk(t-x^2,x,1,[t,0,8,0.1])$
@c plot2d ([discrete, results])$
@c ===end===
@example
(%i1) results: rk(t-x^2,x,1,[t,0,8,0.1])$
(%i2) plot2d ([discrete, results])$
@end example

the results will be saved in the list @code{results} and the plot will show the solution obtained, with @var{t} on the horizontal axis and @var{x} on the vertical axis.

To solve numerically the system:

@ifnottex
@example
        dx/dt = 4-x^2-4*y^2     dy/dt = y^2-x^2+1
@end example
@end ifnottex
@tex
$$\cases{{\displaystyle{dx}\over\displaystyle{dt}} = 4-x^2-4y^2 &\cr &\cr {\displaystyle{dy}\over\displaystyle{dt}} = y^2-x^2+1}$$
@end tex

for t between 0 and 4, and with values of -1.25 and 0.75 for x and y at t=0:

@c ===beg===
@c sol: rk([4-x^2-4*y^2,y^2-x^2+1],[x,y],[-1.25,0.75],[t,0,4,0.02])$
@c plot2d ([discrete,makelist([p[1],p[3]],p,sol)], [xlabel,"t"],[ylabel,"y"])$
@c ===end===
@example
(%i1) sol: rk([4-x^2-4*y^2,y^2-x^2+1],[x,y],[-1.25,0.75],[t,0,4,0.02])$
(%i2) plot2d ([discrete,makelist([p[1],p[3]],p,sol)], [xlabel,"t"],[ylabel,"y"])$
@end example

The plot will show the solution for variable @var{y} as a function of @var{t}.

@opencatbox
@category{Differential equations} @category{Numerical methods}
@closecatbox

@end deffn
