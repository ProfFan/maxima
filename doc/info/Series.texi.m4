@c -*- Mode: texinfo -*-
@menu
* Functions and Variables for Sums and Products::
* Introduction to Series::
* Functions and Variables for Series::
* Introduction to Fourier series::
* Functions and Variables for Fourier series::
* Functions and Variables for Poisson series::
@end menu

@c -----------------------------------------------------------------------------
@node Functions and Variables for Sums and Products, Introduction to Series, Sums Products and Series, Sums Products and Series
@section Functions and Variables for Sums and Products
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products)
@anchor{bashindices}
@c @deffn {Function} bashindices (@var{expr})
m4_deffn({Function}, bashindices, <<<(@var{expr})>>>)

Transforms the expression @var{expr} by giving each summation and product a
unique index.  This gives @code{changevar} greater precision when it is working
with summations or products.  The form of the unique index is
@code{j@var{number}}. The quantity @var{number} is determined by referring to
@code{gensumnum}, which can be changed by the user.  For example,
@code{gensumnum:0$} resets it.

@c @opencatbox
@c @category{Sums and products}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{lsum}
@c @deffn {Function} lsum (@var{expr}, @var{x}, @var{L})
m4_deffn({Function}, lsum, <<<(@var{expr}, @var{x}, @var{L})>>>)

Represents the sum of @var{expr} for each element @var{x} in @var{L}.
A noun form @code{'lsum} is returned if the argument @var{L} does not evaluate
to a list.

Examples:

@c ===beg===
@c lsum (x^i, i, [1, 2, 7]);
@c lsum (i^2, i, rootsof (x^3 - 1, x));
@c ===end===
@example
(%i1) lsum (x^i, i, [1, 2, 7]);
                            7    2
(%o1)                      x  + x  + x
(%i2) lsum (i^2, i, rootsof (x^3 - 1, x));
@group
                     ====
                     \      2
(%o2)                 >    i
                     /
                     ====
                                   3
                     i in rootsof(x  - 1, x)
@end group
@end example

@c @opencatbox
@c @category{Sums and products}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS CLARIFICATION, EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{intosum}
@c @deffn {Function} intosum (@var{expr})
m4_deffn({Function}, intosum, <<<(@var{expr})>>>)

Moves multiplicative factors outside a summation to inside.
If the index is used in the
outside expression, then the function tries to find a reasonable
index, the same as it does for @code{sumcontract}.  This is essentially the
reverse idea of the @code{outative} property of summations, but note that it
does not remove this property, it only bypasses it.

@c WHAT ARE THESE CASES ??
In some cases, a @code{scanmap (multthru, @var{expr})} may be necessary before
the @code{intosum}.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products, Simplification flags and variables)
@anchor{simpproduct}
@c @defvr {Option variable} simpproduct
m4_defvr({Option variable}, simpproduct)
Default value: @code{false}

