@c -*- Mode: texinfo -*-
@menu
* Introduction to Special Functions::
* Bessel Functions::
* Airy Functions::
* Gamma and factorial Functions::
* Exponential Integrals::
* Error Function::
* Struve Functions::
* Hypergeometric Functions::
* Parabolic Cylinder Functions::
* Functions and Variables for Special Functions::  
@end menu

@c -----------------------------------------------------------------------------
@node Introduction to Special Functions, Bessel Functions, Special Functions, Special Functions
@section Introduction to Special Functions
@c -----------------------------------------------------------------------------

Special function notation follows:

@example
bessel_j (index, expr)         Bessel function, 1st kind
bessel_y (index, expr)         Bessel function, 2nd kind
bessel_i (index, expr)         Modified Bessel function, 1st kind
bessel_k (index, expr)         Modified Bessel function, 2nd kind

hankel_1 (v,z)                 Hankel function of the 1st kind
hankel_2 (v,z)                 Hankel function of the 2nd kind
struve_h (v,z)                 Struve H function
struve_l (v,z)                 Struve L function

assoc_legendre_p[v,u] (z)      Legendre function of degree v and order u 
assoc_legendre_q[v,u] (z)      Legendre function, 2nd kind

%f[p,q] ([], [], expr)         Generalized Hypergeometric function
gamma (z)                      Gamma function
gamma_incomplete_lower (a,z)   Lower incomplete gamma function
gamma_incomplete (a,z)         Tail of incomplete gamma function
hypergeometric (l1, l2, z)     Hypergeometric function
@c IS slommel THE "LOMMEL" FUNCTION ?? NOT OTHERWISE MENTIONED IN TEXINFO FILES
slommel
%m[u,k] (z)                    Whittaker function, 1st kind
%w[u,k] (z)                    Whittaker function, 2nd kind
erfc (z)                       Complement of the erf function

expintegral_e (v,z)            Exponential integral E
expintegral_e1 (z)             Exponential integral E1
expintegral_ei (z)             Exponential integral Ei
expintegral_li (z)             Logarithmic integral Li
expintegral_si (z)             Exponential integral Si
expintegral_ci (z)             Exponential integral Ci
expintegral_shi (z)            Exponential integral Shi
expintegral_chi (z)            Exponential integral Chi

kelliptic (z)                  Complete elliptic integral of the first 
                               kind (K)
parabolic_cylinder_d (v,z)     Parabolic cylinder D function
@end example

@opencatbox
@category{Bessel functions}
@category{Airy functions}
@category{Special functions}
@closecatbox

@c -----------------------------------------------------------------------------
@node Bessel Functions, Airy Functions, Introduction to Special Functions, Special Functions
@section Bessel Functions
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
m4_setcat(Bessel functions, Special functions)
m4_deffn(<<<{Function}>>>, <<<bessel_j>>>, <<<(@var{v}, @var{z})>>>)

The Bessel function of the first kind of order @math{v} and argument @math{z}.

@code{bessel_j} is defined as

m4_mathjax(
<<<$$J_\nu(z) = \sum_{k=0}^{\infty }{{{\left(-1\right)^{k}\,\left(z\over 2\right)^{v+2\,k}
 }\over{k!\,\Gamma\left(v+k+1\right)}}}$$>>>,
<<<@example
                inf
                ====       k  - v - 2 k  v + 2 k
                \     (- 1)  2          z
                 >    --------------------------
                /        k! gamma(v + k + 1)
                ====
                k = 0
@end example
>>>)

although the infinite series is not used for computations.

@c @opencatbox
@c @category{Bessel functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, bessel_y, <<<(@var{v}, @var{z})>>>)

The Bessel function of the second kind of order @math{v} and argument @math{z}.

m4_mathjax(
<<<$$Y_\nu(z) = {{\cos \left(\pi\,v\right)\,J_{v}(z)-J_{-v}(z)}\over{
 \sin \left(\pi\,v\right)}}$$>>>,
<<<@example
              cos(%pi v) bessel_j(v, z) - bessel_j(-v, z)
              -------------------------------------------
                             sin(%pi v)
@end example
>>>)

when @math{v} is not an integer.  When @math{v} is an integer @math{n},
the limit as @math{v} approaches @math{n} is taken.

@c @opencatbox
@c @category{Bessel functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, bessel_i, <<<(@var{v}, @var{z})>>>)

The modified Bessel function of the first kind of order @math{v} and argument
@math{z}.

@code{bessel_i} is defined as
m4_mathjax(
<<<$$I_\nu(z) = \sum_{k=0}^{\infty } {{1\over{k!\,\Gamma
 \left(v+k+1\right)}} {\left(z\over 2\right)^{v+2\,k}}}$$>>>,
<<<@example
                    inf
                    ====   - v - 2 k  v + 2 k
                    \     2          z
                     >    -------------------
                    /     k! gamma(v + k + 1)
                    ====
                    k = 0
@end example
>>>)

although the infinite series is not used for computations.

@c @opencatbox
@c @category{Bessel functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, bessel_k, <<<(@var{v}, @var{z})>>>)

The modified Bessel function of the second kind of order @math{v} and argument
@math{z}.

@code{bessel_k} is defined as
m4_mathjax(
<<<$$K_\nu(z) = {{\pi\,\csc
\left(\pi\,v\right)\,\left(I_{-v}(z)-I_{v}(z)\right)}\over{2}}$$>>>,
<<<@example
           %pi csc(%pi v) (bessel_i(-v, z) - bessel_i(v, z))
           -------------------------------------------------
                                  2
@end example
>>>)

when @math{v} is not an integer.  If @math{v} is an integer @math{n},
then the limit as @math{v} approaches @math{n} is taken.

@c @opencatbox
@c @category{Bessel functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, hankel_1, <<<(@var{v}, @var{z})>>>)

The Hankel function of the first kind of order @math{v} and argument @math{z}
(A&S 9.1.3). @code{hankel_1} is defined as

@example
   bessel_j(v,z) + %i * bessel_y(v,z)
@end example

Maxima evaluates @code{hankel_1} numerically for a complex order @math{v} and 
complex argument @math{z} in float precision. The numerical evaluation in 
bigfloat precision is not supported.

When @code{besselexpand} is @code{true}, @code{hankel_1} is expanded in terms
of elementary functions when the order @math{v} is half of an odd integer. 
See @code{besselexpand}.

Maxima knows the derivative of @code{hankel_1} wrt the argument @math{z}.

Examples:

Numerical evaluation:

@c ===beg===
@c hankel_1(1,0.5);
@c hankel_1(1,0.5+%i);
@c ===end===
@example
@group
(%i1) hankel_1(1,0.5);
(%o1)        0.24226845767487 - 1.471472392670243 %i
@end group
@group
(%i2) hankel_1(1,0.5+%i);
(%o2)       - 0.25582879948621 %i - 0.23957560188301
@end group
@end example

Expansion of @code{hankel_1} when @code{besselexpand} is @code{true}:

@c ===beg===
@c hankel_1(1/2,z),besselexpand:true;
@c ===end===
@example
@group
(%i1) hankel_1(1/2,z),besselexpand:true;
               sqrt(2) sin(z) - sqrt(2) %i cos(z)
(%o1)          ----------------------------------
                       sqrt(%pi) sqrt(z)
@end group
@end example

Derivative of @code{hankel_1} wrt the argument @math{z}. The derivative wrt the 
order @math{v} is not supported. Maxima returns a noun form:

@c ===beg===
@c diff(hankel_1(v,z),z);
@c diff(hankel_1(v,z),v);
@c ===end===
@example
@group
(%i1) diff(hankel_1(v,z),z);
             hankel_1(v - 1, z) - hankel_1(v + 1, z)
(%o1)        ---------------------------------------
                                2
@end group
@group
(%i2) diff(hankel_1(v,z),v);
                       d
(%o2)                  -- (hankel_1(v, z))
                       dv
@end group
@end example

@c @opencatbox
@c @category{Bessel functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, hankel_2, <<<(@var{v}, @var{z})>>>)

The Hankel function of the second kind of order @math{v} and argument @math{z}
(A&S 9.1.4). @code{hankel_2} is defined as

@example
   bessel_j(v,z) - %i * bessel_y(v,z)
@end example

Maxima evaluates @code{hankel_2} numerically for a complex order @math{v} and 
complex argument @math{z} in float precision. The numerical evaluation in 
bigfloat precision is not supported.