When @code{simpproduct} is @code{true}, the result of a @code{product} is simplified.
This simplification may sometimes be able to produce a closed form.  If
@code{simpproduct} is @code{false} or if the quoted form @code{'product} is used, the
value is a product noun form which is a representation of the pi notation used
in mathematics.

@c @opencatbox
@c @category{Sums and products}
@c @category{Simplification flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products)
@anchor{product}
@c @deffn {Function} product (@var{expr}, @var{i}, @var{i_0}, @var{i_1})
m4_deffn({Function}, product, <<<(@var{expr}, @var{i}, @var{i_0}, @var{i_1})>>>)

Represents a product of the values of @var{expr} as
the index @var{i} varies from @var{i_0} to @var{i_1}.
The noun form @code{'product} is displayed as an uppercase letter pi.

@code{product} evaluates @var{expr} and lower and upper limits @var{i_0} and
@var{i_1}, @code{product} quotes (does not evaluate) the index @var{i}.

If the upper and lower limits differ by an integer,
@var{expr} is evaluated for each value of the index @var{i},
and the result is an explicit product.

Otherwise, the range of the index is indefinite.
Some rules are applied to simplify the product.
When the global variable @code{simpproduct} is @code{true}, additional rules
are applied.  In some cases, simplification yields a result which is not a
product; otherwise, the result is a noun form @code{'product}.

See also @mref{nouns} and @mrefdot{evflag}

Examples:

@c ===beg===
@c product (x + i*(i+1)/2, i, 1, 4);
@c product (i^2, i, 1, 7);
@c product (a[i], i, 1, 7);
@c product (a(i), i, 1, 7);
@c product (a(i), i, 1, n);
@c product (k, k, 1, n);
@c product (k, k, 1, n), simpproduct;
@c product (integrate (x^k, x, 0, 1), k, 1, n);
@c product (if k <= 5 then a^k else b^k, k, 1, 10);
@c ===end===

@example
(%i1) product (x + i*(i+1)/2, i, 1, 4);
(%o1)           (x + 1) (x + 3) (x + 6) (x + 10)
(%i2) product (i^2, i, 1, 7);
(%o2)                       25401600
(%i3) product (a[i], i, 1, 7);
(%o3)                 a  a  a  a  a  a  a
                       1  2  3  4  5  6  7
(%i4) product (a(i), i, 1, 7);
(%o4)          a(1) a(2) a(3) a(4) a(5) a(6) a(7)
(%i5) product (a(i), i, 1, n);
                             n
                           /===\
                            ! !
(%o5)                       ! !  a(i)
                            ! !
                           i = 1
(%i6) product (k, k, 1, n);
                               n
                             /===\
                              ! !
(%o6)                         ! !  k
                              ! !
                             k = 1
(%i7) product (k, k, 1, n), simpproduct;
(%o7)                          n!
(%i8) product (integrate (x^k, x, 0, 1), k, 1, n);
                             n
                           /===\
                            ! !    1
(%o8)                       ! !  -----
                            ! !  k + 1
                           k = 1
(%i9) product (if k <= 5 then a^k else b^k, k, 1, 10);
                              15  40
(%o9)                        a   b
@end example

@c @opencatbox
@c @category{Sums and products}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS CLARIFICATION, EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products, Simplification flags and variables)
@anchor{simpsum}
@c @defvr {Option variable} simpsum
m4_defvr({Option variable}, simpsum)
Default value: @code{false}

When @code{simpsum} is @code{true}, the result of a @code{sum} is simplified.
This simplification may sometimes be able to produce a closed form.  If
@code{simpsum} is @code{false} or if the quoted form @code{'sum} is used, the
value is a sum noun form which is a representation of the sigma notation used
in mathematics.

@c @opencatbox
@c @category{Sums and products}
@c @category{Simplification flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products)
@anchor{sum}
@c @deffn {Function} sum (@var{expr}, @var{i}, @var{i_0}, @var{i_1})
m4_deffn({Function}, sum, <<<(@var{expr}, @var{i}, @var{i_0}, @var{i_1})>>>)

Represents a summation of the values of @var{expr} as
the index @var{i} varies from @var{i_0} to @var{i_1}.
The noun form @code{'sum} is displayed as an uppercase letter sigma.

@code{sum} evaluates its summand @var{expr} and lower and upper limits @var{i_0}
and @var{i_1}, @code{sum} quotes (does not evaluate) the index @var{i}.

If the upper and lower limits differ by an integer, the summand @var{expr} is
evaluated for each value of the summation index @var{i}, and the result is an
explicit sum.

Otherwise, the range of the index is indefinite.
Some rules are applied to simplify the summation.
When the global variable @code{simpsum} is @code{true}, additional rules are
applied.  In some cases, simplification yields a result which is not a
summation; otherwise, the result is a noun form @code{'sum}.

When the @code{evflag} (evaluation flag) @code{cauchysum} is @code{true},
a product of summations is expressed as a Cauchy product,
in which the index of the inner summation is a function of the
index of the outer one, rather than varying independently.

The global variable @code{genindex} is the alphabetic prefix used to generate
the next index of summation, when an automatically generated index is needed.

@code{gensumnum} is the numeric suffix used to generate the next index of
summation, when an automatically generated index is needed.
When @code{gensumnum} is @code{false}, an automatically-generated index is only
@code{genindex} with no numeric suffix.

See also @mrefcomma{lsum} @mrefcomma{sumcontract} @mrefcomma{intosum}
@mrefcomma{bashindices} @mrefcomma{niceindices}
@mrefcomma{nouns} @mrefcomma{evflag} and @ref{zeilberger-pkg}

Examples:

@c ===beg===
@c sum (i^2, i, 1, 7);
@c sum (a[i], i, 1, 7);
@c sum (a(i), i, 1, 7);
@c sum (a(i), i, 1, n);
@c sum (2^i + i^2, i, 0, n);
@c sum (2^i + i^2, i, 0, n), simpsum;
@c sum (1/3^i, i, 1, inf);
@c sum (1/3^i, i, 1, inf), simpsum;
@c sum (i^2, i, 1, 4) * sum (1/i^2, i, 1, inf);
@c sum (i^2, i, 1, 4) * sum (1/i^2, i, 1, inf), simpsum;
@c sum (integrate (x^k, x, 0, 1), k, 1, n);
@c sum (if k <= 5 then a^k else b^k, k, 1, 10);
@c ===end===

@example
(%i1) sum (i^2, i, 1, 7);
(%o1)                          140
(%i2) sum (a[i], i, 1, 7);
(%o2)           a  + a  + a  + a  + a  + a  + a
                 7    6    5    4    3    2    1
(%i3) sum (a(i), i, 1, 7);
(%o3)    a(7) + a(6) + a(5) + a(4) + a(3) + a(2) + a(1)
(%i4) sum (a(i), i, 1, n);
                            n
                           ====
                           \
(%o4)                       >    a(i)
                           /
                           ====
                           i = 1
(%i5) sum (2^i + i^2, i, 0, n);
                          n
                         ====
                         \       i    2
(%o5)                     >    (2  + i )
                         /
                         ====
                         i = 0
(%i6) sum (2^i + i^2, i, 0, n), simpsum;
                              3      2
                   n + 1   2 n  + 3 n  + n
(%o6)             2      + --------------- - 1
                                  6
(%i7) sum (1/3^i, i, 1, inf);
                            inf
                            ====
                            \     1
(%o7)                        >    --
                            /      i
                            ====  3
                            i = 1
(%i8) sum (1/3^i, i, 1, inf), simpsum;
                                1
(%o8)                           -
                                2
(%i9) sum (i^2, i, 1, 4) * sum (1/i^2, i, 1, inf);
                              inf
                              ====
                              \     1
(%o9)                      30  >    --
                              /      2
                              ====  i
                              i = 1
(%i10) sum (i^2, i, 1, 4) * sum (1/i^2, i, 1, inf), simpsum;
                                  2
(%o10)                       5 %pi
(%i11) sum (integrate (x^k, x, 0, 1), k, 1, n);
                            n
                           ====
                           \       1
(%o11)                      >    -----
                           /     k + 1
                           ====
                           k = 1
(%i12) sum (if k <= 5 then a^k else b^k, k, 1, 10);
          10    9    8    7    6    5    4    3    2
(%o12)   b   + b  + b  + b  + b  + a  + a  + a  + a  + a
@end example

@c @opencatbox
@c @category{Sums and products}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS CLARIFICATION, EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products)
@anchor{sumcontract}
@c @deffn {Function} sumcontract (@var{expr})
m4_deffn({Function}, sumcontract, <<<(@var{expr})>>>)

Combines all sums of an addition that have
upper and lower bounds that differ by constants.  The result is an
expression containing one summation for each set of such summations
added to all appropriate extra terms that had to be extracted to form
this sum.  @code{sumcontract} combines all compatible sums and uses one of
the indices from one of the sums if it can, and then try to form a
reasonable index if it cannot use any supplied.

@c WHEN IS intosum NECESSARY BEFORE sumcontract ??
It may be necessary to do an @code{intosum (@var{expr})} before the
@code{sumcontract}.

@c @opencatbox
@c @category{Sums and products}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products, Simplification flags and variables)
@anchor{sumexpand}
@c @defvr {Option variable} sumexpand
m4_defvr({Option variable}, sumexpand)
Default value: @code{false}

When @code{sumexpand} is @code{true}, products of sums and
exponentiated sums simplify to nested sums.

See also @mrefdot{cauchysum}

Examples:

@example
(%i1) sumexpand: true$
(%i2) sum (f (i), i, 0, m) * sum (g (j), j, 0, n);
@group
                     m      n
                    ====   ====
                    \      \
(%o2)                >      >     f(i1) g(i2)
                    /      /
                    ====   ====
                    i1 = 0 i2 = 0
@end group
(%i3) sum (f (i), i, 0, m)^2;
                     m      m
                    ====   ====
                    \      \
(%o3)                >      >     f(i3) f(i4)
                    /      /
                    ====   ====
                    i3 = 0 i4 = 0
@end example

@c @opencatbox
@c @category{Sums and products}
@c @category{Simplification flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@node Introduction to Series, Functions and Variables for Series, Functions and Variables for Sums and Products, Sums Products and Series
@section Introduction to Series
@c -----------------------------------------------------------------------------

Maxima contains functions @code{taylor} and @code{powerseries} for finding the 
series of differentiable functions.  It also has tools such as @code{nusum}
capable of finding the closed form of some series.  Operations such as addition
and multiplication work as usual on series.  This section presents the global
variables which control the expansion.

@c end concepts Series

@c -----------------------------------------------------------------------------
@node Functions and Variables for Series, Introduction to Fourier series, Introduction to Series, Sums Products and Series
@section Functions and Variables for Series
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products)
@anchor{cauchysum}
@c @defvr {Option variable} cauchysum
m4_defvr({Option variable}, cauchysum)
Default value: @code{false}

@c REPHRASE
When multiplying together sums with @code{inf} as their upper limit,
if @code{sumexpand} is @code{true} and @code{cauchysum} is @code{true}
then the Cauchy product will be used rather than the usual
product.
In the Cauchy product the index of the inner summation is a
function of the index of the outer one rather than varying
independently.

Example:

@c ===beg===
@c sumexpand: false$
@c cauchysum: false$
@c s: sum (f(i), i, 0, inf) * sum (g(j), j, 0, inf);
@c sumexpand: true$
@c cauchysum: true$
@c expand(s,0,0);
@c ===end===
@example
(%i1) sumexpand: false$
(%i2) cauchysum: false$
@group
(%i3) s: sum (f(i), i, 0, inf) * sum (g(j), j, 0, inf);
                      inf         inf
                      ====        ====
                      \           \
(%o3)                ( >    f(i))  >    g(j)
                      /           /
                      ====        ====
                      i = 0       j = 0
@end group
(%i4) sumexpand: true$
(%i5) cauchysum: true$
@group
(%i6) expand(s,0,0);
                 inf     i1
                 ====   ====
                 \      \
(%o6)             >      >     g(i1 - i2) f(i2)
                 /      /
                 ====   ====
                 i1 = 0 i2 = 0
@end group
@end example

@c @opencatbox
@c @category{Sums and products}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Power series)
@anchor{deftaylor}
@c @deffn {Function} deftaylor (@var{f_1}(@var{x_1}), @var{expr_1}, @dots{}, @var{f_n}(@var{x_n}), @var{expr_n})
m4_deffn({Function}, deftaylor, <<<(@var{f_1}(@var{x_1}), @var{expr_1}, @dots{}, @var{f_n}(@var{x_n}), @var{expr_n})>>>)

For each function @var{f_i} of one variable @var{x_i}, 
@code{deftaylor} defines @var{expr_i} as the Taylor series about zero.
@var{expr_i} is typically a polynomial in @var{x_i} or a summation;
more general expressions are accepted by @code{deftaylor} without complaint.

@code{powerseries (@var{f_i}(@var{x_i}), @var{x_i}, 0)}
returns the series defined by @code{deftaylor}.

@code{deftaylor} returns a list of the functions @var{f_1}, @dots{}, @var{f_n}.
@code{deftaylor} evaluates its arguments.

Example:

@example
(%i1) deftaylor (f(x), x^2 + sum(x^i/(2^i*i!^2), i, 4, inf));
(%o1)                          [f]
(%i2) powerseries (f(x), x, 0);
                      inf
                      ====      i1
                      \        x         2
(%o2)                  >     -------- + x
                      /       i1    2
                      ====   2   i1!
                      i1 = 4
(%i3) taylor (exp (sqrt (f(x))), x, 0, 4);
                      2         3          4
                     x    3073 x    12817 x
(%o3)/T/     1 + x + -- + ------- + -------- + . . .
                     2     18432     307200
@end example

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Power series)
@anchor{maxtayorder}
@c @defvr {Option variable} maxtayorder
m4_defvr({Option variable}, maxtayorder)
Default value: @code{true}

@c REPHRASE
When @code{maxtayorder} is @code{true}, then during algebraic
manipulation of (truncated) Taylor series, @code{taylor} tries to retain
as many terms as are known to be correct.

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products)
@anchor{niceindices}
@c @deffn {Function} niceindices (@var{expr})
m4_deffn({Function}, niceindices, <<<(@var{expr})>>>)