When @code{besselexpand} is @code{true}, @code{hankel_2} is expanded in terms
of elementary functions when the order @math{v} is half of an odd integer. 
See @code{besselexpand}.

Maxima knows the derivative of @code{hankel_2} wrt the argument @math{z}.

For examples see @code{hankel_1}.

@c @opencatbox
@c @category{Bessel functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@c @anchor{besselexpand}
@c @defvr {Option variable} besselexpand
m4_setcat(Bessel functions, Simplification flags and variables, Special functions)
m4_defvr({Option variable}, besselexpand)
Default value: @code{false}

@c REPHRASE
Controls expansion of the Bessel functions when the order is half of
an odd integer.  In this case, the Bessel functions can be expanded
in terms of other elementary functions.  When @code{besselexpand} is @code{true},
the Bessel function is expanded.

@example
(%i1) besselexpand: false$
(%i2) bessel_j (3/2, z);
                                    3
(%o2)                      bessel_j(-, z)
                                    2
(%i3) besselexpand: true$
(%i4) bessel_j (3/2, z);
                                        sin(z)   cos(z)
                       sqrt(2) sqrt(z) (------ - ------)
                                           2       z
                                          z
(%o4)                  ---------------------------------
                                   sqrt(%pi)
@end example

@c @opencatbox
@c @category{Bessel functions}
@c @category{Simplification flags and variables} 
@c @category{Special functions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Bessel functions)
m4_deffn({Function}, scaled_bessel_i, <<<(@var{v}, @var{z})>>>)

The scaled modified Bessel function of the first kind of order
@math{v} and argument @math{z}.  That is, @math{scaled_bessel_i(v,z) =
exp(-abs(z))*bessel_i(v, z)}.  This function is particularly useful
for calculating @math{bessel_i} for large @math{z}, which is large.
However, maxima does not otherwise know much about this function.  For
symbolic work, it is probably preferable to work with the expression
@code{exp(-abs(z))*bessel_i(v, z)}.

@c @opencatbox
@c @category{Bessel functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_setcat(Bessel functions, Special functions)
m4_deffn({Function}, scaled_bessel_i0, (@var{z}))

Identical to @code{scaled_bessel_i(0,z)}.

@c @opencatbox
@c @category{Bessel functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, scaled_bessel_i1, (@var{z}))

Identical to @code{scaled_bessel_i(1,z)}.
@c @opencatbox
@c @category{Bessel functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, %s, <<<[@var{u},@var{v}] (@var{z})>>>) 
Lommel's little s[u,v](z) function.  
Probably Gradshteyn & Ryzhik 8.570.1.
@c @opencatbox
@c @category{Bessel functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@node Airy Functions, Gamma and factorial Functions, Bessel Functions, Special Functions
@section Airy Functions
@c -----------------------------------------------------------------------------
m4_setcat(Airy functions)
The Airy functions Ai(x) and Bi(x) are defined in Abramowitz and Stegun,
@i{Handbook of Mathematical Functions}, Section 10.4. 

@code{y = Ai(x)} and @code{y = Bi(x)} are two linearly independent solutions 
of the Airy differential equation @code{diff (y(x), x, 2) - x y(x) = 0}.

If the argument @code{x} is a real or complex floating point 
number, the numerical value of the function is returned.

m4_setcat(Airy functions, Special functions)
m4_deffn({Function}, airy_ai, (@var{x}))
The Airy function Ai(x).  (A&S 10.4.2)

The derivative @code{diff (airy_ai(x), x)} is @code{airy_dai(x)}.

See also @mrefcomma{airy_bi} @mrefcomma{airy_dai} @mrefdot{airy_dbi}

@c @opencatbox
@c @category{Airy functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, airy_dai, (@var{x}))
The derivative of the Airy function Ai @code{airy_ai(x)}. 

See @code{airy_ai}.

@c @opencatbox
@c @category{Airy functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, airy_bi, (@var{x}))
The Airy function Bi(x).  (A&S 10.4.3)

The derivative @code{diff (airy_bi(x), x)} is @code{airy_dbi(x)}.

See @code{airy_ai}, @code{airy_dbi}.

@c @opencatbox
@c @category{Airy functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, airy_dbi, (@var{x}))
The derivative of the Airy Bi function @code{airy_bi(x)}.

See @code{airy_ai} and @code{airy_bi}.

@c @opencatbox
@c @category{Airy functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@node Gamma and factorial Functions, Exponential Integrals, Airy Functions, Special Functions
@section Gamma and factorial Functions
@c -----------------------------------------------------------------------------
m4_setcat(Gamma and factorial functions)
The gamma function and the related beta, psi and incomplete gamma 
functions are defined in Abramowitz and Stegun,
@i{Handbook of Mathematical Functions}, Chapter 6.

@c FOLLOWING FUNCTIONS IN bffac.mac ARE NOT DESCRIBED IN .texi FILES: !!!
@c obfac, azetb, vonschtoonk, divrlst, obzeta, bfhzeta, bfpsi0 !!!
@c DON'T KNOW WHICH ONES ARE INTENDED FOR GENERAL USE !!!

@c FOLLOWING FUNCTIONS IN bffac.mac ARE DESCRIBED IN Number.texi: !!!
@c burn, bzeta, bfzeta !!!

@c FOLLOWING FUNCTIONS IN bffac.mac ARE DESCRIBED HERE: !!!
@c bfpsi, bffac, cbffac !!!

@c -----------------------------------------------------------------------------
m4_setcat(Gamma and factorial functions, Numerical evaluation)
m4_deffn({Function}, bffac, <<<(@var{expr}, @var{n})>>>)

Bigfloat version of the factorial (shifted gamma)
function.  The second argument is how many digits to retain and return,
it's a good idea to request a couple of extra.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Numerical evaluation}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, bfpsi, <<<(@var{n}, @var{z}, @var{fpprec})>>>)
m4_deffnx({Function}, bfpsi0, <<<(@var{z}, @var{fpprec})>>>)

@code{bfpsi} is the polygamma function of real argument @var{z} and integer
order @var{n}.  @code{bfpsi0} is the digamma function.
@code{bfpsi0 (@var{z}, @var{fpprec})} is equivalent to
@code{bfpsi (0, @var{z}, @var{fpprec})}.

These functions return bigfloat values.
@var{fpprec} is the bigfloat precision of the return value.

@c psi0(1) = -%gamma IS AN INTERESTING PROPERTY BUT IN THE ABSENCE OF ANY OTHER
@c DISCUSSION OF THE PROPERTIES OF THIS FUNCTION, THIS STATEMENT SEEMS OUT OF PLACE.
@c Note @code{-bfpsi0 (1, fpprec)} provides @code{%gamma} (Euler's constant) as a bigfloat.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Numerical evaluation}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Gamma and factorial functions, Complex variables, Numerical evaluation)
m4_deffn({Function}, cbffac, <<<(@var{z}, @var{fpprec})>>>)
Complex bigfloat factorial.

@code{load ("bffac")} loads this function.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Complex variables}
@c @category{Numerical evaluation}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_setcat(Gamma and factorial functions, Special functions)
@c -----------------------------------------------------------------------------
m4_deffn({Function}, gamma, (@var{z}))

The basic definition of the gamma function (A&S 6.1.1) is

m4_mathjax(
<<<$$\Gamma\left(z\right)=\int_{0}^{\infty }{t^{z-1}\,e^ {- t
}\;dt}$$>>>,
<<<@example
                         inf
                        /
                        [     z - 1   - t
             gamma(z) = I    t      %e    dt
                        ]
                        /
                         0
@end example
>>>)

Maxima simplifies @code{gamma} for positive integer and positive and negative 
rational numbers. For half integral values the result is a rational number times 
@code{sqrt(%pi)}. The simplification for integer values is controlled by 
@code{factlim}. For integers greater than @code{factlim} the numerical result of 
the factorial function, which is used to calculate @code{gamma}, will overflow. 
The simplification for rational numbers is controlled by @code{gammalim} to 
avoid internal overflow. See @code{factlim} and @code{gammalim}.

For negative integers @code{gamma} is not defined.

Maxima can evalute @code{gamma} numerically for real and complex values in float 
and bigfloat precision.

@code{gamma} has mirror symmetry.

When @code{gamma_expand} is @code{true}, Maxima expands @code{gamma} for 
arguments @code{z+n} and @code{z-n} where @code{n} is an integer.

Maxima knows the derivate of @code{gamma}.

Examples:

Simplification for integer, half integral, and rational numbers:

@example
(%i1) map('gamma,[1,2,3,4,5,6,7,8,9]);
(%o1)        [1, 1, 2, 6, 24, 120, 720, 5040, 40320]
(%i2) map('gamma,[1/2,3/2,5/2,7/2]);
                    sqrt(%pi)  3 sqrt(%pi)  15 sqrt(%pi)
(%o2)   [sqrt(%pi), ---------, -----------, ------------]
                        2           4            8
(%i3) map('gamma,[2/3,5/3,7/3]);
                                  2           1
                          2 gamma(-)  4 gamma(-)
                      2           3           3
(%o3)          [gamma(-), ----------, ----------]
                      3       3           9
@end example

Numerical evaluation for real and complex values:

@example
(%i4) map('gamma,[2.5,2.5b0]);
(%o4)     [1.329340388179137, 1.3293403881791370205b0]
(%i5) map('gamma,[1.0+%i,1.0b0+%i]);
(%o5) [0.498015668118356 - .1549498283018107 %i, 
          4.9801566811835604272b-1 - 1.5494982830181068513b-1 %i]
@end example

@code{gamma} has mirror symmetry:

@example
(%i6) declare(z,complex)$
(%i7) conjugate(gamma(z));
(%o7)                  gamma(conjugate(z))
@end example

Maxima expands @code{gamma(z+n)} and @code{gamma(z-n)}, when @code{gamma_expand} 
is @code{true}:

@example
(%i8) gamma_expand:true$

(%i9) [gamma(z+1),gamma(z-1),gamma(z+2)/gamma(z+1)];
                               gamma(z)
(%o9)             [z gamma(z), --------, z + 1]
                                z - 1
@end example

The deriviative of @code{gamma}:

@example
(%i10) diff(gamma(z),z);
(%o10)                  psi (z) gamma(z)
                           0
@end example

See also @mrefdot{makegamma}

The Euler-Mascheroni constant is @code{%gamma}.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Gamma and factorial functions, Special functions)
m4_deffn({Function}, log_gamma, (@var{z}))

The natural logarithm of the gamma function.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, gamma_incomplete_lower, <<<(@var{a}, @var{z})>>>)

The lower incomplete gamma function (A&S 6.5.2):

m4_mathjax(
<<<$$\gamma\left(a , z\right)=\int_{0}^{z}{t^{a-1}\,e^ {- t
}\;dt}$$>>>,
<<<@example
                                    z
                                   /
                                   [  a - 1   - t
    gamma_incomplete_lower(a, z) = I t      %e    dt
                                   ]
                                   /
                                    0
@end example
>>>)

See also @mref{gamma_incomplete} (upper incomplete gamma function).

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, gamma_incomplete, <<<(@var{a}, @var{z})>>>)

The incomplete upper gamma function (A&S 6.5.3):

m4_mathjax(
<<<$$\Gamma\left(a , z\right)=\int_{z}^{\infty }{t^{a-1}\,e^ {- t
}\;dt}$$>>>,
<<<@example
                              inf
                             /
                             [     a - 1   - t
    gamma_incomplete(a, z) = I    t      %e    dt
                             ]
                             /
                              z
@end example
>>>)

See also @mref{gamma_expand} for controlling how
@code{gamma_incomplete} is expressed in terms of elementary functions
and @code{erfc}.

Also see the related functions @code{gamma_incomplete_regularized} and
@code{gamma_incomplete_generalized}.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, gamma_incomplete_regularized, <<<(@var{a}, @var{z})>>>)

The regularized incomplete upper gamma function (A&S 6.5.1):

m4_mathjax(
<<<$${\it Q}\left(a , z\right)={{\Gamma\left(a ,
z\right)}\over{\Gamma\left(a\right)}}$$>>>,
<<<@example
gamma_incomplete_regularized(a, z) = 
                                        gamma_incomplete(a, z)
                                        ----------------------
                                               gamma(a)
@end example
>>>)

See also @mref{gamma_expand} for controlling how
@code{gamma_incomplete} is expressed in terms of elementary functions
and @mrefdot{erfc}

Also see @code{gamma_incomplete}.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, gamma_incomplete_generalized, <<<(@var{a}, @var{z1}, @var{z1})>>>)

The generalized incomplete gamma function.

m4_mathjax(
<<<$$\Gamma\left(a , z_{1},
z_{2}\right)=\int_{z_{1}}^{z_{2}}{t^{a-1}\,e^ {- t }\;dt}$$>>>,
<<<@example
gamma_incomplete_generalized(a, z1, z2) = 
                                               z2
                                              /
                                              [    a - 1   - t
                                              I   t      %e    dt
                                              ]
                                              /
                                               z1
@end example
>>>)

Also see @code{gamma_incomplete} and @code{gamma_incomplete_regularized}.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()


@c -----------------------------------------------------------------------------
m4_setcat(Gamma and factorial functions, Simplification flags and variables)
m4_defvr({Option variable}, gamma_expand)
Default value: @code{false}

@code{gamma_expand} controls expansion of @code{gamma_incomplete}.
When @code{gamma_expand} is @code{true}, @code{gamma_incomplete(v,z)}
is expanded in terms of
@code{z}, @code{exp(z)}, and @code{erfc(z)} when possible.

@example
(%i1) gamma_incomplete(2,z);
(%o1)                       gamma_incomplete(2, z)
(%i2) gamma_expand:true;
(%o2)                                true
(%i3) gamma_incomplete(2,z);
                                           - z
(%o3)                            (z + 1) %e
@group
(%i4) gamma_incomplete(3/2,z);
                              - z   sqrt(%pi) erfc(sqrt(z))
(%o4)               sqrt(z) %e    + -----------------------
                                               2
@end group
@end example

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Simplification flags and variables}
@c @closecatbox

@c @end defvr
m4_end_defvr()
@c -----------------------------------------------------------------------------
m4_defvr({Option variable}, gammalim)
Default value: 10000

@c REPHRASE
@code{gammalim} controls simplification of the gamma
function for integral and rational number arguments.  If the absolute
value of the argument is not greater than @code{gammalim}, then
simplification will occur.  Note that the @code{factlim} switch controls
simplification of the result of @code{gamma} of an integer argument as well.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Simplification flags and variables}
@c @closecatbox

@c @end defvr
m4_end_defvr()

@c NEED CROSS REFS HERE
@c NEED EXAMPLES HERE

@c -----------------------------------------------------------------------------
m4_setcat(Gamma and factorial functions)
m4_deffn({Function}, makegamma, (@var{expr}))
Transforms instances of binomial, factorial, and beta
functions in @var{expr} into gamma functions.

See also @mrefdot{makefact}

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{beta}
@c -----------------------------------------------------------------------------
m4_deffn({Function}, beta, <<<(@var{a}, @var{b})>>>)
The beta function is defined as @code{gamma(a) gamma(b)/gamma(a+b)} 
(A&S 6.2.1).

Maxima simplifies the beta function for positive integers and rational 
numbers, which sum to an integer. When @code{beta_args_sum_to_integer} is 
@code{true}, Maxima simplifies also general expressions which sum to an integer. 

For @var{a} or @var{b} equal to zero the beta function is not defined.

In general the beta function is not defined for negative integers as an 
argument. The exception is for @var{a=-n}, @var{n} a positive integer 
and @var{b} a positive integer with @var{b<=n}, it is possible to define an 
analytic continuation. Maxima gives for this case a result.

When @code{beta_expand} is @code{true}, expressions like @code{beta(a+n,b)} and 
@code{beta(a-n,b)} or @code{beta(a,b+n)} and @code{beta(a,b-n)} with @code{n} 
an integer are simplified.

Maxima can evaluate the beta function for real and complex values in float and 
bigfloat precision. For numerical evaluation Maxima uses @code{log_gamma}:

@example
           - log_gamma(b + a) + log_gamma(b) + log_gamma(a)
         %e
@end example

Maxima knows that the beta function is symmetric and has mirror symmetry.

Maxima knows the derivatives of the beta function with respect to @var{a} or 
@var{b}.

To express the beta function as a ratio of gamma functions see @code{makegamma}. 

Examples:

Simplification, when one of the arguments is an integer:

@example
(%i1) [beta(2,3),beta(2,1/3),beta(2,a)];
                               1   9      1
(%o1)                         [--, -, ---------]
                               12  4  a (a + 1)
@end example

Simplification for two rational numbers as arguments which sum to an integer:

@example
(%i2) [beta(1/2,5/2),beta(1/3,2/3),beta(1/4,3/4)];
                          3 %pi   2 %pi
(%o2)                    [-----, -------, sqrt(2) %pi]
                            8    sqrt(3)
@end example

When setting @code{beta_args_sum_to_integer} to @code{true} more general 
expression are simplified, when the sum of the arguments is an integer:

@example
(%i3) beta_args_sum_to_integer:true$
(%i4) beta(a+1,-a+2);
                                %pi (a - 1) a
(%o4)                         ------------------
                              2 sin(%pi (2 - a))
@end example

The possible results, when one of the arguments is a negative integer: 

@example
(%i5) [beta(-3,1),beta(-3,2),beta(-3,3)];
                                    1  1    1
(%o5)                            [- -, -, - -]
                                    3  6    3
@end example

@code{beta(a+n,b)} or @code{beta(a-n)} with @code{n} an integer simplifies when 
@code{beta_expand} is @code{true}:

@example
(%i6) beta_expand:true$
(%i7) [beta(a+1,b),beta(a-1,b),beta(a+1,b)/beta(a,b+1)];
                    a beta(a, b)  beta(a, b) (b + a - 1)  a
(%o7)              [------------, ----------------------, -]
                       b + a              a - 1           b

@end example

Beta is not defined, when one of the arguments is zero:

@example
(%i7) beta(0,b);
beta: expected nonzero arguments; found 0, b
 -- an error.  To debug this try debugmode(true);
@end example

Numercial evaluation for real and complex arguments in float or bigfloat 
precision:

@example
(%i8) beta(2.5,2.3);
(%o8) .08694748611299981

(%i9) beta(2.5,1.4+%i);
(%o9) 0.0640144950796695 - .1502078053286415 %i

(%i10) beta(2.5b0,2.3b0);
(%o10) 8.694748611299969b-2

(%i11) beta(2.5b0,1.4b0+%i);
(%o11) 6.401449507966944b-2 - 1.502078053286415b-1 %i
@end example

Beta is symmetric and has mirror symmetry:

@example
(%i14) beta(a,b)-beta(b,a);
(%o14)                                 0
(%i15) declare(a,complex,b,complex)$
(%i16) conjugate(beta(a,b));
(%o16)                 beta(conjugate(a), conjugate(b))
@end example

The derivative of the beta function wrt @code{a}:

@example
(%i17) diff(beta(a,b),a);
(%o17)               - beta(a, b) (psi (b + a) - psi (a))
                                      0             0
@end example

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, beta_incomplete, <<<(@var{a}, @var{b}, @var{z})>>>)

The basic definition of the incomplete beta function (A&S 6.6.1) is

m4_mathjax(
<<<$$I_z(a,b) = \int_0^z (1-t)^{b-1} t^{a-1}\, dt$$>>>,
<<<@example
@group
        z
       /
       [         b - 1  a - 1
       I  (1 - t)      t      dt
       ]
       /
        0
@end group
@end example
>>>)

This definition is possible for @math{realpart(a)>0} and @math{realpart(b)>0} 
and @math{abs(z)<1}. For other values the incomplete beta function can be 
defined through a generalized hypergeometric function:

@example
   gamma(a) hypergeometric_generalized([a, 1 - b], [a + 1], z) z
@end example

(See functions.wolfram.com for a complete definition of the incomplete beta 
function.)

For negative integers @math{a = -n} and positive integers @math{b=m} with 
@math{m<=n} the incomplete beta function is defined through

m4_mathjax(
<<<$$z^{n-1}\sum_{k=0}^{m-1} {(1-m)_k z^k\over{k! (n-k)}}$$>>>,
<<<@example
                            m - 1           k
                            ====  (1 - m)  z
                      n - 1 \            k
                     z       >    -----------
                            /     k! (n - k)
                            ====
                            k = 0
@end example
>>>)

Maxima uses this definition to simplify @code{beta_incomplete} for @var{a} a 
negative integer.

For @var{a} a positive integer, @code{beta_incomplete} simplifies for any 
argument @var{b} and @var{z} and for @var{b} a positive integer for any 
argument @var{a} and @var{z}, with the exception of @var{a} a negative integer.

For @math{z=0} and @math{realpart(a)>0}, @code{beta_incomplete} has the 
specific value zero. For @var{z=1} and @math{realpart(b)>0}, 
@code{beta_incomplete} simplifies to the beta function @code{beta(a,b)}.

Maxima evaluates @code{beta_incomplete} numerically for real and complex values 
in float or bigfloat precision. For the numerical evaluation an expansion of the 
incomplete beta function in continued fractions is used.

When the option variable @code{beta_expand} is @code{true}, Maxima expands
expressions like @code{beta_incomplete(a+n,b,z)} and
@code{beta_incomplete(a-n,b,z)} where n is a positive integer.

Maxima knows the derivatives of @code{beta_incomplete} with respect to the 
variables @var{a}, @var{b} and @var{z} and the integral with respect to the 
variable @var{z}.

Examples:

Simplification for @var{a} a positive integer:

@example
(%i1) beta_incomplete(2,b,z);
                                       b
                            1 - (1 - z)  (b z + 1)
(%o1)                       ----------------------
                                  b (b + 1)
@end example

Simplification for @var{b} a positive integer:

@example
(%i2) beta_incomplete(a,2,z);
                                               a
                              (a (1 - z) + 1) z
(%o2)                         ------------------
                                  a (a + 1)
@end example

Simplification for @var{a} and @var{b} a positive integer:

@example
(%i3) beta_incomplete(3,2,z);
@group
                                               3
                              (3 (1 - z) + 1) z
(%o3)                         ------------------
                                      12
@end group
@end example

@var{a} is a negative integer and @math{b<=(-a)}, Maxima simplifies:

@example
(%i4) beta_incomplete(-3,1,z);
                                       1
(%o4)                              - ----
                                        3
                                     3 z
@end example

For the specific values @math{z=0} and @math{z=1}, Maxima simplifies:

@example
(%i5) assume(a>0,b>0)$
(%i6) beta_incomplete(a,b,0);
(%o6)                                 0
(%i7) beta_incomplete(a,b,1);
(%o7)                            beta(a, b)
@end example

Numerical evaluation in float or bigfloat precision:

@example
(%i8) beta_incomplete(0.25,0.50,0.9);
(%o8)                          4.594959440269333
(%i9)  fpprec:25$
(%i10) beta_incomplete(0.25,0.50,0.9b0);
(%o10)                    4.594959440269324086971203b0
@end example

For @math{abs(z)>1} @code{beta_incomplete} returns a complex result:

@example
(%i11) beta_incomplete(0.25,0.50,1.7);
(%o11)              5.244115108584249 - 1.45518047787844 %i
@end example

Results for more general complex arguments:

@example
(%i14) beta_incomplete(0.25+%i,1.0+%i,1.7+%i);
(%o14)             2.726960675662536 - .3831175704269199 %i
(%i15) beta_incomplete(1/2,5/4*%i,2.8+%i);
(%o15)             13.04649635168716 %i - 5.802067956270001
(%i16) 
@end example

Expansion, when @code{beta_expand} is @code{true}:

@example
(%i23) beta_incomplete(a+1,b,z),beta_expand:true;
                                                       b  a
                   a beta_incomplete(a, b, z)   (1 - z)  z
(%o23)             -------------------------- - -----------
                             b + a                 b + a

(%i24) beta_incomplete(a-1,b,z),beta_expand:true;
                                                           b  a - 1
           beta_incomplete(a, b, z) (- b - a + 1)   (1 - z)  z
(%o24)     -------------------------------------- - ---------------
                           1 - a                         1 - a
@end example
 
Derivative and integral for @code{beta_incomplete}:

@example
(%i34) diff(beta_incomplete(a, b, z), z);
@group
                              b - 1  a - 1
(%o34)                 (1 - z)      z
@end group
(%i35) integrate(beta_incomplete(a, b, z), z);
              b  a
       (1 - z)  z
(%o35) ----------- + beta_incomplete(a, b, z) z
          b + a
                                       a beta_incomplete(a, b, z)
                                     - --------------------------
                                                 b + a
(%i36) factor(diff(%, z));
(%o36)              beta_incomplete(a, b, z)
@end example

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, beta_incomplete_regularized, <<<(@var{a}, @var{b}, @var{z})>>>)