Renames the indices of sums and products in @var{expr}.  @code{niceindices}
attempts to rename each index to the value of @code{niceindicespref[1]}, unless
that name appears in the summand or multiplicand, in which case
@code{niceindices} tries the succeeding elements of @code{niceindicespref} in
turn, until an unused variable is found.  If the entire list is exhausted,
additional indices are constructed by appending integers to the value of
@code{niceindicespref[1]}, e.g., @code{i0}, @code{i1}, @code{i2}, @dots{}

@code{niceindices} returns an expression.
@code{niceindices} evaluates its argument.

Example:

@example
(%i1) niceindicespref;
(%o1)                  [i, j, k, l, m, n]
(%i2) product (sum (f (foo + i*j*bar), foo, 1, inf), bar, 1, inf);
                 inf    inf
                /===\   ====
                 ! !    \
(%o2)            ! !     >      f(bar i j + foo)
                 ! !    /
                bar = 1 ====
                        foo = 1
(%i3) niceindices (%);
@group
                     inf  inf
                    /===\ ====
                     ! !  \
(%o3)                ! !   >    f(i j l + k)
                     ! !  /
                    l = 1 ====
                          k = 1
@end group
@end example

@c @opencatbox
@c @category{Sums and products}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products)
@anchor{niceindicespref}
@c @defvr {Option variable} niceindicespref
m4_defvr({Option variable}, niceindicespref)
Default value: @code{[i, j, k, l, m, n]}

@code{niceindicespref} is the list from which @code{niceindices}
takes the names of indices for sums and products.

The elements of @code{niceindicespref} are typically names of variables,
although that is not enforced by @code{niceindices}.

Example:

@example
(%i1) niceindicespref: [p, q, r, s, t, u]$
(%i2) product (sum (f (foo + i*j*bar), foo, 1, inf), bar, 1, inf);
                 inf    inf
                /===\   ====
                 ! !    \
(%o2)            ! !     >      f(bar i j + foo)
                 ! !    /
                bar = 1 ====
                        foo = 1
(%i3) niceindices (%);
                     inf  inf
                    /===\ ====
                     ! !  \
(%o3)                ! !   >    f(i j q + p)
                     ! !  /
                    q = 1 ====
                          p = 1
@end example

@c @opencatbox
@c @category{Sums and products}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{nusum}
@c @deffn {Function} nusum (@var{expr}, @var{x}, @var{i_0}, @var{i_1})
m4_deffn({Function}, nusum, <<<(@var{expr}, @var{x}, @var{i_0}, @var{i_1})>>>)

Carries out indefinite hypergeometric summation of @var{expr} with
respect to @var{x} using a decision procedure due to R.W. Gosper.
@var{expr} and the result must be expressible as products of integer powers,
factorials, binomials, and rational functions.