The regularized incomplete beta function (A&S 6.6.2), defined as

@example
beta_incomplete_regularized(a, b, z) = 
                                      beta_incomplete(a, b, z)
                                      ------------------------
                                             beta(a, b)
@end example

As for @code{beta_incomplete} this definition is not complete. See 
functions.wolfram.com for a complete definition of 
@code{beta_incomplete_regularized}.

@code{beta_incomplete_regularized} simplifies @var{a} or @var{b} a positive 
integer.

For @math{z=0} and @math{realpart(a)>0}, @code{beta_incomplete_regularized} has 
the specific value 0. For @var{z=1} and @math{realpart(b)>0}, 
@code{beta_incomplete_regularized} simplifies to 1.

Maxima can evaluate @code{beta_incomplete_regularized} for real and complex 
arguments in float and bigfloat precision.

When @code{beta_expand} is @code{true}, Maxima expands 
@code{beta_incomplete_regularized} for arguments @math{a+n} or @math{a-n}, 
where n is an integer.

Maxima knows the derivatives of @code{beta_incomplete_regularized} with respect 
to the variables @var{a}, @var{b}, and @var{z} and the integral with respect to 
the variable @var{z}.

Examples:

Simplification for @var{a} or @var{b} a positive integer:

@example
(%i1) beta_incomplete_regularized(2,b,z);
                                       b