@c UMM, DO WE REALLY NEED TO DEFINE "DEFINITE" AND "INDEFINITE" SUMMATION HERE ??
@c (CAN'T WE MAKE THE POINT WITHOUT DRAGGING IN SOME NONSTANDARD TERMINOLOGY ??)
The terms "definite"
and "indefinite summation" are used analogously to "definite" and
"indefinite integration".
To sum indefinitely means to give a symbolic result
for the sum over intervals of variable length, not just e.g. 0 to
inf.  Thus, since there is no formula for the general partial sum of
the binomial series, @code{nusum} can't do it.

@code{nusum} and @code{unsum} know a little about sums and differences of
finite products.  See also @mrefdot{unsum}

Examples:

@example
(%i1) nusum (n*n!, n, 0, n);

Dependent equations eliminated:  (1)
(%o1)                     (n + 1)! - 1
(%i2) nusum (n^4*4^n/binomial(2*n,n), n, 0, n);
                     4        3       2              n
      2 (n + 1) (63 n  + 112 n  + 18 n  - 22 n + 3) 4      2
(%o2) ------------------------------------------------ - ------
                    693 binomial(2 n, n)                 3 11 7
(%i3) unsum (%, n);
                              4  n
                             n  4
(%o3)                   ----------------
                        binomial(2 n, n)
(%i4) unsum (prod (i^2, i, 1, n), n);
                    n - 1
                    /===\
                     ! !   2
(%o4)              ( ! !  i ) (n - 1) (n + 1)
                     ! !
                    i = 1
(%i5) nusum (%, n, 1, n);

Dependent equations eliminated:  (2 3)
                            n
                          /===\
                           ! !   2
(%o5)                      ! !  i  - 1
                           ! !
                          i = 1
@end example

@c @opencatbox
@c @category{Sums and products}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c THIS ITEM NEEDS SERIOUS WORK

@c -----------------------------------------------------------------------------
m4_setcat(Power series)
@anchor{pade}
@c @deffn {Function} pade (@var{taylor_series}, @var{numer_deg_bound}, @var{denom_deg_bound})
m4_deffn({Function}, pade, <<<(@var{taylor_series}, @var{numer_deg_bound}, @var{denom_deg_bound})>>>)

Returns a list of
all rational functions which have the given Taylor series expansion
where the sum of the degrees of the numerator and the denominator is
less than or equal to the truncation level of the power series, i.e.
are "best" approximants, and which additionally satisfy the specified
degree bounds.

@var{taylor_series} is a univariate Taylor series.
@var{numer_deg_bound} and @var{denom_deg_bound}
are positive integers specifying degree bounds on
the numerator and denominator.

@var{taylor_series} can also be a Laurent series, and the degree
bounds can be @code{inf} which causes all rational functions whose total
degree is less than or equal to the length of the power series to be
returned.  Total degree is defined as @code{@var{numer_deg_bound} +
@var{denom_deg_bound}}.
Length of a power series is defined as
@code{"truncation level" + 1 - min(0, "order of series")}.

@example
(%i1) taylor (1 + x + x^2 + x^3, x, 0, 3);
                              2    3
(%o1)/T/             1 + x + x  + x  + . . .
(%i2) pade (%, 1, 1);
                                 1
(%o2)                       [- -----]
                               x - 1
(%i3) t: taylor(-(83787*x^10 - 45552*x^9 - 187296*x^8
                   + 387072*x^7 + 86016*x^6 - 1507328*x^5
                   + 1966080*x^4 + 4194304*x^3 - 25165824*x^2
                   + 67108864*x - 134217728)
       /134217728, x, 0, 10);
                    2    3       4       5       6        7
             x   3 x    x    15 x    23 x    21 x    189 x
(%o3)/T/ 1 - - + ---- - -- - ----- + ----- - ----- - ------
             2    16    32   1024    2048    32768   65536

                                  8         9          10
                            5853 x    2847 x    83787 x
                          + ------- + ------- - --------- + . . .
                            4194304   8388608   134217728
(%i4) pade (t, 4, 4);
(%o4)                          []
@end example

There is no rational function of degree 4 numerator/denominator, with this
power series expansion.  You must in general have degree of the numerator and
degree of the denominator adding up to at least the degree of the power series,
in order to have enough unknown coefficients to solve.

@example
(%i5) pade (t, 5, 5);
                     5                4                 3
(%o5) [- (520256329 x  - 96719020632 x  - 489651410240 x

                  2
 - 1619100813312 x  - 2176885157888 x - 2386516803584)

               5                 4                  3
/(47041365435 x  + 381702613848 x  + 1360678489152 x

                  2
 + 2856700692480 x  + 3370143559680 x + 2386516803584)]
@end example

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{powerseries}
@c @deffn {Function} powerseries (@var{expr}, @var{x}, @var{a})
m4_deffn({Function}, powerseries, <<<(@var{expr}, @var{x}, @var{a})>>>)

Returns the general form of the power series expansion for @var{expr} in the 
variable @var{x} about the point @var{a} (which may be @code{inf} for infinity):
@example
@group
           inf
           ====
           \               n
            >    b  (x - a)
           /      n
           ====
           n = 0
@end group
@end example

If @code{powerseries} is unable to expand @var{expr},
@code{taylor} may give the first several terms of the series.

When @code{verbose} is @code{true},
@code{powerseries} prints progress messages.

@example
(%i1) verbose: true$
(%i2) powerseries (log(sin(x)/x), x, 0);
can't expand 
                                 log(sin(x))
so we'll try again after applying the rule:
                                        d
                                      / -- (sin(x))
                                      [ dx
                        log(sin(x)) = i ----------- dx
                                      ]   sin(x)
                                      /
in the first simplification we have returned:
                             /
                             [
                             i cot(x) dx - log(x)
                             ]
                             /
                    inf
                    ====        i1  2 i1             2 i1
                    \      (- 1)   2     bern(2 i1) x
                     >     ------------------------------
                    /                i1 (2 i1)!
                    ====
                    i1 = 1
(%o2)                -------------------------------------
                                      2
@end example

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables)
@anchor{psexpand}
@c @defvr {Option variable} psexpand
m4_defvr({Option variable}, psexpand)
Default value: @code{false}

When @code{psexpand} is @code{true},
an extended rational function expression is displayed fully expanded.
The switch @code{ratexpand} has the same effect.

@c WE NEED TO BE EXPLICIT HERE
When @code{psexpand} is @code{false},
a multivariate expression is displayed just as in the rational function package.

@c TERMS OF WHAT ??
When @code{psexpand} is  @code{multi},
then terms with the same total degree in the variables are grouped together.

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Power series)
@anchor{revert}
@c @deffn  {Function} revert (@var{expr}, @var{x})
m4_deffn( {Function}, revert, <<<(@var{expr}, @var{x})>>>)
@c @deffnx {Function} revert2 (@var{expr}, @var{x}, @var{n})
m4_deffnx({Function}, revert2, <<<(@var{expr}, @var{x}, @var{n})>>>)

These functions return the reversion of @var{expr}, a Taylor series about zero
in the variable @var{x}.  @code{revert} returns a polynomial of degree equal to
the highest power in @var{expr}.  @code{revert2} returns a polynomial of degree
@var{n}, which may be greater than, equal to, or less than the degree of
@var{expr}.

@code{load ("revert")} loads these functions.

Examples:

@example
(%i1) load ("revert")$
(%i2) t: taylor (exp(x) - 1, x, 0, 6);
                   2    3    4    5     6
                  x    x    x    x     x
(%o2)/T/      x + -- + -- + -- + --- + --- + . . .
                  2    6    24   120   720
(%i3) revert (t, x);
               6       5       4       3       2
           10 x  - 12 x  + 15 x  - 20 x  + 30 x  - 60 x
(%o3)/R/ - --------------------------------------------
                                60
(%i4) ratexpand (%);
                     6    5    4    3    2
                    x    x    x    x    x
(%o4)             - -- + -- - -- + -- - -- + x
                    6    5    4    3    2
(%i5) taylor (log(x+1), x, 0, 6);
                    2    3    4    5    6
                   x    x    x    x    x
(%o5)/T/       x - -- + -- - -- + -- - -- + . . .
                   2    3    4    5    6
(%i6) ratsimp (revert (t, x) - taylor (log(x+1), x, 0, 6));
(%o6)                           0
(%i7) revert2 (t, x, 4);
                          4    3    2
                         x    x    x
(%o7)                  - -- + -- - -- + x
                         4    3    2