(%o1)                       1 - (1 - z)  (b z + 1)

(%i2) beta_incomplete_regularized(a,2,z);
                                               a
(%o2)                         (a (1 - z) + 1) z

(%i3) beta_incomplete_regularized(3,2,z);
                                               3
(%o3)                         (3 (1 - z) + 1) z
@end example

For the specific values @math{z=0} and @math{z=1}, Maxima simplifies:

@example
(%i4) assume(a>0,b>0)$
(%i5) beta_incomplete_regularized(a,b,0);
(%o5)                                 0
(%i6) beta_incomplete_regularized(a,b,1);
(%o6)                                 1
@end example

Numerical evaluation for real and complex arguments in float and bigfloat 
precision:

@example
(%i7) beta_incomplete_regularized(0.12,0.43,0.9);
(%o7)                         .9114011367359802
(%i8) fpprec:32$
(%i9) beta_incomplete_regularized(0.12,0.43,0.9b0);
(%o9)               9.1140113673598075519946998779975b-1
(%i10) beta_incomplete_regularized(1+%i,3/3,1.5*%i);
(%o10)             .2865367499935403 %i - 0.122995963334684
(%i11) fpprec:20$
(%i12) beta_incomplete_regularized(1+%i,3/3,1.5b0*%i);
(%o12)      2.8653674999354036142b-1 %i - 1.2299596333468400163b-1
@end example

Expansion, when @code{beta_expand} is @code{true}:

@example
(%i13) beta_incomplete_regularized(a+1,b,z);
                                                     b  a
                                              (1 - z)  z
(%o13) beta_incomplete_regularized(a, b, z) - ------------
                                              a beta(a, b)
(%i14) beta_incomplete_regularized(a-1,b,z);
(%o14) beta_incomplete_regularized(a, b, z)
                                                     b  a - 1
                                              (1 - z)  z
                                         - ----------------------
                                           beta(a, b) (b + a - 1)
@end example

The derivative and the integral wrt @var{z}:

@example
(%i15) diff(beta_incomplete_regularized(a,b,z),z);
                              b - 1  a - 1
                       (1 - z)      z
(%o15)                 -------------------
                           beta(a, b)
(%i16) integrate(beta_incomplete_regularized(a,b,z),z);
(%o16) beta_incomplete_regularized(a, b, z) z
                                                           b  a
                                                    (1 - z)  z
          a (beta_incomplete_regularized(a, b, z) - ------------)
                                                    a beta(a, b)
        - -------------------------------------------------------
                                   b + a
@end example

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, beta_incomplete_generalized, <<<(@var{a}, @var{b}, @var{z1}, @var{z2})>>>)

The basic definition of the generalized incomplete beta function is

@example
@group
             z2
           /
           [          b - 1  a - 1
           I   (1 - t)      t      dt
           ]
           /
            z1
@end group
@end example

Maxima simplifies @code{beta_incomplete_regularized} for @var{a} and @var{b} 
a positive integer.

For @math{realpart(a)>0} and @math{z1=0} or @math{z2=0}, Maxima simplifies
@code{beta_incomplete_generalized} to @code{beta_incomplete}. For 
@math{realpart(b)>0} and @math{z1=1} or @var{z2=1}, Maxima simplifies to an 
expression with @code{beta} and @code{beta_incomplete}.

Maxima evaluates @code{beta_incomplete_regularized} for real and complex values 
in float and bigfloat precision.

When @code{beta_expand} is @code{true}, Maxima expands 
@code{beta_incomplete_generalized} for @math{a+n} and @math{a-n}, @var{n} a 
positive integer.

Maxima knows the derivative of @code{beta_incomplete_generalized} with respect 
to the variables @var{a}, @var{b}, @var{z1}, and @var{z2} and the integrals with
respect to the variables @var{z1} and @var{z2}.

Examples:

Maxima simplifies @code{beta_incomplete_generalized} for @var{a} and @var{b} a 
positive integer:

@example
(%i1) beta_incomplete_generalized(2,b,z1,z2);
                   b                      b
           (1 - z1)  (b z1 + 1) - (1 - z2)  (b z2 + 1)
(%o1)      -------------------------------------------
                            b (b + 1)
(%i2) beta_incomplete_generalized(a,2,z1,z2);
@group
                              a                      a
           (a (1 - z2) + 1) z2  - (a (1 - z1) + 1) z1
(%o2)      -------------------------------------------
                            a (a + 1)
@end group
(%i3) beta_incomplete_generalized(3,2,z1,z2);
              2      2                       2      2
      (1 - z1)  (3 z1  + 2 z1 + 1) - (1 - z2)  (3 z2  + 2 z2 + 1)
(%o3) -----------------------------------------------------------
                                  12
@end example

Simplification for specific values @math{z1=0}, @math{z2=0}, @math{z1=1}, or 
@math{z2=1}:

@example
(%i4) assume(a > 0, b > 0)$
(%i5) beta_incomplete_generalized(a,b,z1,0);
(%o5)                    - beta_incomplete(a, b, z1)

(%i6) beta_incomplete_generalized(a,b,0,z2);
(%o6)                    - beta_incomplete(a, b, z2)

(%i7) beta_incomplete_generalized(a,b,z1,1);
(%o7)              beta(a, b) - beta_incomplete(a, b, z1)

(%i8) beta_incomplete_generalized(a,b,1,z2);
(%o8)              beta_incomplete(a, b, z2) - beta(a, b)
@end example

Numerical evaluation for real arguments in float or bigfloat precision:

@example
(%i9) beta_incomplete_generalized(1/2,3/2,0.25,0.31);
(%o9)                        .09638178086368676

(%i10) fpprec:32$
(%i10) beta_incomplete_generalized(1/2,3/2,0.25,0.31b0);
(%o10)               9.6381780863686935309170054689964b-2
@end example

Numerical evaluation for complex arguments in float or bigfloat precision:

@example
(%i11) beta_incomplete_generalized(1/2+%i,3/2+%i,0.25,0.31);
(%o11)           - .09625463003205376 %i - .003323847735353769
(%i12) fpprec:20$
(%i13) beta_incomplete_generalized(1/2+%i,3/2+%i,0.25,0.31b0);
(%o13)     - 9.6254630032054178691b-2 %i - 3.3238477353543591914b-3
@end example

Expansion for @math{a+n} or @math{a-n}, @var{n} a positive integer, when 
@code{beta_expand} is @code{true}: 

@example
(%i14) beta_expand:true$

(%i15) beta_incomplete_generalized(a+1,b,z1,z2);

               b   a           b   a
       (1 - z1)  z1  - (1 - z2)  z2
(%o15) -----------------------------
                   b + a
                      a beta_incomplete_generalized(a, b, z1, z2)
                    + -------------------------------------------
                                         b + a
(%i16) beta_incomplete_generalized(a-1,b,z1,z2);

       beta_incomplete_generalized(a, b, z1, z2) (- b - a + 1)
(%o16) -------------------------------------------------------
                                1 - a
                                    b   a - 1           b   a - 1
                            (1 - z2)  z2      - (1 - z1)  z1
                          - -------------------------------------
                                            1 - a
@end example

Derivative wrt the variable @var{z1} and integrals wrt @var{z1} and @var{z2}:

@example
(%i17) diff(beta_incomplete_generalized(a,b,z1,z2),z1);
                               b - 1   a - 1