@end example

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Power series)
@anchor{taylor}
@c @deffn  {Function} taylor @
m4_deffn( {Function}, taylor, <<<>>>) @
@fname{taylor} (@var{expr}, @var{x}, @var{a}, @var{n}) @
@fname{taylor} (@var{expr}, [@var{x_1}, @var{x_2}, @dots{}], @var{a}, @var{n}) @
@fname{taylor} (@var{expr}, [@var{x}, @var{a}, @var{n}, 'asymp]) @
@fname{taylor} (@var{expr}, [@var{x_1}, @var{x_2}, @dots{}], [@var{a_1}, @var{a_2}, @dots{}], [@var{n_1}, @var{n_2}, @dots{}]) @
@fname{taylor} (@var{expr}, [@var{x_1}, @var{a_1}, @var{n_1}], [@var{x_2}, @var{a_2}, @var{n_2}], @dots{})

@code{taylor (@var{expr}, @var{x}, @var{a}, @var{n})} expands the expression
@var{expr} in a truncated Taylor or Laurent series in the variable @var{x}
around the point @var{a},
containing terms through @code{(@var{x} - @var{a})^@var{n}}.

If @var{expr} is of the form @code{@var{f}(@var{x})/@var{g}(@var{x})} and
@code{@var{g}(@var{x})} has no terms up to degree @var{n} then @code{taylor}
attempts to expand @code{@var{g}(@var{x})} up to degree @code{2 @var{n}}.
If there are still no nonzero terms, @code{taylor} doubles the degree of the
expansion of @code{@var{g}(@var{x})} so long as the degree of the expansion is
less than or equal to @code{@var{n} 2^taylordepth}.

@code{taylor (@var{expr}, [@var{x_1}, @var{x_2}, ...], @var{a}, @var{n})}
returns a truncated power series 
of degree @var{n} in all variables @var{x_1}, @var{x_2}, @dots{}
about the point @code{(@var{a}, @var{a}, ...)}.

@code{taylor (@var{expr}, [@var{x_1}, @var{a_1}, @var{n_1}], [@var{x_2},
@var{a_2}, @var{n_2}], ...)} returns a truncated power series in the variables
@var{x_1}, @var{x_2}, @dots{} about the point
@code{(@var{a_1}, @var{a_2}, ...)}, truncated at @var{n_1}, @var{n_2}, @dots{}

@code{taylor (@var{expr}, [@var{x_1}, @var{x_2}, ...], [@var{a_1},
@var{a_2}, ...], [@var{n_1}, @var{n_2}, ...])} returns a truncated power series
in the variables @var{x_1}, @var{x_2}, @dots{} about the point
@code{(@var{a_1}, @var{a_2}, ...)}, truncated at @var{n_1}, @var{n_2}, @dots{}

@code{taylor (@var{expr}, [@var{x}, @var{a}, @var{n}, 'asymp])} returns an
expansion of @var{expr} in negative powers of @code{@var{x} - @var{a}}.
The highest order term is @code{(@var{x} - @var{a})^@var{-n}}.

When @code{maxtayorder} is @code{true}, then during algebraic
manipulation of (truncated) Taylor series, @code{taylor} tries to retain
as many terms as are known to be correct.

When @code{psexpand} is @code{true},
an extended rational function expression is displayed fully expanded.
The switch @code{ratexpand} has the same effect.
When @code{psexpand} is @code{false},
a multivariate expression is displayed just as in the rational function package.
When @code{psexpand} is  @code{multi},
then terms with the same total degree in the variables are grouped together.

See also the @mref{taylor_logexpand} switch for controlling expansion.

Examples:

@c EXAMPLES ADAPTED FROM example (taylor)
@c taylor (sqrt (sin(x) + a*x + 1), x, 0, 3);
@c %^2;
@c taylor (sqrt (x + 1), x, 0, 5);
@c %^2;
@c product ((1 + x^i)^2.5, i, 1, inf)/(1 + x^2);
@c ev (taylor(%, x,  0, 3), keepfloat);
@c taylor (1/log (x + 1), x, 0, 3);
@c taylor (cos(x) - sec(x), x, 0, 5);
@c taylor ((cos(x) - sec(x))^3, x, 0, 5);
@c taylor (1/(cos(x) - sec(x))^3, x, 0, 5);
@c taylor (sqrt (1 - k^2*sin(x)^2), x, 0, 6);
@c taylor ((x + 1)^n, x, 0, 4);
@c taylor (sin (y + x), x, 0, 3, y, 0, 3);
@c taylor (sin (y + x), [x, y], 0, 3);
@c taylor (1/sin (y + x), x, 0, 3, y, 0, 3);
@c taylor (1/sin (y + x), [x, y], 0, 3);
@example
(%i1) taylor (sqrt (sin(x) + a*x + 1), x, 0, 3);
                           2             2
             (a + 1) x   (a  + 2 a + 1) x
(%o1)/T/ 1 + --------- - -----------------
                 2               8

                                   3      2             3
                               (3 a  + 9 a  + 9 a - 1) x
                             + -------------------------- + . . .
                                           48
(%i2) %^2;
                                    3
                                   x
(%o2)/T/           1 + (a + 1) x - -- + . . .
                                   6
(%i3) taylor (sqrt (x + 1), x, 0, 5);
                       2    3      4      5
                  x   x    x    5 x    7 x
(%o3)/T/      1 + - - -- + -- - ---- + ---- + . . .
                  2   8    16   128    256
(%i4) %^2;
(%o4)/T/                  1 + x + . . .
(%i5) product ((1 + x^i)^2.5, i, 1, inf)/(1 + x^2);
@group
                         inf
                        /===\
                         ! !    i     2.5
                         ! !  (x  + 1)
                         ! !
                        i = 1
(%o5)                   -----------------
                              2
                             x  + 1
@end group
(%i6) ev (taylor(%, x,  0, 3), keepfloat);
                               2           3
(%o6)/T/    1 + 2.5 x + 3.375 x  + 6.5625 x  + . . .
(%i7) taylor (1/log (x + 1), x, 0, 3);
                               2       3
                 1   1   x    x    19 x
(%o7)/T/         - + - - -- + -- - ----- + . . .
                 x   2   12   24    720
(%i8) taylor (cos(x) - sec(x), x, 0, 5);
                                4
                           2   x
(%o8)/T/                - x  - -- + . . .
                               6
(%i9) taylor ((cos(x) - sec(x))^3, x, 0, 5);
(%o9)/T/                    0 + . . .
(%i10) taylor (1/(cos(x) - sec(x))^3, x, 0, 5);
                                               2          4
            1     1       11      347    6767 x    15377 x
(%o10)/T/ - -- + ---- + ------ - ----- - ------- - --------
             6      4        2   15120   604800    7983360
            x    2 x    120 x

                                                          + . . .
(%i11) taylor (sqrt (1 - k^2*sin(x)^2), x, 0, 6);
               2  2       4      2   4
              k  x    (3 k  - 4 k ) x
(%o11)/T/ 1 - ----- - ----------------
                2            24

                                    6       4       2   6
                               (45 k  - 60 k  + 16 k ) x
                             - -------------------------- + . . .
                                          720
(%i12) taylor ((x + 1)^n, x, 0, 4);
@group
                      2       2     3      2         3
                    (n  - n) x    (n  - 3 n  + 2 n) x
(%o12)/T/ 1 + n x + ----------- + --------------------
                         2                 6

                               4      3       2         4
                             (n  - 6 n  + 11 n  - 6 n) x
                           + ---------------------------- + . . .
                                          24
@end group
(%i13) taylor (sin (y + x), x, 0, 3, y, 0, 3);
               3                 2
              y                 y
(%o13)/T/ y - -- + . . . + (1 - -- + . . .) x
              6                 2

                    3                       2
               y   y            2      1   y            3
          + (- - + -- + . . .) x  + (- - + -- + . . .) x  + . . .
               2   12                  6   12
(%i14) taylor (sin (y + x), [x, y], 0, 3);
                     3        2      2      3
                    x  + 3 y x  + 3 y  x + y
(%o14)/T/   y + x - ------------------------- + . . .
                                6
(%i15) taylor (1/sin (y + x), x, 0, 3, y, 0, 3);
          1   y              1    1               1            2
(%o15)/T/ - + - + . . . + (- -- + - + . . .) x + (-- + . . .) x
          y   6               2   6                3
                             y                    y

                                           1            3
                                      + (- -- + . . .) x  + . . .
                                            4
                                           y
(%i16) taylor (1/sin (y + x), [x, y], 0, 3);
                             3         2       2        3
            1     x + y   7 x  + 21 y x  + 21 y  x + 7 y
(%o16)/T/ ----- + ----- + ------------------------------- + . . .
          x + y     6                   360
@end example

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{taylordepth}
@c @defvr {Option variable} taylordepth
m4_defvr({Option variable}, taylordepth)
Default value: 3

@c UM, THE CONTEXT FOR THIS REMARK NEEDS TO BE ESTABLISHED
If there are still no nonzero terms, @code{taylor} doubles the degree of the
expansion of @code{@var{g}(@var{x})} so long as the degree of the expansion is
less than or equal to @code{@var{n} 2^taylordepth}.

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Power series)
@anchor{taylorinfo}
@c @deffn {Function} taylorinfo (@var{expr})
m4_deffn({Function}, taylorinfo, <<<(@var{expr})>>>)

Returns information about the Taylor series @var{expr}.
The return value is a list of lists.
Each list comprises the name of a variable,
the point of expansion, and the degree of the expansion.

@code{taylorinfo} returns @code{false} if @var{expr} is not a Taylor series.

Example:

@example
(%i1) taylor ((1 - y^2)/(1 - x), x, 0, 3, [y, a, inf]);
                  2                       2
(%o1)/T/ - (y - a)  - 2 a (y - a) + (1 - a )

         2                        2
 + (1 - a  - 2 a (y - a) - (y - a) ) x

         2                        2   2
 + (1 - a  - 2 a (y - a) - (y - a) ) x

         2                        2   3
 + (1 - a  - 2 a (y - a) - (y - a) ) x  + . . .
(%i2) taylorinfo(%);
(%o2)               [[y, a, inf], [x, 0, 3]]
@end example

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Predicate functions, Power series)
@anchor{taylorp}
@c @deffn {Function} taylorp (@var{expr})
m4_deffn({Function}, taylorp, <<<(@var{expr})>>>)

Returns @code{true} if @var{expr} is a Taylor series,
and @code{false} otherwise.

@c @opencatbox
@c @category{Predicate functions}
@c @category{Power series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c WHAT IS THIS ABOUT EXACTLY ??

@c -----------------------------------------------------------------------------
m4_setcat(Power series, Exponential and logarithm functions)
@anchor{taylor_logexpand}
@c @defvr {Option variable} taylor_logexpand
m4_defvr({Option variable}, taylor_logexpand)
Default value: @code{true}

@code{taylor_logexpand} controls expansions of logarithms in
@code{taylor} series.

When @code{taylor_logexpand} is @code{true}, all logarithms are expanded fully
so that zero-recognition problems involving logarithmic identities do not
disturb the expansion process.  However, this scheme is not always
mathematically correct since it ignores branch information.

When @code{taylor_logexpand} is set to @code{false}, then the only expansion of
logarithms that occur is that necessary to obtain a formal power series.

@c NEED EXAMPLES HERE
@c @opencatbox
@c @category{Power series}
@c @category{Exponential and logarithm functions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Power series)
@anchor{taylor_order_coefficients}
@c @defvr {Option variable} taylor_order_coefficients
m4_defvr({Option variable}, taylor_order_coefficients)
Default value: @code{true}

@code{taylor_order_coefficients} controls the ordering of
coefficients in a Taylor series.

When @code{taylor_order_coefficients} is @code{true},
coefficients of taylor series are ordered canonically.
@c IS MAXIMA'S NOTION OF "CANONICALLY" DESCRIBED ELSEWHERE ??
@c AND WHAT HAPPENS WHEN IT IS FALSE ??

@c NEED EXAMPLES HERE
@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Power series)
@anchor{taylor_simplifier}
@c @deffn {Function} taylor_simplifier (@var{expr})
m4_deffn({Function}, taylor_simplifier, <<<(@var{expr})>>>)

Simplifies coefficients of the power series @var{expr}.
@code{taylor} calls this function.

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{taylor_truncate_polynomials}
@c @defvr {Option variable} taylor_truncate_polynomials
m4_defvr({Option variable}, taylor_truncate_polynomials)
Default value: @code{true}

@c WHAT IS THE "INPUT TRUNCATION LEVEL" ?? THE ARGUMENT n OF taylor ??
When @code{taylor_truncate_polynomials} is @code{true},
polynomials are truncated based upon the input truncation levels.

Otherwise,
polynomials input to @code{taylor} are considered to have infinite precison.
@c WHAT IS "INFINITE PRECISION" IN THIS CONTEXT ??

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Power series, Rational expressions)
@anchor{taytorat}
@c @deffn {Function} taytorat (@var{expr})
m4_deffn({Function}, taytorat, <<<(@var{expr})>>>)

Converts @var{expr} from @code{taylor} form to canonical rational expression
(CRE) form.  The effect is the same as @code{rat (ratdisrep (@var{expr}))}, but
faster.

@c @opencatbox
@c @category{Power series}
@c @category{Rational expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Power series)
@anchor{trunc}
@c @deffn {Function} trunc (@var{expr})
m4_deffn({Function}, trunc, <<<(@var{expr})>>>)

Annotates the internal representation of the general expression @var{expr}
so that it is displayed as if its sums were truncated Taylor series.
@var{expr} is not otherwise modified.

Example:

@example
(%i1) expr: x^2 + x + 1;
                            2
(%o1)                      x  + x + 1
(%i2) trunc (expr);
                                2
(%o2)                  1 + x + x  + . . .
(%i3) is (expr = trunc (expr));
(%o3)                         true
@end example

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Sums and products)
@anchor{unsum}
@c @deffn {Function} unsum (@var{f}, @var{n})
m4_deffn({Function}, unsum, <<<(@var{f}, @var{n})>>>)

Returns the first backward difference
@code{@var{f}(@var{n}) - @var{f}(@var{n} - 1)}.
Thus @code{unsum} in a sense is the inverse of @code{sum}.

See also @mrefdot{nusum}

Examples:
@c GENERATED FROM THE FOLLOWING INPUTS
@c g(p) := p*4^n/binomial(2*n,n);
@c g(n^4);
@c nusum (%, n, 0, n);
@c unsum (%, n);

@example
(%i1) g(p) := p*4^n/binomial(2*n,n);
                                     n
                                  p 4
(%o1)               g(p) := ----------------
                            binomial(2 n, n)
(%i2) g(n^4);
                              4  n
                             n  4
(%o2)                   ----------------
                        binomial(2 n, n)
(%i3) nusum (%, n, 0, n);
                     4        3       2              n
      2 (n + 1) (63 n  + 112 n  + 18 n  - 22 n + 3) 4      2
(%o3) ------------------------------------------------ - ------
                    693 binomial(2 n, n)                 3 11 7
(%i4) unsum (%, n);
                              4  n
                             n  4
(%o4)                   ----------------
                        binomial(2 n, n)
@end example

@c @opencatbox
@c @category{Sums and products}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{verbose}
@c @defvr {Option variable} verbose
m4_defvr({Option variable}, verbose)
Default value: @code{false}

When @code{verbose} is @code{true},
@code{powerseries} prints progress messages.

@c @opencatbox
@c @category{Power series}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@node Introduction to Fourier series, Functions and Variables for Fourier series, Functions and Variables for Series, Sums Products and Series
@section Introduction to Fourier series
@c -----------------------------------------------------------------------------

The @code{fourie} package comprises functions for the symbolic computation
of Fourier series.
There are functions in the @code{fourie} package to calculate Fourier integral
coefficients and some functions for manipulation of expressions.

@opencatbox
@category{Fourier transform}
@category{Share packages}
@category{Package fourie}
@closecatbox

@c -----------------------------------------------------------------------------
@node Functions and Variables for Fourier series, Functions and Variables for Poisson series, Introduction to Fourier series, Sums Products and Series
@section Functions and Variables for Fourier series
@c -----------------------------------------------------------------------------

@c REPHRASE

@c -----------------------------------------------------------------------------
m4_setcat(Package fourie)
@anchor{equalp}
@c @deffn {Function} equalp (@var{x}, @var{y})
m4_deffn({Function}, equalp, <<<(@var{x}, @var{y})>>>)

Returns @code{true} if @code{equal (@var{x}, @var{y})} otherwise @code{false}
(doesn't give an error message like @code{equal (x, y)} would do in this case).

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{remfun}
@c @deffn  {Function} remfun @
m4_deffn( {Function}, remfun, <<<>>>) @
@fname{remfun} (@var{f}, @var{expr}) @
@fname{remfun} (@var{f}, @var{expr}, @var{x})

@code{remfun (@var{f}, @var{expr})} replaces all occurrences of @code{@var{f}
(@var{arg})} by @var{arg} in @var{expr}.

@code{remfun (@var{f}, @var{expr}, @var{x})} replaces all occurrences of
@code{@var{f} (@var{arg})} by @var{arg} in @var{expr} only if @var{arg} contains
the variable @var{x}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{funp}
@c @deffn  {Function} funp @
m4_deffn( {Function}, funp, <<<>>>) @
@fname{funp} (@var{f}, @var{expr}) @
@fname{funp} (@var{f}, @var{expr}, @var{x})

@code{funp (@var{f}, @var{expr})}
returns @code{true} if @var{expr} contains the function @var{f}.

@code{funp (@var{f}, @var{expr}, @var{x})}
returns @code{true} if @var{expr} contains the function @var{f} and the variable
@var{x} is somewhere in the argument of one of the instances of @var{f}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Package fourie, Integral calculus)
@anchor{absint}
@c @deffn  {Function} absint @
m4_deffn( {Function}, absint, <<<>>>) @
@fname{absint} (@var{f}, @var{x}, @var{halfplane}) @
@fname{absint} (@var{f}, @var{x}) @
@fname{absint} (@var{f}, @var{x}, @var{a}, @var{b})

@code{absint (@var{f}, @var{x}, @var{halfplane})}
returns the indefinite integral of @var{f} with respect to
@var{x} in the given halfplane (@code{pos}, @code{neg}, or @code{both}).
@var{f} may contain expressions of the form
@code{abs (x)}, @code{abs (sin (x))}, @code{abs (a) * exp (-abs (b) * abs (x))}.

@code{absint (@var{f}, @var{x})} is equivalent to
@code{absint (@var{f}, @var{x}, pos)}.

@code{absint (@var{f}, @var{x}, @var{a}, @var{b})} returns the definite integral
of @var{f} with respect to @var{x} from @var{a} to @var{b}.
@c SAME LIST AS ABOVE ??
@var{f} may include absolute values.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @category{Integral calculus}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS EXPANSION

@c -----------------------------------------------------------------------------
m4_setcat(Package fourie)
@anchor{fourier}
@c @deffn {Function} fourier (@var{f}, @var{x}, @var{p})
m4_deffn({Function}, fourier, <<<(@var{f}, @var{x}, @var{p})>>>)

Returns a list of the Fourier coefficients of @code{@var{f}(@var{x})} defined
on the interval @code{[-p, p]}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEES EXPANSION. WHAT IS THE ARGUMENT l ??

@c -----------------------------------------------------------------------------
m4_setcat(Package fourie, Trigonometric functions, Simplification functions)
@anchor{foursimp}
@c @deffn {Function} foursimp (@var{l})
m4_deffn({Function}, foursimp, <<<(@var{l})>>>)

Simplifies @code{sin (n %pi)} to 0 if @code{sinnpiflag} is @code{true} and
@code{cos (n %pi)} to @code{(-1)^n} if @code{cosnpiflag} is @code{true}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @category{Trigonometric functions}
@c @category{Simplification functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Package fourie)
@anchor{sinnpiflag}
@c @defvr {Option variable} sinnpiflag
m4_defvr({Option variable}, sinnpiflag)
Default value: @code{true}

See @code{foursimp}.

@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{cosnpiflag}
@c @defvr {Option variable} cosnpiflag
m4_defvr({Option variable}, cosnpiflag)
Default value: @code{true}

See @code{foursimp}.

@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS EXPANSION. EXPLAIN x AND p HERE (DO NOT REFER SOMEWHERE ELSE)

@c -----------------------------------------------------------------------------
m4_setcat(Package fourie)
@anchor{fourexpand}
@c @deffn {Function} fourexpand (@var{l}, @var{x}, @var{p}, @var{limit})
m4_deffn({Function}, fourexpand, <<<(@var{l}, @var{x}, @var{p}, @var{limit})>>>)

Constructs and returns the Fourier series from the list of Fourier coefficients
@var{l} up through @var{limit} terms (@var{limit} may be @code{inf}).  @var{x}
and @var{p} have same meaning as in @code{fourier}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS EXPANSION

@c -----------------------------------------------------------------------------
@anchor{fourcos}
@c @deffn {Function} fourcos (@var{f}, @var{x}, @var{p})
m4_deffn({Function}, fourcos, <<<(@var{f}, @var{x}, @var{p})>>>)

Returns the Fourier cosine coefficients for @code{@var{f}(@var{x})} defined on
@code{[0, @var{p}]}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS EXPANSION

@c -----------------------------------------------------------------------------
@anchor{foursin}
@c @deffn {Function} foursin (@var{f}, @var{x}, @var{p})
m4_deffn({Function}, foursin, <<<(@var{f}, @var{x}, @var{p})>>>)

Returns the Fourier sine coefficients for @code{@var{f}(@var{x})} defined on
@code{[0, @var{p}]}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS EXPANSION

@c -----------------------------------------------------------------------------
@anchor{totalfourier}
@c @deffn {Function} totalfourier (@var{f}, @var{x}, @var{p})
m4_deffn({Function}, totalfourier, <<<(@var{f}, @var{x}, @var{p})>>>)

Returns @code{fourexpand (foursimp (fourier (@var{f}, @var{x}, @var{p})),
@var{x}, @var{p}, 'inf)}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS EXPANSION

@c -----------------------------------------------------------------------------
@anchor{fourint}
@c @deffn {Function} fourint (@var{f}, @var{x})
m4_deffn({Function}, fourint, <<<(@var{f}, @var{x})>>>)

Constructs and returns a list of the Fourier integral coefficients of
@code{@var{f}(@var{x})} defined on @code{[minf, inf]}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS EXPANSION

@c -----------------------------------------------------------------------------
@anchor{fourintcos}
@c @deffn {Function} fourintcos (@var{f}, @var{x})
m4_deffn({Function}, fourintcos, <<<(@var{f}, @var{x})>>>)

Returns the Fourier cosine integral coefficients for @code{@var{f}(@var{x})}
on @code{[0, inf]}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS EXPANSION

@c -----------------------------------------------------------------------------
@anchor{forintsin}
@c @deffn {Function} fourintsin (@var{f}, @var{x})
m4_deffn({Function}, fourintsin, <<<(@var{f}, @var{x})>>>)

Returns the Fourier sine integral coefficients for @code{@var{f}(@var{x})} on
@code{[0, inf]}.

@c NEEDS EXAMPLES
@c @opencatbox
@c @category{Package fourie}
@c @closecatbox
@c @end deffn
m4_end_deffn()


@c -----------------------------------------------------------------------------
@node Functions and Variables for Poisson series, , Functions and Variables for Fourier series, Sums Products and Series
@section Functions and Variables for Poisson series
@c -----------------------------------------------------------------------------

@c NEED EXAMPLES HERE

@c -----------------------------------------------------------------------------
m4_setcat(Poisson series)
@anchor{intopois}
@c @deffn {Function} intopois (@var{a})
m4_deffn({Function}, intopois, <<<(@var{a})>>>)
Converts @var{a} into a Poisson encoding.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEED EXAMPLES HERE

@c -----------------------------------------------------------------------------
@anchor{outopois}
@c @deffn {Function} outofpois (@var{a})
m4_deffn({Function}, outofpois, <<<(@var{a})>>>)

Converts @var{a} from Poisson encoding to general representation.  If @var{a} is
not in Poisson form, @code{outofpois} carries out the conversion,
i.e., the return value is @code{outofpois (intopois (@var{a}))}.
This function is thus a canonical simplifier
for sums of powers of sine and cosine terms of a particular type.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEED MORE INFO HERE
@c NEED EXAMPLES HERE

@c -----------------------------------------------------------------------------
@anchor{poisdiff}
@c @deffn {Function} poisdiff (@var{a}, @var{b})
m4_deffn({Function}, poisdiff, <<<(@var{a}, @var{b})>>>)

Differentiates @var{a} with respect to @var{b}. @var{b} must occur only
in the trig arguments or only in the coefficients.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c LOOKING AT THE CODE IN src/pois3.lisp, THIS FCN SEEMS TO COMPUTE THE EXPONENT
@c BY MULTIPLYING IN A LOOP DUNNO HOW WE WANT TO EXPLAIN THAT
@c REPHRASE WITHOUT USING THE TERM "FUNCTIONALLY IDENTICAL"

@c -----------------------------------------------------------------------------
@anchor{poisexpt}
@c @deffn {Function} poisexpt (@var{a}, @var{b})
m4_deffn({Function}, poisexpt, <<<(@var{a}, @var{b})>>>)

Functionally identical to @code{intopois (@var{a}^@var{b})}.
@var{b} must be a positive integer.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c WHAT IS THIS ABOUT ??

@c -----------------------------------------------------------------------------
@anchor{poisint}
@c @deffn {Function} poisint (@var{a}, @var{b})
m4_deffn({Function}, poisint, <<<(@var{a}, @var{b})>>>)

Integrates in a similarly restricted sense (to @code{poisdiff}).  Non-periodic
terms in @var{b} are dropped if @var{b} is in the trig arguments.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{poislim}
@c @defvr {Option variable} poislim
m4_defvr({Option variable}, poislim)
Default value: 5

@code{poislim} determines the domain of the coefficients in
the arguments of the trig functions.  The initial value of 5
corresponds to the interval [-2^(5-1)+1,2^(5-1)], or [-15,16], but it
can be set to [-2^(n-1)+1, 2^(n-1)].

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c UMM, WHAT IS THIS ABOUT EXACTLY ?? EXAMPLES NEEDED

@c -----------------------------------------------------------------------------
@anchor{poismap}
@c @deffn {Function} poismap (@var{series}, @var{sinfn}, @var{cosfn})
m4_deffn({Function}, poismap, <<<(@var{series}, @var{sinfn}, @var{cosfn})>>>)

will map the functions @var{sinfn} on the sine terms and @var{cosfn} on the
cosine terms of the Poisson series given.  @var{sinfn} and @var{cosfn} are
functions of two arguments which are a coefficient and a trigonometric part of
a term in series respectively.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c REPHRASE WITHOUT USING THE TERM "FUNCTIONALLY IDENTICAL"

@c -----------------------------------------------------------------------------
@anchor{poisplus}
@c @deffn {Function} poisplus (@var{a}, @var{b})
m4_deffn({Function}, poisplus, <<<(@var{a}, @var{b})>>>)

Is functionally identical to @code{intopois (a + b)}.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{poissimp}
@c @deffn {Function} poissimp (@var{a})
m4_deffn({Function}, poissimp, <<<(@var{a})>>>)

Converts @var{a} into a Poisson series for @var{a} in general
representation.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c MORE INFO NEEDED HERE

@c -----------------------------------------------------------------------------
m4_setcat(Poisson series)
@anchor{poisson}
@c @defvr {Special symbol} poisson
m4_defvr({Special symbol}, poisson)

The symbol @code{/P/} follows the line label of Poisson series
expressions.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{poissubst}
@c @deffn {Function} poissubst (@var{a}, @var{b}, @var{c})
m4_deffn({Function}, poissubst, <<<(@var{a}, @var{b}, @var{c})>>>)

Substitutes @var{a} for @var{b} in @var{c}.  @var{c} is a Poisson series.

(1) Where @var{B} is a variable @var{u}, @var{v}, @var{w}, @var{x}, @var{y},
or @var{z}, then @var{a} must be an expression linear in those variables (e.g.,
@code{6*u + 4*v}).

(2) Where @var{b} is other than those variables, then @var{a} must also be
free of those variables, and furthermore, free of sines or cosines.

@code{poissubst (@var{a}, @var{b}, @var{c}, @var{d}, @var{n})} is a special type
of substitution which operates on @var{a} and @var{b} as in type (1) above, but
where @var{d} is a Poisson series, expands @code{cos(@var{d})} and
@code{sin(@var{d})} to order @var{n} so as to provide the result of substituting
@code{@var{a} + @var{d}} for @var{b} in @var{c}.  The idea is that @var{d} is an
expansion in terms of a small parameter.  For example,
@code{poissubst (u, v, cos(v), %e, 3)} yields
@code{cos(u)*(1 - %e^2/2) - sin(u)*(%e - %e^3/6)}.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c REPHRASE WITHOUT USING THE TERM "FUNCTIONALLY IDENTICAL"

@c -----------------------------------------------------------------------------
@anchor{poistimes}
@c @deffn {Function} poistimes (@var{a}, @var{b})
m4_deffn({Function}, poistimes, <<<(@var{a}, @var{b})>>>)

Is functionally identical to @code{intopois (@var{a}*@var{b})}.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c HOW DOES THIS WORK ?? NEED MORE INFO AND EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{poistrim}
@c @deffn {Function} poistrim ()
m4_deffn({Function}, poistrim, <<<()>>>)

is a reserved function name which (if the user has defined
it) gets applied during Poisson multiplication.  It is a predicate
function of 6 arguments which are the coefficients of the @var{u}, @var{v}, ..., @var{z}
in a term.  Terms for which @code{poistrim} is @code{true} (for the coefficients of
that term) are eliminated during multiplication.

@c @opencatbox
@c @category{Poisson series}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Poisson series, Display functions)
@anchor{printpois}
@c @deffn {Function} printpois (@var{a})
m4_deffn({Function}, printpois, <<<(@var{a})>>>)

Prints a Poisson series in a readable format.  In common
with @code{outofpois}, it will convert @var{a} into a Poisson encoding first, if
necessary.

@c @opencatbox
@c @category{Poisson series}
@c @category{Display functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()