(%o17)               - (1 - z1)      z1
(%i18) integrate(beta_incomplete_generalized(a,b,z1,z2),z1);
(%o18) beta_incomplete_generalized(a, b, z1, z2) z1
                                  + beta_incomplete(a + 1, b, z1)
(%i19) integrate(beta_incomplete_generalized(a,b,z1,z2),z2);
(%o19) beta_incomplete_generalized(a, b, z1, z2) z2
                                  - beta_incomplete(a + 1, b, z2)
@end example

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_setcat(Gamma and factorial functions, Simplification flags and variables)
m4_defvr({Option variable}, beta_expand)
Default value: false

When @code{beta_expand} is @code{true}, @code{beta(a,b)} and related 
functions are expanded for arguments like @math{a+n} or @math{a-n}, 
where @math{n} is an integer.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Simplification flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

m4_defvr({Option variable}, beta_args_sum_to_integer)
Default value: false

When @code{beta_args_sum_to_integer} is @code{true}, Maxima simplifies 
@code{beta(a,b)}, when the arguments @var{a} and @var{b} sum to an integer.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @category{Simplification flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()


@c NEED INFO HERE ABOUT THE SUBSCRIPTED FORM psi[n](x)
@c I (rtoy) don't think there is a plain psi(x) function anymore.
@c @deffn {Function} psi (@var{x})
@c @deffnx {Function} psi [@var{n}](@var{x})
m4_setcat(Gamma and factorial functions)
m4_deffn({Function}, psi, <<<[@var{n}](@var{x})>>>)

The derivative of @code{log (gamma (@var{x}))} of order @code{@var{n}+1}.
Thus, @code{psi[0](@var{x})} is the first derivative,
@code{psi[1](@var{x})} is the second derivative, etc.

Maxima does not know how, in general, to compute a numerical value of
@code{psi}, but it can compute some exact values for rational args.
Several variables control what range of rational args @code{psi} will
return an exact value, if possible.  See @code{maxpsiposint},
@code{maxpsinegint}, @code{maxpsifracnum}, and @code{maxpsifracdenom}.
That is, @var{x} must lie between @code{maxpsinegint} and
@code{maxpsiposint}.  If the absolute value of the fractional part of
@var{x} is rational and has a numerator less than @code{maxpsifracnum}
and has a denominator less than @code{maxpsifracdenom}, @code{psi}
will return an exact value.

The function @code{bfpsi} in the @code{bffac} package can compute
numerical values.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_defvr({Option variable}, maxpsiposint)
Default value: 20

@code{maxpsiposint} is the largest positive value for which
@code{psi[n](x)} will try to compute an exact value.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox

@c @end defvr
m4_end_defvr()

m4_defvr({Option variable}, maxpsinegint)
Default value: -10

@code{maxpsinegint} is the most negative value for which
@code{psi[n](x)} will try to compute an exact value.  That is if
@var{x} is less than @code{maxnegint}, @code{psi[n](@var{x})} will not
return simplified answer, even if it could.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox

@c @end defvr
m4_end_defvr()

m4_defvr({Option variable}, maxpsifracnum)
Default value: 6

Let @var{x} be a rational number less than one of the form @code{p/q}.
If @code{p} is greater than @code{maxpsifracnum}, then
@code{psi[@var{n}](@var{x})} will not try to return a simplified
value.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox

@c @end defvr
m4_end_defvr()

m4_defvr({Option variable}, maxpsifracdenom)
Default value: 6

Let @var{x} be a rational number less than one of the form @code{p/q}.
If @code{q} is greater than @code{maxpsifracdenom}, then
@code{psi[@var{n}](@var{x})} will not try to return a simplified
value.

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox

@c @end defvr
m4_end_defvr()

@c NEED CROSS REFS HERE
@c NEED EXAMPLES HERE
m4_deffn({Function}, makefact, <<<(@var{expr})>>>)
Transforms instances of binomial, gamma, and beta
functions in @var{expr} into factorials.

See also @mrefdot{makegamma}

@c @opencatbox
@c @category{Gamma and factorial functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()


@c AREN'T THERE OTHER FUNCTIONS THAT DO ESSENTIALLY THE SAME THING ??
m4_setcat(Expressions)
m4_deffn({Function}, numfactor, <<<(@var{expr})>>>)
Returns the numerical factor multiplying the expression
@var{expr}, which should be a single term.

@c WHY IS content MENTIONED IN THIS CONTEXT ??
@code{content} returns the greatest common divisor (gcd) of all terms in a sum.

@example
(%i1) gamma (7/2);
                          15 sqrt(%pi)
(%o1)                     ------------
                               8
(%i2) numfactor (%);
                               15
(%o2)                          --
                               8
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()


@node Exponential Integrals, Error Function, Gamma and factorial Functions, Special Functions
@section Exponential Integrals
m4_setcat(Exponential integrals)
The Exponential Integral and related funtions are defined in 
Abramowitz and Stegun,
@i{Handbook of Mathematical Functions}, Chapter 5

m4_setcat(Exponential Integrals, Special functions)
m4_deffn({Function}, expintegral_e1, <<<(@var{z})>>>)
The Exponential Integral E1(z) (A&S 5.1.1) defined as

m4_mathjax(
<<<$$E_1(z) = \int_z^\infty {e^{-t} \over t} dt$$>>>,
<<<@math{integrate(exp(-t)/t, t, z, inf)}>>>)
with
m4_mathjax(
<<<\(|\arg\ z| < \pi\).>>>,
<<<@math{abs(arg z) < %pi}.>>>,
<<<$|\arg\ z| < \pi$.>>>)

@c @opencatbox
@c @category{Exponential Integrals}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, expintegral_ei, <<<(@var{z})>>>)
The Exponential Integral Ei(z) (A&S 5.1.2)

@c @opencatbox
@c @category{Exponential Integrals}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, expintegral_li, <<<(@var{z})>>>)
The Exponential Integral Li(z)  (A&S 5.1.3)

@c @opencatbox
@c @category{Exponential Integrals}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, expintegral_e, <<<(@var{n},@var{z})>>>)
The Exponential Integral En(z)  (A&S 5.1.4) defined as

m4_mathjax(
<<<$$E_n(z) = \int_1^\infty {e^{-zt} \over t^n} dt$$>>>,
<<<@math{integrate(exp(-z*t)/t^n, t, 1, inf)}>>>)
with
m4_mathjax(
<<<${\rm Re}\ z > 0$ and $n = 0, 1, 2, \ldots$.>>>,
<<<@math{real(x) > 1} and @math{n} a non-negative integer.>>>)

@c @opencatbox
@c @category{Exponential Integrals}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, expintegral_si, <<<(@var{z})>>>)
The Exponential Integral Si(z) (A&S 5.2.1) defined as

m4_mathjax(
<<<$${\rm Si}(z) = \int_0^z {\sin t \over t}\, dt$$>>>,
<<<@math{integrate(sin(t)/t, t, 0, z)}>>>)

@c @opencatbox
@c @category{Exponential Integrals}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, expintegral_ci, <<<(@var{z})>>>)
The Exponential Integral Ci(z) (A&S 5.2.2) defined as

m4_mathjax(
<<<$${\rm Ci}(z) = \gamma + \log z + \int_0^z {{\cos t - 1} \over t}
dt$$>>>,
<<<@math{%gamma + log(z) + integrate((cos(t) - 1)/t, t, 0, z)}>>>)
with
m4_mathjax(
<<<\(|\arg\ z| < \pi\).>>>,
<<<@math{abs(arg z) < %pi}>>>,
<<<$|\arg\ z| < \pi$.>>>)

@c @opencatbox
@c @category{Exponential Integrals}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, expintegral_shi, <<<(@var{z})>>>)
The Exponential Integral Shi(z) (A&S 5.2.3) defined as

m4_mathjax(
<<<$${\rm Shi}(z) = \int_0^z {\sinh t \over t} dt$$>>>,
<<<@math{integrate(sinh(t)/t, t, 0, z)}>>>)

@c @opencatbox
@c @category{Exponential Integrals}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, expintegral_chi, <<<(@var{z})>>>)
The Exponential Integral Chi(z) (A&S 5.2.4) defined as

m4_mathjax(
<<<$${\rm Chi}(z) = \gamma + \log z + \int_0^z {{\cosh t - 1} \over t}
dt$$>>>,
<<<@math{%gamma + log(z) + integrate((cosh(t) - 1)/t, t, 0, z)}>>>)
with
m4_mathjax(
<<<\(|\arg\ z| < \pi\).>>>,
<<<@math{abs(arg z) < %pi}.>>>,
<<<$|\arg\ z| < \pi$.>>>)

@c @opencatbox
@c @category{Exponential Integrals}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_setcat(Exponential Integrals)
m4_defvr({Option variable}, expintrep)
Default value: false

Change the representation of one of the exponential integrals,
@var{expintegral_e(m, z)}, @var{expintegral_e1}, or
@var{expintegral_ei} to an equivalent form if possible.

Possible values for @var{expintrep} are @var{false},
@var{gamma_incomplete}, @var{expintegral_e1}, @var{expintegral_ei},
@var{expintegral_li}, @var{expintegral_trig}, or
@var{expintegral_hyp}.

@var{false} means that the representation is not changed.  Other
values indicate the representation is to be changed to use the
function specified where @var{expintegral_trig} means
@var{expintegral_si}, @var{expintegral_ci}, and @var{expintegral_hyp}
means @var{expintegral_shi} or @var{expintegral_chi}.

@c @opencatbox
@c @category{Exponential Integrals}
@c @closecatbox
@c @end defvr
m4_end_defvr()

m4_defvr({Option variable}, expintexpand )
Default value: false

Expand the Exponential Integral E[n](z)
for half integral values in terms of Erfc or Erf and
for positive integers in terms of Ei 
@c @opencatbox
@c @category{Exponential Integrals}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@node Error Function, Struve Functions, Exponential Integrals, Special Functions
@section Error Function
m4_setcat(Error function)
The Error function and related funtions are defined in 
Abramowitz and Stegun,
@i{Handbook of Mathematical Functions}, Chapter 7

@c -----------------------------------------------------------------------------
m4_setcat(Special functions)
m4_deffn({Function}, erf, <<<(@var{z})>>>)

The Error Function erf(z) (A&S 7.1.1)

See also flag @mrefdot{erfflag}
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, erfc, <<<(@var{z})>>>)
The Complementary Error Function erfc(z) (A&S 7.1.2)

@code{erfc(z) = 1-erf(z)}
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, erfi, <<<(@var{z})>>>)
The Imaginary Error Function. 

@code{erfi(z) = -%i*erf(%i*z)}
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, erf_generalized, <<<(@var{z1},@var{z2})>>>)
Generalized Error function Erf(z1,z2)
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, fresnel_c, <<<(@var{z})>>>)
The Fresnel Integral, A&S 7.3.1:
m4_mathjax(
<<<$$C(z) = \int_0^z \cos{\pi t^2\over{2}}\, dt$$>>>,
<<<@math{C(z) = integrate(cos((%pi/2)*t^2),t,0,z)}>>>)

The simplification fresnel_c(-x) = -fresnel_c(x) is applied when
flag @code{trigsign} is true.

The simplification fresnel_c(%i*x) =  %i*fresnel_c(x) is applied when
flag @code{%iargs} is true.

See flags @code{erf_representation} and @code{hypergeometric_representation}.
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, fresnel_s, <<<(@var{z})>>>)
The Fresnel Integral, A&S 7.3.2:
m4_mathjax(
<<<$$S(z) = \int_0^z \sin{\pi t^2\over{2}}\, dt$$>>>,
<<<@math{S(z) = integrate(sin((%pi/2)*t^2),t,0,z)}>>>)

The simplification fresnel_s(-x) = -fresnel_s(x) is applied when
flag @code{trigsign} is true.

The simplification fresnel_s(%i*x) =  -%i*fresnel_s(x) is applied when
flag @code{%iargs} is true.

See flags @code{erf_representation} and @code{hypergeometric_representation}.
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_defvr({Option variable}, erf_representation)
Default value: false

When T erfc, erfi, erf_generalized, fresnel_s 
and fresnel_c are transformed to erf.
@end defvr

m4_defvr({Option variable}, hypergeometric_representation)
Default value: false

Enables transformation to a Hypergeometric
representation for fresnel_s and fresnel_c
@end defvr

@node Struve Functions, Hypergeometric Functions, Error Function, Special Functions
@section Struve Functions
m4_setcat(Special functions)

The Struve functions are defined in Abramowitz and Stegun,
@i{Handbook of Mathematical Functions}, Chapter 12.

@c -----------------------------------------------------------------------------
m4_deffn({Function}, struve_h, <<<(@var{v}, @var{z})>>>)
The Struve Function H of order v and argument z. (A&S 12.1.1)

@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_deffn({Function}, struve_l, <<<(@var{v}, @var{z})>>>)
The Modified Struve Function L of order v and argument z. (A&S 12.2.1)

@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@node Hypergeometric Functions, Parabolic Cylinder Functions, Struve Functions, Special Functions
@section Hypergeometric Functions
m4_setcat(Hypergeometric functions)
The Hypergeometric Functions are defined in Abramowitz and Stegun,
@i{Handbook of Mathematical Functions}, Chapters 13 and 15.

Maxima has very limited knowledge of these functions.  They
can be returned from function @code{hgfred}.

m4_deffn({Function}, %m, <<<[@var{k},@var{u}] (@var{z}) >>>)
Whittaker M function
@code{M[k,u](z) = exp(-z/2)*z^(1/2+u)*M(1/2+u-k,1+2*u,z)}.  
(A&S 13.1.32)
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, %w, <<<[@var{k},@var{u}] (@var{z}) >>>)
Whittaker W function.  (A&S 13.1.33)
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()


m4_setcat(Bessel functions, Special functions)
m4_deffn({Function}, %f, <<<[@var{p},@var{q}] (@var{[a],[b],z}) >>>)
The pFq(a1,a2,..ap;b1,b2,..bq;z) hypergeometric function,
where @code{a} a list of length @code{p} and 
@code{b} a list of length @code{q}.
@c @opencatbox
@c @category{Bessel functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, hypergeometric, <<<([@var{a1}, ..., @var{ap}],[@var{b1}, ... ,@var{bq}], x)>>>)
The hypergeometric function. Unlike Maxima's @code{%f} hypergeometric
function, the function @code{hypergeometric} is a simplifying
function; also, @code{hypergeometric} supports complex double and
big floating point evaluation. For the Gauss hypergeometric function,
that is @math{p = 2} and @math{q = 1}, floating point evaluation
outside the unit circle is supported, but in general, it is not
supported.

When the option variable @code{expand_hypergeometric} is true (default
is false) and one of the arguments @code{a1} through @code{ap} is a
negative integer (a polynomial case), @code{hypergeometric} returns an
expanded polynomial. 

Examples:

@example
(%i1)  hypergeometric([],[],x);
(%o1) %e^x
@end example

Polynomial cases automatically expand when @code{expand_hypergeometric} is true:

@example
(%i2) hypergeometric([-3],[7],x);
(%o2) hypergeometric([-3],[7],x)

(%i3) hypergeometric([-3],[7],x), expand_hypergeometric : true;
(%o3) -x^3/504+3*x^2/56-3*x/7+1
@end example

Both double float and big float evaluation is supported:

@example
(%i4) hypergeometric([5.1],[7.1 + %i],0.42);
(%o4)       1.346250786375334 - 0.0559061414208204 %i
(%i5) hypergeometric([5,6],[8], 5.7 - %i);
(%o5)     .007375824009774946 - .001049813688578674 %i
(%i6) hypergeometric([5,6],[8], 5.7b0 - %i), fpprec : 30;
(%o6) 7.37582400977494674506442010824b-3
                          - 1.04981368857867315858055393376b-3 %i
@end example
@end deffn

@node Parabolic Cylinder Functions, Functions and Variables for Special Functions, Hypergeometric Functions, Special Functions
@section  Parabolic Cylinder Functions
m4_setcat(Parabolic cylinder functions, Special functions)
The Parabolic Cylinder Functions are defined in Abramowitz and Stegun,
@i{Handbook of Mathematical Functions}, Chapter 19.

Maxima has very limited knowledge of these functions.  They
can be returned from function @code{hgfred}.

m4_setcat(Special functions)
m4_deffn({Function}, parabolic_cylinder_d, <<<(@var{v}, @var{z}) >>>)
The parabolic cylinder function @code{parabolic_cylinder_d(v,z)}. (A&S 19.3.1)
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()




@node Functions and Variables for Special Functions,  , Parabolic Cylinder Functions, Special Functions
@section Functions and Variables for Special Functions
m4_setcat(Laplace transform)
m4_deffn({Function}, specint, <<<(exp(- s*@var{t}) * @var{expr}, @var{t})>>>)

Compute the Laplace transform of @var{expr} with respect to the variable @var{t}.
The integrand @var{expr} may contain special functions.   The
parameter @var{s} maybe be named something else; it is determined
automatically, as the examples below show where @var{p} is used in
some places.

The following special functions are handled by @code{specint}: incomplete gamma 
function, error functions (but not the error function @code{erfi}, it is easy to 
transform @code{erfi} e.g. to the error function @code{erf}), exponential 
integrals, bessel functions (including products of bessel functions), hankel 
functions, hermite and the laguerre polynomials.

Furthermore, @code{specint} can handle the hypergeometric function 
@code{%f[p,q]([],[],z)}, the whittaker function of the first kind 
@code{%m[u,k](z)} and of the second kind @code{%w[u,k](z)}.

The result may be in terms of special functions and can include unsimplified 
hypergeometric functions.

When @code{laplace} fails to find a Laplace transform, @code{specint} is called. 
Because @code{laplace} knows more general rules for Laplace transforms, it is 
preferable to use @code{laplace} and not @code{specint}.

@code{demo("hypgeo")} displays several examples of Laplace transforms computed by 
@code{specint}.

Examples:
@c ===beg===
@c assume (p > 0, a > 0)$
@c specint (t^(1/2) * exp(-a*t/4) * exp(-p*t), t);
@c specint (t^(1/2) * bessel_j(1, 2 * a^(1/2) * t^(1/2)) 
@c               * exp(-p*t), t);
@c ===end===
@example
(%i1) assume (p > 0, a > 0)$
@group
(%i2) specint (t^(1/2) * exp(-a*t/4) * exp(-p*t), t);
                           sqrt(%pi)
(%o2)                     ------------
                                 a 3/2
                          2 (p + -)
                                 4
@end group
@group
(%i3) specint (t^(1/2) * bessel_j(1, 2 * a^(1/2) * t^(1/2))
              * exp(-p*t), t);
                                   - a/p
                         sqrt(a) %e
(%o3)                    ---------------
                                2
                               p
@end group
@end example

Examples for exponential integrals:

@example
(%i4) assume(s>0,a>0,s-a>0)$
(%i5) ratsimp(specint(%e^(a*t)
                      *(log(a)+expintegral_e1(a*t))*%e^(-s*t),t));
                             log(s)
(%o5)                        ------
                             s - a
(%i6) logarc:true$

(%i7) gamma_expand:true$

radcan(specint((cos(t)*expintegral_si(t)
                     -sin(t)*expintegral_ci(t))*%e^(-s*t),t));
                             log(s)
(%o8)                        ------
                              2
                             s  + 1
ratsimp(specint((2*t*log(a)+2/a*sin(a*t)
                      -2*t*expintegral_ci(a*t))*%e^(-s*t),t));
                               2    2
                          log(s  + a )
(%o9)                     ------------
                                2
                               s
@end example

Results when using the expansion of @code{gamma_incomplete} and when changing 
the representation to @code{expintegral_e1}:

@example
(%i10) assume(s>0)$
(%i11) specint(1/sqrt(%pi*t)*unit_step(t-k)*%e^(-s*t),t);
                                            1
                            gamma_incomplete(-, k s)
                                            2
(%o11)                      ------------------------
                               sqrt(%pi) sqrt(s)

(%i12) gamma_expand:true$
(%i13) specint(1/sqrt(%pi*t)*unit_step(t-k)*%e^(-s*t),t);
                              erfc(sqrt(k) sqrt(s))
(%o13)                        ---------------------
                                     sqrt(s)

(%i14) expintrep:expintegral_e1$
(%i15) ratsimp(specint(1/(t+a)^2*%e^(-s*t),t));
                              a s
                        a s %e    expintegral_e1(a s) - 1
(%o15)                - ---------------------------------
                                        a
@end example

@c @opencatbox
@c @category{Laplace transform}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_setcat(Hypergeometric functions, Simplification functions, Special functions)
m4_deffn({Function}, hypergeometric_simp, <<<(@var{e})>>>)

@code{hypergeometric_simp} simplifies hypergeometric functions
by applying @code{hgfred}
to the arguments of any hypergeometric functions in the expression @var{e}.

Only instances of @code{hypergeometric} are affected;
any @code{%f}, @code{%w}, and @code{%m} in the expression @var{e} are not affected.
Any unsimplified hypergeometric functions are returned unchanged
(instead of changing to @code{%f} as @code{hgfred} would).

@code{load(hypergeometric);} loads this function.

See also @mrefdot{hgfred}

Examples:

@c ===beg===
@c load ("hypergeometric") $
@c foo : [hypergeometric([1,1], [2], z), hypergeometric([1/2], [1], z)];
@c hypergeometric_simp (foo);
@c bar : hypergeometric([n], [m], z + 1);
@c hypergeometric_simp (bar);
@c ===end===
@example
(%i1) load ("hypergeometric") $
(%i2) foo : [hypergeometric([1,1], [2], z), hypergeometric([1/2], [1], z)];
(%o2) [hypergeometric([1, 1], [2], z), 
                                                     1
                                     hypergeometric([-], [1], z)]
                                                     2
(%i3) hypergeometric_simp (foo);
                 log(1 - z)              z    z/2
(%o3)         [- ----------, bessel_i(0, -) %e   ]
                     z                   2
(%i4) bar : hypergeometric([n], [m], z + 1);
(%o4)            hypergeometric([n], [m], z + 1)
(%i5) hypergeometric_simp (bar);
(%o5)            hypergeometric([n], [m], z + 1)
@end example

@c @opencatbox
@c @category{Hypergeometric functions}
@c @category{Simplification functions}
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, hgfred, <<<(@var{a}, @var{b}, @var{t})>>>)

Simplify the generalized hypergeometric function in terms of other,
simpler, forms.  @var{a} is a list of numerator parameters and @var{b}
is a list of the denominator parameters. 

If @code{hgfred} cannot simplify the hypergeometric function, it returns
an expression of the form @code{%f[p,q]([a], [b], x)} where @var{p} is
the number of elements in @var{a}, and @var{q} is the number of elements
in @var{b}.  This is the usual @code{pFq} generalized hypergeometric
function. 

@example
(%i1) assume(not(equal(z,0)));
(%o1)                          [notequal(z, 0)]
(%i2) hgfred([v+1/2],[2*v+1],2*%i*z);

                     v/2                               %i z
                    4    bessel_j(v, z) gamma(v + 1) %e
(%o2)               ---------------------------------------
                                       v
                                      z
(%i3) hgfred([1,1],[2],z);

                                   log(1 - z)
(%o3)                            - ----------
                                       z
(%i4) hgfred([a,a+1/2],[3/2],z^2);

                               1 - 2 a          1 - 2 a
                        (z + 1)        - (1 - z)
(%o4)                   -------------------------------
                                 2 (1 - 2 a) z

@end example

It can be beneficial to load orthopoly too as the following example
shows.  Note that @var{L} is the generalized Laguerre polynomial.

@example
(%i5) load(orthopoly)$
(%i6) hgfred([-2],[a],z);
@group

                                    (a - 1)
                                 2 L       (z)
                                    2
(%o6)                            -------------
                                   a (a + 1)
@end group
(%i7) ev(%);

                                  2
                                 z        2 z
(%o7)                         --------- - --- + 1
                              a (a + 1)    a

@end example
@end deffn

m4_setcat(Special functions)
m4_deffn({Function}, lambert_w, <<<(@var{z})>>>)
The principal branch of Lambert's W function W(z), the solution of 
@code{z = W(z) * exp(W(z))}.  (DLMF 4.13)
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, generalized_lambert_w, <<<(@var{k}, @var{z})>>>)
The @var{k}-th branch of Lambert's W function W(z), the solution of 
@code{z = W(z) * exp(W(z))}. (DLMF 4.13)

The principal branch, denoted Wp(z) in DLMF, is @code{lambert_w(z) = generalized_lambert_w(0,z)}.

The other branch with real values, denoted Wm(z) in DLMF, is @code{generalized_lambert_w(-1,z)}.
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()



m4_deffn({Function}, nzeta, <<<(@var{z})>>>)
The Plasma Dispersion Function 
@code{nzeta(z) = %i*sqrt(%pi)*exp(-z^2)*(1-erf(-%i*z))}
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, nzetar, <<<(@var{z})>>>)
Returns @code{realpart(nzeta(z))}.
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_deffn({Function}, nzetai, <<<(@var{z})>>>)
Returns @code{imagpart(nzeta(z))}.
@c @opencatbox
@c @category{Special functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

