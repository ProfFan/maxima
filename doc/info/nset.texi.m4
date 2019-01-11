@c -*- Mode: texinfo -*-
@menu
* Introduction to Sets::       
* Functions and Variables for Sets::       
@end menu

@node Introduction to Sets, Functions and Variables for Sets, Sets, Sets
@section Introduction to Sets

Maxima provides set functions, such as intersection and 
union, for finite sets that are defined by explicit enumeration.
Maxima treats 
lists and sets as distinct objects. This feature makes it possible to
work with sets that have members that are either lists or sets.

In addition to functions for finite sets, Maxima provides some
functions related to combinatorics; these include the Stirling
numbers of the first and second kind, the Bell numbers, multinomial
coefficients, partitions of nonnegative integers, and a few others. 
Maxima also defines a Kronecker delta function.

@subsection Usage

To construct a set with members @code{a_1, ..., a_n}, write
@code{set(a_1, ..., a_n)} or @code{@{a_1, ..., a_n@}};
to construct the empty set, write @code{set()} or @code{@{@}}.
In input, @code{set(...)} and @code{@{ ... @}} are equivalent.
Sets are always displayed with curly braces.

If a member is listed more than
once, simplification eliminates the redundant member.

@c ===beg===
@c set();
@c set(a, b, a);
@c set(a, set(b));
@c set(a, [b]);
@c {};
@c {a, b, a};
@c {a, {b}};
@c {a, [b]};
@c ===end===
@example
(%i1) set();
(%o1)                          @{@}
(%i2) set(a, b, a);
(%o2)                        @{a, b@}
(%i3) set(a, set(b));
(%o3)                       @{a, @{b@}@}
(%i4) set(a, [b]);
(%o4)                       @{a, [b]@}
(%i5) @{@};
(%o5)                          @{@}
(%i6) @{a, b, a@};
(%o6)                        @{a, b@}
(%i7) @{a, @{b@}@};
(%o7)                       @{a, @{b@}@}
(%i8) @{a, [b]@};
(%o8)                       @{a, [b]@}
@end example

Two would-be elements @var{x} and @var{y} are redundant
(i.e., considered the same for the purpose of set construction)
if and only if @code{is(@var{x} = @var{y})} yields @code{true}.
@c THAT IS BECAUSE THE SET SIMPLIFICATION CODE CALLS THE LISP FUNCTION LIKE,
@c AND SO DOES THE CODE TO EVALUATE IS (X = Y).
Note that @code{is(equal(@var{x}, @var{y}))} can yield @code{true}
while @code{is(@var{x} = @var{y})} yields @code{false};
in that case the elements @var{x} and @var{y} are considered distinct.

@c ===beg===
@c x: a/c + b/c;
@c y: a/c + b/c;
@c z: (a + b)/c;
@c is (x = y);
@c is (y = z);
@c is (equal (y, z));
@c y - z;
@c ratsimp (%);
@c {x, y, z};
@c ===end===
@example
(%i1) x: a/c + b/c;
                              b   a
(%o1)                         - + -
                              c   c
(%i2) y: a/c + b/c;
                              b   a
(%o2)                         - + -
                              c   c
(%i3) z: (a + b)/c;
                              b + a
(%o3)                         -----
                                c
(%i4) is (x = y);
(%o4)                         true
(%i5) is (y = z);
(%o5)                         false
(%i6) is (equal (y, z));
(%o6)                         true
(%i7) y - z;
                           b + a   b   a
(%o7)                    - ----- + - + -
                             c     c   c
(%i8) ratsimp (%);
(%o8)                           0
(%i9) @{x, y, z@};
                          b + a  b   a
(%o9)                    @{-----, - + -@}
                            c    c   c
@end example

To construct a set from the elements of a list, use @code{setify}.

@c ===beg===
@c setify ([b, a]);
@c ===end===
@example
(%i1) setify ([b, a]);
(%o1)                        @{a, b@}
@end example

Set members @code{x} and @code{y} are equal provided @code{is(x = y)} 
evaluates to @code{true}. Thus @code{rat(x)} and @code{x} are equal as set
members; consequently, 

@c ===beg===
@c {x, rat(x)};
@c ===end===
@example
(%i1) @{x, rat(x)@};
(%o1)                          @{x@}
@end example

Further, since @code{is((x - 1)*(x + 1) = x^2 - 1)} evaluates to @code{false}, 
@code{(x - 1)*(x + 1)} and @code{x^2 - 1} are distinct set members; thus 

@c ===beg===
@c {(x - 1)*(x + 1), x^2 - 1};
@c ===end===
@example
(%i1) @{(x - 1)*(x + 1), x^2 - 1@};
                                       2
(%o1)               @{(x - 1) (x + 1), x  - 1@}
@end example

To reduce this set to a singleton set, apply @code{rat} to each set member:

@c ===beg===
@c {(x - 1)*(x + 1), x^2 - 1};
@c map (rat, %);
@c ===end===
@example
(%i1) @{(x - 1)*(x + 1), x^2 - 1@};
                                       2
(%o1)               @{(x - 1) (x + 1), x  - 1@}
(%i2) map (rat, %);
                              2
(%o2)/R/                    @{x  - 1@}
@end example

To remove redundancies from other sets, you may need to use other
simplification functions. Here is an example that uses @code{trigsimp}:

@c ===beg===
@c {1, cos(x)^2 + sin(x)^2};
@c map (trigsimp, %);
@c ===end===
@example
(%i1) @{1, cos(x)^2 + sin(x)^2@};
                            2         2
(%o1)                @{1, sin (x) + cos (x)@}
(%i2) map (trigsimp, %);
(%o2)                          @{1@}
@end example

A set is simplified when its members are non-redundant and
sorted. The current version of the set functions uses the Maxima function
@code{orderlessp} to order sets; however, @i{future versions of 
the set functions might use a different ordering function}.

Some operations on sets, such as substitution, automatically force a 
re-simplification; for example,

@c ===beg===
@c s: {a, b, c}$
@c subst (c=a, s);
@c subst ([a=x, b=x, c=x], s);
@c map (lambda ([x], x^2), set (-1, 0, 1));
@c ===end===
@example
(%i1) s: @{a, b, c@}$
(%i2) subst (c=a, s);
(%o2)                        @{a, b@}
(%i3) subst ([a=x, b=x, c=x], s);
(%o3)                          @{x@}
(%i4) map (lambda ([x], x^2), set (-1, 0, 1));
(%o4)                        @{0, 1@}
@end example

Maxima treats lists and sets as distinct objects;
functions such as @code{union} and @code{intersection} complain
if any argument is not a set. If you need to apply a set
function to a list, use the @code{setify} function to convert it
to a set. Thus

@c ===beg===
@c union ([1, 2], {a, b});
@c union (setify ([1, 2]), {a, b});
@c ===end===
@example
(%i1) union ([1, 2], @{a, b@});
Function union expects a set, instead found [1,2]
 -- an error.  Quitting.  To debug this try debugmode(true);
(%i2) union (setify ([1, 2]), @{a, b@});
(%o2)                     @{1, 2, a, b@}
@end example

To extract all set elements of a set @code{s} that satisfy a predicate
@code{f}, use @code{subset(s, f)}. (A @i{predicate} is a 
boolean-valued function.) For example, to find the equations 
in a given set that do not depend on a variable @code{z}, use

@c ===beg===
@c subset ({x + y + z, x - y + 4, x + y - 5}, 
@c                                     lambda ([e], freeof (z, e)));
@c ===end===
@example
(%i1) subset (@{x + y + z, x - y + 4, x + y - 5@},
                                    lambda ([e], freeof (z, e)));
(%o1)               @{- y + x + 4, y + x - 5@}
@end example

The section @ref{Functions and Variables for Sets} has a complete list of
the set functions in Maxima.

@opencatbox
@category{Sets}
@closecatbox

@subsection Set Member Iteration

There two ways to to iterate over set members. One way is the use
@code{map}; for example:

@c ===beg===
@c map (f, {a, b, c});
@c ===end===
@example
(%i1) map (f, @{a, b, c@});
(%o1)                  @{f(a), f(b), f(c)@}
@end example

The other way is to use @code{for @var{x} in @var{s} do}

@c ===beg===
@c s: {a, b, c};
@c for si in s do print (concat (si, 1));
@c ===end===
@example
(%i1) s: @{a, b, c@};
(%o1)                       @{a, b, c@}
(%i2) for si in s do print (concat (si, 1));
a1 
b1 
c1 
(%o2)                         done
@end example

The Maxima functions @code{first} and @code{rest} work
correctly on sets. Applied to a set, @code{first} returns the first
displayed element of a set; which element that is may be
implementation-dependent. If @code{s} is a set, then 
@code{rest(s)} is equivalent to @code{disjoin(first(s), s)}.
Currently, there are other Maxima functions that work correctly
on sets.
In future versions of the set functions,
@code{first} and @code{rest} may function differently or not at all.

@c WHAT EXACTLY IS THE EFFECT OF ordergreat AND orderless ON THE SET FUNCTIONS ??
Maxima's @code{orderless} and @code{ordergreat} mechanisms are 
incompatible with the set functions. If you need to use either @code{orderless}
or @code{ordergreat}, call those functions before constructing any sets,
and do not call @code{unorder}. 

@subsection Authors

Stavros Macrakis of Cambridge, Massachusetts and Barton Willis of the
University of Nebraska at Kearney (UNK) wrote the Maxima set functions and their
documentation. 

@node Functions and Variables for Sets,  , Introduction to Sets, Sets
@section Functions and Variables for Sets

@anchor{adjoin}
@deffn {Function} adjoin (@var{x}, @var{a}) 

Returns the union of the set @var{a} with @code{@{@var{x}@}}.

@code{adjoin} complains if @var{a} is not a literal set.

@code{adjoin(@var{x}, @var{a})} and @code{union(set(@var{x}), @var{a})}
are equivalent;
however, @code{adjoin} may be somewhat faster than @code{union}.

See also @mref{disjoin}.

Examples:

@c ===beg===
@c adjoin (c, {a, b});
@c adjoin (a, {a, b});
@c ===end===
@example
(%i1) adjoin (c, @{a, b@});
(%o1)                       @{a, b, c@}
(%i2) adjoin (a, @{a, b@});
(%o2)                        @{a, b@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{belln}
@deffn {Function} belln (@var{n})

Represents the @math{n}-th Bell number.
@code{belln(n)} is the number of partitions of a set with @var{n} members.

For nonnegative integers @var{n},
@code{belln(@var{n})} simplifies to the @math{n}-th Bell number.
@code{belln} does not simplify for any other arguments.

@code{belln} distributes over equations, lists, matrices, and sets.

Examples:

@code{belln} applied to nonnegative integers.

@c ===beg===
@c makelist (belln (i), i, 0, 6);
@c is (cardinality (set_partitions ({})) = belln (0));
@c is (cardinality (set_partitions ({1, 2, 3, 4, 5, 6})) = 
@c                        belln (6));
@c ===end===
@example
(%i1) makelist (belln (i), i, 0, 6);
(%o1)               [1, 1, 2, 5, 15, 52, 203]
(%i2) is (cardinality (set_partitions (@{@})) = belln (0));
(%o2)                         true
(%i3) is (cardinality (set_partitions (@{1, 2, 3, 4, 5, 6@})) =
                       belln (6));
(%o3)                         true
@end example

@code{belln} applied to arguments which are not nonnegative integers.

@c ===beg===
@c [belln (x), belln (sqrt(3)), belln (-9)];
@c ===end===
@example
(%i1) [belln (x), belln (sqrt(3)), belln (-9)];
(%o1)        [belln(x), belln(sqrt(3)), belln(- 9)]
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{cardinality}
@deffn {Function} cardinality (@var{a})

Returns the number of distinct elements of the set @var{a}. 

@code{cardinality} ignores redundant elements
even when simplification is disabled.

Examples:

@c ===beg===
@c cardinality ({});
@c cardinality ({a, a, b, c});
@c simp : false;
@c cardinality ({a, a, b, c});
@c ===end===
@example
(%i1) cardinality (@{@});
(%o1)                           0
(%i2) cardinality (@{a, a, b, c@});
(%o2)                           3
(%i3) simp : false;
(%o3)                         false
(%i4) cardinality (@{a, a, b, c@});
(%o4)                           3
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{cartesian_product}
@deffn {Function} cartesian_product (@var{b_1}, ... , @var{b_n})
Returns a set of lists of the form @code{[@var{x_1}, ..., @var{x_n}]}, where
@var{x_1}, ..., @var{x_n} are elements of the sets @var{b_1}, ... , @var{b_n},
respectively.

@code{cartesian_product} complains if any argument is not a literal set.

Examples:

@c ===beg===
@c cartesian_product ({0, 1});
@c cartesian_product ({0, 1}, {0, 1});
@c cartesian_product ({x}, {y}, {z});
@c cartesian_product ({x}, {-1, 0, 1});
@c ===end===
@example
(%i1) cartesian_product (@{0, 1@});
(%o1)                      @{[0], [1]@}
(%i2) cartesian_product (@{0, 1@}, @{0, 1@});
(%o2)           @{[0, 0], [0, 1], [1, 0], [1, 1]@}
(%i3) cartesian_product (@{x@}, @{y@}, @{z@});
(%o3)                      @{[x, y, z]@}
(%i4) cartesian_product (@{x@}, @{-1, 0, 1@});
(%o4)              @{[x, - 1], [x, 0], [x, 1]@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn


@anchor{disjoin}
@deffn {Function} disjoin (@var{x}, @var{a})
Returns the set @var{a} without the member @var{x}.
If @var{x} is not a member of @var{a}, return @var{a} unchanged.

@code{disjoin} complains if @var{a} is not a literal set.

@code{disjoin(@var{x}, @var{a})}, @code{delete(@var{x}, @var{a})}, and
@code{setdifference(@var{a}, set(@var{x}))} are all equivalent. 
Of these, @code{disjoin} is generally faster than the others.

Examples:

@c ===beg===
@c disjoin (a, {a, b, c, d});
@c disjoin (a + b, {5, z, a + b, %pi});
@c disjoin (a - b, {5, z, a + b, %pi});
@c ===end===
@example
(%i1) disjoin (a, @{a, b, c, d@});
(%o1)                       @{b, c, d@}
(%i2) disjoin (a + b, @{5, z, a + b, %pi@});
(%o2)                      @{5, %pi, z@}
(%i3) disjoin (a - b, @{5, z, a + b, %pi@});
(%o3)                  @{5, %pi, b + a, z@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{disjointp}
@deffn {Function} disjointp (@var{a}, @var{b}) 
Returns @code{true} if and only if the sets @var{a} and @var{b} are disjoint.

@code{disjointp} complains if either @var{a} or @var{b} is not a literal set.

Examples:

@c ===beg===
@c disjointp ({a, b, c}, {1, 2, 3});
@c disjointp ({a, b, 3}, {1, 2, 3});
@c ===end===
@example
(%i1) disjointp (@{a, b, c@}, @{1, 2, 3@});
(%o1)                         true
(%i2) disjointp (@{a, b, 3@}, @{1, 2, 3@});
(%o2)                         false
@end example

@opencatbox
@category{Sets}
@category{Predicate functions}
@closecatbox

@end deffn

@anchor{divisors}
@deffn {Function} divisors (@var{n})

Represents the set of divisors of @var{n}.

@code{divisors(@var{n})} simplifies to a set of integers
when @var{n} is a nonzero integer.
The set of divisors includes the members 1 and @var{n}.
The divisors of a negative integer are the divisors of its absolute value.

@code{divisors} distributes over equations, lists, matrices, and sets.

Examples:

We can verify that 28 is a perfect number:
the sum of its divisors (except for itself) is 28.

@c ===beg===
@c s: divisors(28);
@c lreduce ("+", args(s)) - 28;
@c ===end===
@example
(%i1) s: divisors(28);
(%o1)                 @{1, 2, 4, 7, 14, 28@}
(%i2) lreduce ("+", args(s)) - 28;
(%o2)                          28
@end example

@code{divisors} is a simplifying function.
Substituting 8 for @code{a} in @code{divisors(a)}
yields the divisors without reevaluating @code{divisors(8)}.

@c ===beg===
@c divisors (a);
@c subst (8, a, %);
@c ===end===
@example
(%i1) divisors (a);
(%o1)                      divisors(a)
(%i2) subst (8, a, %);
(%o2)                     @{1, 2, 4, 8@}
@end example

@code{divisors} distributes over equations, lists, matrices, and sets.

@c ===beg===
@c divisors (a = b);
@c divisors ([a, b, c]);
@c divisors (matrix ([a, b], [c, d]));
@c divisors ({a, b, c});
@c ===end===
@example
(%i1) divisors (a = b);
(%o1)               divisors(a) = divisors(b)
(%i2) divisors ([a, b, c]);
(%o2)        [divisors(a), divisors(b), divisors(c)]
(%i3) divisors (matrix ([a, b], [c, d]));
                  [ divisors(a)  divisors(b) ]
(%o3)             [                          ]
                  [ divisors(c)  divisors(d) ]
(%i4) divisors (@{a, b, c@});
(%o4)        @{divisors(a), divisors(b), divisors(c)@}
@end example

@opencatbox
@category{Integers}
@closecatbox

@end deffn

@anchor{elementp}
@deffn {Function} elementp (@var{x}, @var{a})
Returns @code{true} if and only if @var{x} is a member of the 
set @var{a}.

@code{elementp} complains if @var{a} is not a literal set.

Examples:

@c ===beg===
@c elementp (sin(1), {sin(1), sin(2), sin(3)});
@c elementp (sin(1), {cos(1), cos(2), cos(3)});
@c ===end===
@example
(%i1) elementp (sin(1), @{sin(1), sin(2), sin(3)@});
(%o1)                         true
(%i2) elementp (sin(1), @{cos(1), cos(2), cos(3)@});
(%o2)                         false
@end example

@opencatbox
@category{Sets}
@category{Predicate functions}
@closecatbox

@end deffn

@anchor{emptyp}
@deffn {Function} emptyp (@var{a})
Return @code{true} if and only if @var{a} is the empty set or
the empty list.

Examples:

@c ===beg===
@c map (emptyp, [{}, []]);
@c map (emptyp, [a + b, {{}}, %pi]);
@c ===end===
@example
(%i1) map (emptyp, [@{@}, []]);
(%o1)                     [true, true]
(%i2) map (emptyp, [a + b, @{@{@}@}, %pi]);
(%o2)                 [false, false, false]
@end example

@opencatbox
@category{Sets}
@category{Predicate functions}
@closecatbox

@end deffn
       
@anchor{equiv_classes}
@deffn {Function} equiv_classes (@var{s}, @var{F})
Returns a set of the equivalence classes of the set @var{s} with respect
to the equivalence relation @var{F}.

@var{F} is a function of two variables defined on the Cartesian product of @var{s} with @var{s}.
The return value of @var{F} is either @code{true} or @code{false},
or an expression @var{expr} such that @code{is(@var{expr})} is either @code{true} or @code{false}.

When @var{F} is not an equivalence relation,
@code{equiv_classes} accepts it without complaint,
but the result is generally incorrect in that case.

@c EXCESSIVE DETAIL HERE. PROBABLY JUST CUT THIS
@c @var{F} may be a relational operator (built-in or user-defined),
@c an ordinary Maxima function, a Lisp function, a lambda expression,
@c a macro, or a subscripted function.

Examples:

The equivalence relation is a lambda expression which returns @code{true} or @code{false}.

@c ===beg===
@c equiv_classes ({1, 1.0, 2, 2.0, 3, 3.0}, 
@c                         lambda ([x, y], is (equal (x, y))));
@c ===end===
@example
(%i1) equiv_classes (@{1, 1.0, 2, 2.0, 3, 3.0@},
                        lambda ([x, y], is (equal (x, y))));
(%o1)            @{@{1, 1.0@}, @{2, 2.0@}, @{3, 3.0@}@}
@end example

The equivalence relation is the name of a relational function
which @code{is} evaluates to @code{true} or @code{false}.

@c ===beg===
@c equiv_classes ({1, 1.0, 2, 2.0, 3, 3.0}, equal);
@c ===end===
@example
(%i1) equiv_classes (@{1, 1.0, 2, 2.0, 3, 3.0@}, equal);
(%o1)            @{@{1, 1.0@}, @{2, 2.0@}, @{3, 3.0@}@}
@end example

The equivalence classes are numbers which differ by a multiple of 3.

@c ===beg===
@c equiv_classes ({1, 2, 3, 4, 5, 6, 7}, 
@c                      lambda ([x, y], remainder (x - y, 3) = 0));
@c ===end===
@example
(%i1) equiv_classes (@{1, 2, 3, 4, 5, 6, 7@},
                     lambda ([x, y], remainder (x - y, 3) = 0));
(%o1)              @{@{1, 4, 7@}, @{2, 5@}, @{3, 6@}@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{every}
@deffn {Function} every @
@fname{every} (@var{f}, @var{s}) @
@fname{every} (@var{f}, @var{L_1}, ..., @var{L_n})

Returns @code{true} if the predicate @var{f} is @code{true} for all given arguments.

Given one set as the second argument, 
@code{every(@var{f}, @var{s})} returns @code{true}
if @code{is(@var{f}(@var{a_i}))} returns @code{true} for all @var{a_i} in @var{s}.
@code{every} may or may not evaluate @var{f} for all @var{a_i} in @var{s}.
Since sets are unordered,
@code{every} may evaluate @code{@var{f}(@var{a_i})} in any order.

Given one or more lists as arguments,
@code{every(@var{f}, @var{L_1}, ..., @var{L_n})} returns @code{true}
if @code{is(@var{f}(@var{x_1}, ..., @var{x_n}))} returns @code{true} 
for all @var{x_1}, ..., @var{x_n} in @var{L_1}, ..., @var{L_n}, respectively.
@code{every} may or may not evaluate 
@var{f} for every combination @var{x_1}, ..., @var{x_n}.
@code{every} evaluates lists in the order of increasing index.

Given an empty set @code{@{@}} or empty lists @code{[]} as arguments,
@code{every} returns @code{true}.

When the global flag @code{maperror} is @code{true}, all lists 
@var{L_1}, ..., @var{L_n} must have equal lengths.
When @code{maperror} is @code{false}, list arguments are
effectively truncated to the length of the shortest list. 

Return values of the predicate @var{f} which evaluate (via @code{is})
to something other than @code{true} or @code{false}
are governed by the global flag @code{prederror}.
When @code{prederror} is @code{true},
such values are treated as @code{false},
and the return value from @code{every} is @code{false}.
When @code{prederror} is @code{false},
such values are treated as @code{unknown},
and the return value from @code{every} is @code{unknown}.

Examples:

@code{every} applied to a single set.
The predicate is a function of one argument.

@c ===beg===
@c every (integerp, {1, 2, 3, 4, 5, 6});
@c every (atom, {1, 2, sin(3), 4, 5 + y, 6});
@c ===end===
@example
(%i1) every (integerp, @{1, 2, 3, 4, 5, 6@});
(%o1)                         true
(%i2) every (atom, @{1, 2, sin(3), 4, 5 + y, 6@});
(%o2)                         false
@end example

@code{every} applied to two lists.
The predicate is a function of two arguments.

@c ===beg===
@c every ("=", [a, b, c], [a, b, c]);
@c every ("#", [a, b, c], [a, b, c]);
@c ===end===
@example
(%i1) every ("=", [a, b, c], [a, b, c]);
(%o1)                         true
(%i2) every ("#", [a, b, c], [a, b, c]);
(%o2)                         false
@end example

Return values of the predicate @var{f} which evaluate
to something other than @code{true} or @code{false}
are governed by the global flag @code{prederror}.

@c ===beg===
@c prederror : false;
@c map (lambda ([a, b], is (a < b)), [x, y, z], 
@c                    [x^2, y^2, z^2]);
@c every ("<", [x, y, z], [x^2, y^2, z^2]);
@c prederror : true;
@c every ("<", [x, y, z], [x^2, y^2, z^2]);
@c ===end===
@example
(%i1) prederror : false;
(%o1)                         false
(%i2) map (lambda ([a, b], is (a < b)), [x, y, z],
                   [x^2, y^2, z^2]);
(%o2)              [unknown, unknown, unknown]
(%i3) every ("<", [x, y, z], [x^2, y^2, z^2]);
(%o3)                        unknown
(%i4) prederror : true;
(%o4)                         true
(%i5) every ("<", [x, y, z], [x^2, y^2, z^2]);
(%o5)                         false
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn
 
@anchor{extremal_subset}
@deffn {Function} extremal_subset @
@fname{extremal_subset} (@var{s}, @var{f}, max) @
@fname{extremal_subset} (@var{s}, @var{f}, min)

Returns the subset of @var{s} for which the function @var{f} takes on maximum or minimum values.

@code{extremal_subset(@var{s}, @var{f}, max)} returns the subset of the set or 
list @var{s} for which the real-valued function @var{f} takes on its maximum value.

@code{extremal_subset(@var{s}, @var{f}, min)} returns the subset of the set or 
list @var{s} for which the real-valued function @var{f} takes on its minimum value.

Examples:

@c ===beg===
@c extremal_subset ({-2, -1, 0, 1, 2}, abs, max);
@c extremal_subset ({sqrt(2), 1.57, %pi/2}, sin, min);
@c ===end===
@example
(%i1) extremal_subset (@{-2, -1, 0, 1, 2@}, abs, max);
(%o1)                       @{- 2, 2@}
(%i2) extremal_subset (@{sqrt(2), 1.57, %pi/2@}, sin, min);
(%o2)                       @{sqrt(2)@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{flatten}
@deffn {Function} flatten (@var{expr})

Collects arguments of subexpressions which have the same operator as @var{expr}
and constructs an expression from these collected arguments.

Subexpressions in which the operator is different from the main operator of @code{expr}
are copied without modification,
even if they, in turn, contain some subexpressions in which the operator is the same as for @code{expr}.

It may be possible for @code{flatten} to construct expressions in which the number
of arguments differs from the declared arguments for an operator;
this may provoke an error message from the simplifier or evaluator.
@code{flatten} does not try to detect such situations.

Expressions with special representations, for example, canonical rational expressions (CRE), 
cannot be flattened; in such cases, @code{flatten} returns its argument unchanged.

Examples:

Applied to a list, @code{flatten} gathers all list elements that are lists.

@c ===beg===
@c flatten ([a, b, [c, [d, e], f], [[g, h]], i, j]);
@c ===end===
@example
(%i1) flatten ([a, b, [c, [d, e], f], [[g, h]], i, j]);
(%o1)            [a, b, c, d, e, f, g, h, i, j]
@end example

Applied to a set, @code{flatten} gathers all members of set elements that are sets.

@c ===beg===
@c flatten ({a, {b}, {{c}}});
@c flatten ({a, {[a], {a}}});
@c ===end===
@example
(%i1) flatten (@{a, @{b@}, @{@{c@}@}@});
(%o1)                       @{a, b, c@}
(%i2) flatten (@{a, @{[a], @{a@}@}@});
(%o2)                       @{a, [a]@}
@end example

@code{flatten} is similar to the effect of declaring the main operator n-ary.
However, @code{flatten} has no effect on subexpressions which have an operator
different from the main operator, while an n-ary declaration affects those.

@c ===beg===
@c expr: flatten (f (g (f (f (x)))));
@c declare (f, nary);
@c ev (expr);
@c ===end===
@example
(%i1) expr: flatten (f (g (f (f (x)))));
(%o1)                     f(g(f(f(x))))
(%i2) declare (f, nary);
(%o2)                         done
(%i3) ev (expr);
(%o3)                      f(g(f(x)))
@end example

@code{flatten} treats subscripted functions the same as any other operator.

@c ===beg===
@c flatten (f[5] (f[5] (x, y), z));
@c ===end===
@example
(%i1) flatten (f[5] (f[5] (x, y), z));
(%o1)                      f (x, y, z)
                            5
@end example

It may be possible for @code{flatten} to construct expressions in which the number
of arguments differs from the declared arguments for an operator;

@c ===beg===
@c 'mod (5, 'mod (7, 4));
@c flatten (%);
@c ''%, nouns;
@c ===end===
@example
(%i1) 'mod (5, 'mod (7, 4));
(%o1)                   mod(5, mod(7, 4))
(%i2) flatten (%);
(%o2)                     mod(5, 7, 4)
(%i3) ''%, nouns;
Wrong number of arguments to mod
 -- an error.  Quitting.  To debug this try debugmode(true);
@end example

@opencatbox
@category{Sets}
@category{Lists}
@closecatbox

@end deffn

@anchor{full_listify}
@deffn {Function} full_listify (@var{a})
Replaces every set operator in @var{a} by a list operator,
and returns the result.
@code{full_listify} replaces set operators in nested subexpressions,
even if the main operator is not @code{set}.

@code{listify} replaces only the main operator.

Examples:

@c ===beg===
@c full_listify ({a, b, {c, {d, e, f}, g}});
@c full_listify (F (G ({a, b, H({c, d, e})})));
@c ===end===
@example
(%i1) full_listify (@{a, b, @{c, @{d, e, f@}, g@}@});
(%o1)               [a, b, [c, [d, e, f], g]]
(%i2) full_listify (F (G (@{a, b, H(@{c, d, e@})@})));
(%o2)              F(G([a, b, H([c, d, e])]))
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{fullsetify}
@deffn {Function} fullsetify (@var{a})
When @var{a} is a list, replaces the list operator with a set operator,
and applies @code{fullsetify} to each member which is a set.
When @var{a} is not a list, it is returned unchanged.

@code{setify} replaces only the main operator.

Examples:

In line @code{(%o2)}, the argument of @code{f} isn't converted to a set
because the main operator of @code{f([b])} isn't a list.

@c ===beg===
@c fullsetify ([a, [a]]);
@c fullsetify ([a, f([b])]);
@c ===end===
@example
(%i1) fullsetify ([a, [a]]);
(%o1)                       @{a, @{a@}@}
(%i2) fullsetify ([a, f([b])]);
(%o2)                      @{a, f([b])@}
@end example

@opencatbox
@category{Lists}
@closecatbox

@end deffn

@anchor{identity}
@deffn {Function} identity (@var{x})

Returns @var{x} for any argument @var{x}.

Examples:

@code{identity} may be used as a predicate when the arguments
are already Boolean values.

@c ===beg===
@c every (identity, [true, true]);
@c ===end===
@example
(%i1) every (identity, [true, true]);
(%o1)                         true
@end example
@end deffn

@anchor{integer_partitions}
@deffn {Function} integer_partitions @
@fname{integer_partitions} (@var{n}) @
@fname{integer_partitions} (@var{n}, @var{len})

Returns integer partitions of @var{n}, that is,
lists of integers which sum to @var{n}.

@code{integer_partitions(@var{n})} returns the set of
all partitions of the integer @var{n}.
Each partition is a list sorted from greatest to least.

@code{integer_partitions(@var{n}, @var{len})}
returns all partitions that have length @var{len} or less; in this
case, zeros are appended to each partition with fewer than @var{len}
terms to make each partition have exactly @var{len} terms.
Each partition is a list sorted from greatest to least.

A list @math{[a_1, ..., a_m]} is a partition of a nonnegative integer
@math{n} when (1) each @math{a_i} is a nonzero integer, and (2) 
@math{a_1 + ... + a_m = n.} Thus 0 has no partitions.

Examples:

@c ===beg===
@c integer_partitions (3);
@c s: integer_partitions (25)$
@c cardinality (s);
@c map (lambda ([x], apply ("+", x)), s);
@c integer_partitions (5, 3);
@c integer_partitions (5, 2);
@c ===end===
@example
(%i1) integer_partitions (3);
(%o1)               @{[1, 1, 1], [2, 1], [3]@}
(%i2) s: integer_partitions (25)$
(%i3) cardinality (s);
(%o3)                         1958
(%i4) map (lambda ([x], apply ("+", x)), s);
(%o4)                         @{25@}
(%i5) integer_partitions (5, 3);
(%o5) @{[2, 2, 1], [3, 1, 1], [3, 2, 0], [4, 1, 0], [5, 0, 0]@}
(%i6) integer_partitions (5, 2);
(%o6)               @{[3, 2], [4, 1], [5, 0]@}
@end example

To find all partitions that satisfy a condition, use the function @code{subset};
here is an example that finds all partitions of 10 that consist of prime numbers.

@c ===beg===
@c s: integer_partitions (10)$
@c cardinality (s);
@c xprimep(x) := integerp(x) and (x > 1) and primep(x)$
@c subset (s, lambda ([x], every (xprimep, x)));
@c ===end===
@example
(%i1) s: integer_partitions (10)$
(%i2) cardinality (s);
(%o2)                          42
(%i3) xprimep(x) := integerp(x) and (x > 1) and primep(x)$
(%i4) subset (s, lambda ([x], every (xprimep, x)));
(%o4) @{[2, 2, 2, 2, 2], [3, 3, 2, 2], [5, 3, 2], [5, 5], [7, 3]@}
@end example

@opencatbox
@category{Integers}
@closecatbox

@end deffn

@anchor{intersect}
@deffn {Function} intersect (@var{a_1}, ..., @var{a_n})

@code{intersect} is the same as @code{intersection}, which see.

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{intersection}
@deffn {Function} intersection (@var{a_1}, ..., @var{a_n})
Returns a set containing the elements that are common to the 
sets @var{a_1} through @var{a_n}.

@code{intersection} complains if any argument is not a literal set.

Examples:

@c ===beg===
@c S_1 : {a, b, c, d};
@c S_2 : {d, e, f, g};
@c S_3 : {c, d, e, f};
@c S_4 : {u, v, w};
@c intersection (S_1, S_2);
@c intersection (S_2, S_3);
@c intersection (S_1, S_2, S_3);
@c intersection (S_1, S_2, S_3, S_4);
@c ===end===
@example
(%i1) S_1 : @{a, b, c, d@};
(%o1)                     @{a, b, c, d@}
(%i2) S_2 : @{d, e, f, g@};
(%o2)                     @{d, e, f, g@}
(%i3) S_3 : @{c, d, e, f@};
(%o3)                     @{c, d, e, f@}
(%i4) S_4 : @{u, v, w@};
(%o4)                       @{u, v, w@}
(%i5) intersection (S_1, S_2);
(%o5)                          @{d@}
(%i6) intersection (S_2, S_3);
(%o6)                       @{d, e, f@}
(%i7) intersection (S_1, S_2, S_3);
(%o7)                          @{d@}
(%i8) intersection (S_1, S_2, S_3, S_4);
(%o8)                          @{@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@deffn {Function} kron_delta (@var{x1}, @var{x2}, @dots{}, @var{xp})

Represents the Kronecker delta function.

@code{kron_delta} simplifies to 1 when @var{xi} and @var{yj} are equal
for all pairs of arguments, and it simplifies to 0 when @var{xi} and
@var{yj} are not equal for some pair of arguments. Equality is
determined using @code{is(equal(xi,xj))} and inequality by
@code{is(notequal(xi,xj))}. For exactly one argument, @code{kron_delta}
signals an error.

Examples:

@c ===beg===
@c kron_delta(a,a);
@c kron_delta(a,b,a,b);
@c kron_delta(a,a,b,a+1);
@c assume(equal(x,y));
@c kron_delta(x,y);
@c ===end===
@example
(%i1) kron_delta(a,a);
(%o1)                                  1
(%i2) kron_delta(a,b,a,b);
(%o2)                          kron_delta(a, b)
(%i3) kron_delta(a,a,b,a+1);
(%o3)                                  0
(%i4) assume(equal(x,y));
(%o4)                            [equal(x, y)]
(%i5) kron_delta(x,y);
(%o5)                                  1
@end example


@end deffn

@anchor{listify}
@deffn {Function} listify (@var{a})

Returns a list containing the members of @var{a} when @var{a} is a set.
Otherwise, @code{listify} returns @var{a}.

@code{full_listify} replaces all set operators in @var{a} by list operators.

Examples:

@c ===beg===
@c listify ({a, b, c, d});
@c listify (F ({a, b, c, d}));
@c ===end===
@example
(%i1) listify (@{a, b, c, d@});
(%o1)                     [a, b, c, d]
(%i2) listify (F (@{a, b, c, d@}));
(%o2)                    F(@{a, b, c, d@})
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{makeset}
@deffn {Function} makeset (@var{expr}, @var{x}, @var{s})

Returns a set with members generated from the expression @var{expr},
where @var{x} is a list of variables in @var{expr},
and @var{s} is a set or list of lists.
To generate each set member,
@var{expr} is evaluated with the variables @var{x} bound in parallel to a member of @var{s}.

Each member of @var{s} must have the same length as @var{x}.
The list of variables @var{x} must be a list of symbols, without subscripts.
Even if there is only one symbol, @var{x} must be a list of one element,
and each member of @var{s} must be a list of one element.

@c FOLLOWING EQUIVALENT EXPRESSION IS REALLY TOO COMPLICATED, JUST SKIP IT FOR NOW
@c @code{makeset(@var{expr}, @var{x}, @var{s})} returns the same result as
@c @code{setify(map(lambda([L], sublis(map("=", ''@var{x}, L), ''@var{expr})), args(@var{s})))}.

See also @mref{makelist}.

Examples:

@c ===beg===
@c makeset (i/j, [i, j], [[1, a], [2, b], [3, c], [4, d]]);
@c S : {x, y, z}$
@c S3 : cartesian_product (S, S, S);
@c makeset (i + j + k, [i, j, k], S3);
@c makeset (sin(x), [x], {[1], [2], [3]});
@c ===end===
@example
(%i1) makeset (i/j, [i, j], [[1, a], [2, b], [3, c], [4, d]]);
                           1  2  3  4
(%o1)                     @{-, -, -, -@}
                           a  b  c  d
(%i2) S : @{x, y, z@}$
(%i3) S3 : cartesian_product (S, S, S);
(%o3) @{[x, x, x], [x, x, y], [x, x, z], [x, y, x], [x, y, y], 
[x, y, z], [x, z, x], [x, z, y], [x, z, z], [y, x, x], 
[y, x, y], [y, x, z], [y, y, x], [y, y, y], [y, y, z], 
[y, z, x], [y, z, y], [y, z, z], [z, x, x], [z, x, y], 
[z, x, z], [z, y, x], [z, y, y], [z, y, z], [z, z, x], 
[z, z, y], [z, z, z]@}
(%i4) makeset (i + j + k, [i, j, k], S3);
(%o4) @{3 x, 3 y, y + 2 x, 2 y + x, 3 z, z + 2 x, z + y + x, 
                                       z + 2 y, 2 z + x, 2 z + y@}
(%i5) makeset (sin(x), [x], @{[1], [2], [3]@});
(%o5)               @{sin(1), sin(2), sin(3)@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{moebius}
@deffn {Function} moebius (@var{n})

Represents the Moebius function.

When @var{n} is product of @math{k} distinct primes,
@code{moebius(@var{n})} simplifies to @math{(-1)^k};
when @math{@var{n} = 1}, it simplifies to 1;
and it simplifies to 0 for all other positive integers. 

@code{moebius} distributes over equations, lists, matrices, and sets.

Examples:

@c ===beg===
@c moebius (1);
@c moebius (2 * 3 * 5);
@c moebius (11 * 17 * 29 * 31);
@c moebius (2^32);
@c moebius (n);
@c moebius (n = 12);
@c moebius ([11, 11 * 13, 11 * 13 * 15]);
@c moebius (matrix ([11, 12], [13, 14]));
@c moebius ({21, 22, 23, 24});
@c ===end===
@example
(%i1) moebius (1);
(%o1)                           1
(%i2) moebius (2 * 3 * 5);
(%o2)                          - 1
(%i3) moebius (11 * 17 * 29 * 31);
(%o3)                           1
(%i4) moebius (2^32);
(%o4)                           0
(%i5) moebius (n);
(%o5)                      moebius(n)
(%i6) moebius (n = 12);
(%o6)                    moebius(n) = 0
(%i7) moebius ([11, 11 * 13, 11 * 13 * 15]);
(%o7)                      [- 1, 1, 1]
(%i8) moebius (matrix ([11, 12], [13, 14]));
                           [ - 1  0 ]
(%o8)                      [        ]
                           [ - 1  1 ]
(%i9) moebius (@{21, 22, 23, 24@});
(%o9)                      @{- 1, 0, 1@}
@end example

@opencatbox
@category{Integers}
@closecatbox

@end deffn
 
@anchor{multinomial_coeff}
@deffn {Function} multinomial_coeff @
@fname{multinomial_coeff} (@var{a_1}, ..., @var{a_n}) @
@fname{multinomial_coeff} ()

Returns the multinomial coefficient.

When each @var{a_k} is a nonnegative integer, the multinomial coefficient
gives the number of ways of placing @code{@var{a_1} + ... + @var{a_n}} 
distinct objects into @math{n} boxes with @var{a_k} elements in the 
@math{k}'th box. In general, @code{multinomial_coeff (@var{a_1}, ..., @var{a_n})}
evaluates to @code{(@var{a_1} + ... + @var{a_n})!/(@var{a_1}! ... @var{a_n}!)}.

@code{multinomial_coeff()} (with no arguments) evaluates to 1.

@code{minfactorial} may be able to simplify the value returned by @code{multinomial_coeff}.

Examples:

@c ===beg===
@c multinomial_coeff (1, 2, x);
@c minfactorial (%);
@c multinomial_coeff (-6, 2);
@c minfactorial (%);
@c ===end===
@example
(%i1) multinomial_coeff (1, 2, x);
                            (x + 3)!
(%o1)                       --------
                              2 x!
(%i2) minfactorial (%);
                     (x + 1) (x + 2) (x + 3)
(%o2)                -----------------------
                                2
(%i3) multinomial_coeff (-6, 2);
                             (- 4)!
(%o3)                       --------
                            2 (- 6)!
(%i4) minfactorial (%);
(%o4)                          10
@end example

@opencatbox
@category{Integers}
@closecatbox

@end deffn

@anchor{num_distinct_partitions}
@deffn {Function} num_distinct_partitions @
@fname{num_distinct_partitions} (@var{n}) @
@fname{num_distinct_partitions} (@var{n}, list)

Returns the number of distinct integer partitions of @var{n}
when @var{n} is a nonnegative integer.
Otherwise, @code{num_distinct_partitions} returns a noun expression.

@code{num_distinct_partitions(@var{n}, list)} returns a 
list of the number of distinct partitions of 1, 2, 3, ..., @var{n}. 

A distinct partition of @var{n} is
a list of distinct positive integers @math{k_1}, ..., @math{k_m}
such that @math{@var{n} = k_1 + ... + k_m}.

Examples:

@c ===beg===
@c num_distinct_partitions (12);
@c num_distinct_partitions (12, list);
@c num_distinct_partitions (n);
@c ===end===
@example
(%i1) num_distinct_partitions (12);
(%o1)                          15
(%i2) num_distinct_partitions (12, list);
(%o2)      [1, 1, 1, 2, 2, 3, 4, 5, 6, 8, 10, 12, 15]
(%i3) num_distinct_partitions (n);
(%o3)              num_distinct_partitions(n)
@end example

@opencatbox
@category{Integers}
@closecatbox

@end deffn

@anchor{num_partitions}
@deffn {Function} num_partitions @
@fname{num_partitions} (@var{n}) @
@fname{num_partitions} (@var{n}, list)

Returns the number of integer partitions of @var{n}
when @var{n} is a nonnegative integer.
Otherwise, @code{num_partitions} returns a noun expression.

@code{num_partitions(@var{n}, list)} returns a
list of the number of integer partitions of 1, 2, 3, ..., @var{n}.

For a nonnegative integer @var{n}, @code{num_partitions(@var{n})} is equal to
@code{cardinality(integer_partitions(@var{n}))}; however, @code{num_partitions} 
does not actually construct the set of partitions, so it is much faster.

Examples:

@c ===beg===
@c num_partitions (5) = cardinality (integer_partitions (5));
@c num_partitions (8, list);
@c num_partitions (n);
@c ===end===
@example
(%i1) num_partitions (5) = cardinality (integer_partitions (5));
(%o1)                         7 = 7
(%i2) num_partitions (8, list);
(%o2)            [1, 1, 2, 3, 5, 7, 11, 15, 22]
(%i3) num_partitions (n);
(%o3)                   num_partitions(n)
@end example

@opencatbox
@category{Integers}
@closecatbox

@end deffn



@anchor{partition_set}
@deffn {Function} partition_set (@var{a}, @var{f})

Partitions the set @var{a} according to the predicate @var{f}.

@code{partition_set} returns a list of two sets.
The first set comprises the elements of @var{a} for which @var{f} evaluates to @code{false},
and the second comprises any other elements of @var{a}.
@code{partition_set} does not apply @code{is} to the return value of @var{f}.

@code{partition_set} complains if @var{a} is not a literal set.

See also @mref{subset}.

Examples:

@c ===beg===
@c partition_set ({2, 7, 1, 8, 2, 8}, evenp);
@c partition_set ({x, rat(y), rat(y) + z, 1}, 
@c                      lambda ([x], ratp(x)));
@c ===end===
@example
(%i1) partition_set (@{2, 7, 1, 8, 2, 8@}, evenp);
(%o1)                   [@{1, 7@}, @{2, 8@}]
(%i2) partition_set (@{x, rat(y), rat(y) + z, 1@},
                     lambda ([x], ratp(x)));
(%o2)/R/              [@{1, x@}, @{y, y + z@}]
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{permutations}
@deffn {Function} permutations (@var{a})

Returns a set of all distinct permutations of the members of 
the list or set @var{a}. Each permutation is a list, not a set. 

When @var{a} is a list, duplicate members of @var{a} are included
in the permutations.

@code{permutations} complains if @var{a} is not a literal list or set.

See also @mref{random_permutation}.

Examples:

@c ===beg===
@c permutations ([a, a]);
@c permutations ([a, a, b]);
@c ===end===
@example
(%i1) permutations ([a, a]);
(%o1)                       @{[a, a]@}
(%i2) permutations ([a, a, b]);
(%o2)           @{[a, a, b], [a, b, a], [b, a, a]@}
@end example

@opencatbox
@category{Sets}
@category{Lists}
@closecatbox

@end deffn

@anchor{powerset}
@deffn {Function} powerset @
@fname{powerset} (@var{a}) @
@fname{powerset} (@var{a}, @var{n})

Returns the set of all subsets of @var{a}, or a subset of that set.

@code{powerset(@var{a})} returns the set of all subsets of the set @var{a}.
@code{powerset(@var{a})} has @code{2^cardinality(@var{a})} members.

@code{powerset(@var{a}, @var{n})} returns the set of all subsets of @var{a} that have 
cardinality @var{n}.

@code{powerset} complains if @var{a} is not a literal set,
or if @var{n} is not a nonnegative integer.

Examples:

@c ===beg===
@c powerset ({a, b, c});
@c powerset ({w, x, y, z}, 4);
@c powerset ({w, x, y, z}, 3);
@c powerset ({w, x, y, z}, 2);
@c powerset ({w, x, y, z}, 1);
@c powerset ({w, x, y, z}, 0);
@c ===end===
@example
(%i1) powerset (@{a, b, c@});
(%o1) @{@{@}, @{a@}, @{a, b@}, @{a, b, c@}, @{a, c@}, @{b@}, @{b, c@}, @{c@}@}
(%i2) powerset (@{w, x, y, z@}, 4);
(%o2)                    @{@{w, x, y, z@}@}
(%i3) powerset (@{w, x, y, z@}, 3);
(%o3)     @{@{w, x, y@}, @{w, x, z@}, @{w, y, z@}, @{x, y, z@}@}
(%i4) powerset (@{w, x, y, z@}, 2);
(%o4)   @{@{w, x@}, @{w, y@}, @{w, z@}, @{x, y@}, @{x, z@}, @{y, z@}@}
(%i5) powerset (@{w, x, y, z@}, 1);
(%o5)                 @{@{w@}, @{x@}, @{y@}, @{z@}@}
(%i6) powerset (@{w, x, y, z@}, 0);
(%o6)                         @{@{@}@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{random_permutation}
@deffn {Function} random_permutation (@var{a})

Returns a random permutation of the set or list @var{a},
as constructed by the Knuth shuffle algorithm.

The return value is a new list, which is distinct
from the argument even if all elements happen to be the same.
However, the elements of the argument are not copied.

Examples:

@c ===beg===
@c random_permutation ([a, b, c, 1, 2, 3]);
@c random_permutation ([a, b, c, 1, 2, 3]);
@c random_permutation ({x + 1, y + 2, z + 3});
@c random_permutation ({x + 1, y + 2, z + 3});
@c ===end===
@example
(%i1) random_permutation ([a, b, c, 1, 2, 3]);
(%o1)                  [c, 1, 2, 3, a, b]
(%i2) random_permutation ([a, b, c, 1, 2, 3]);
(%o2)                  [b, 3, 1, c, a, 2]
(%i3) random_permutation (@{x + 1, y + 2, z + 3@});
(%o3)                 [y + 2, z + 3, x + 1]
(%i4) random_permutation (@{x + 1, y + 2, z + 3@});
(%o4)                 [x + 1, y + 2, z + 3]
@end example

@opencatbox
@category{Sets}
@category{Lists}
@closecatbox

@end deffn

@anchor{setdifference}
@deffn {Function}  setdifference (@var{a}, @var{b})

Returns a set containing the elements in the set @var{a} that are
not in the set @var{b}.

@code{setdifference} complains if either @var{a} or @var{b} is not a literal set.

Examples:

@c ===beg===
@c S_1 : {a, b, c, x, y, z};
@c S_2 : {aa, bb, c, x, y, zz};
@c setdifference (S_1, S_2);
@c setdifference (S_2, S_1);
@c setdifference (S_1, S_1);
@c setdifference (S_1, {});
@c setdifference ({}, S_1);
@c ===end===
@example
(%i1) S_1 : @{a, b, c, x, y, z@};
(%o1)                  @{a, b, c, x, y, z@}
(%i2) S_2 : @{aa, bb, c, x, y, zz@};
(%o2)                 @{aa, bb, c, x, y, zz@}
(%i3) setdifference (S_1, S_2);
(%o3)                       @{a, b, z@}
(%i4) setdifference (S_2, S_1);
(%o4)                     @{aa, bb, zz@}
(%i5) setdifference (S_1, S_1);
(%o5)                          @{@}
(%i6) setdifference (S_1, @{@});
(%o6)                  @{a, b, c, x, y, z@}
(%i7) setdifference (@{@}, S_1);
(%o7)                          @{@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{setequalp}
@deffn {Function} setequalp (@var{a}, @var{b})

Returns @code{true} if sets @var{a} and @var{b} have the same number of elements
@c $SETEQUALP CALLS THE LISP FUNCTION LIKE,
@c AND SO DOES THE CODE TO EVALUATE IS (X = Y).
and @code{is(@var{x} = @var{y})} is @code{true}
for @code{x} in the elements of @var{a}
and @code{y} in the elements of @var{b},
considered in the order determined by @code{listify}.
Otherwise, @code{setequalp} returns @code{false}.

Examples:

@c ===beg===
@c setequalp ({1, 2, 3}, {1, 2, 3});
@c setequalp ({a, b, c}, {1, 2, 3});
@c setequalp ({x^2 - y^2}, {(x + y) * (x - y)});
@c ===end===
@example
(%i1) setequalp (@{1, 2, 3@}, @{1, 2, 3@});
(%o1)                         true
(%i2) setequalp (@{a, b, c@}, @{1, 2, 3@});
(%o2)                         false
(%i3) setequalp (@{x^2 - y^2@}, @{(x + y) * (x - y)@});
(%o3)                         false
@end example

@opencatbox
@category{Sets}
@category{Predicate functions}
@closecatbox

@end deffn

@anchor{setify}
@deffn {Function} setify (@var{a})

Constructs a set from the elements of the list @var{a}. Duplicate
elements of the list @var{a} are deleted and the elements
are sorted according to the predicate @code{orderlessp}.

@code{setify} complains if @var{a} is not a literal list.

Examples:

@c ===beg===
@c setify ([1, 2, 3, a, b, c]);
@c setify ([a, b, c, a, b, c]);
@c setify ([7, 13, 11, 1, 3, 9, 5]);
@c ===end===
@example
(%i1) setify ([1, 2, 3, a, b, c]);
(%o1)                  @{1, 2, 3, a, b, c@}
(%i2) setify ([a, b, c, a, b, c]);
(%o2)                       @{a, b, c@}
(%i3) setify ([7, 13, 11, 1, 3, 9, 5]);
(%o3)                @{1, 3, 5, 7, 9, 11, 13@}
@end example

@opencatbox
@category{Lists}
@closecatbox

@end deffn

@anchor{setp}
@deffn {Function} setp (@var{a})

Returns @code{true} if and only if @var{a} is a Maxima set.

@code{setp} returns @code{true} for unsimplified sets (that is, sets with redundant members)
as well as simplified sets.

@c NOT SURE WE NEED TO MENTION THIS. OK FOR NOW
@code{setp} is equivalent to the Maxima function
@code{setp(a) := not atom(a) and op(a) = 'set}.

Examples:

@c ===beg===
@c simp : false;
@c {a, a, a};
@c setp (%);
@c ===end===
@example
(%i1) simp : false;
(%o1)                         false
(%i2) @{a, a, a@};
(%o2)                       @{a, a, a@}
(%i3) setp (%);
(%o3)                         true
@end example

@opencatbox
@category{Sets}
@category{Predicate functions}
@closecatbox

@end deffn

@anchor{set_partitions}
@deffn {Function} set_partitions @
@fname{set_partitions} (@var{a}) @
@fname{set_partitions} (@var{a}, @var{n})

Returns the set of all partitions of @var{a}, or a subset of that set.

@code{set_partitions(@var{a}, @var{n})} returns a set of all
decompositions of @var{a} into @var{n} nonempty disjoint subsets.

@code{set_partitions(@var{a})} returns the set of all partitions.

@code{stirling2} returns the cardinality of the set of partitions of a set.

A set of sets @math{P} is a partition of a set @math{S} when

@enumerate
@item
each member of @math{P} is a nonempty set,
@item
distinct members of @math{P} are disjoint,
@item
the union of the members of @math{P} equals @math{S}.
@end enumerate

Examples:

The empty set is a partition of itself, the conditions 1 and 2 being vacuously true.

@c ===beg===
@c set_partitions ({});
@c ===end===
@example
(%i1) set_partitions (@{@});
(%o1)                         @{@{@}@}
@end example

The cardinality of the set of partitions of a set can be found using @code{stirling2}.

@c ===beg===
@c s: {0, 1, 2, 3, 4, 5}$
@c p: set_partitions (s, 3)$ 
@c cardinality(p) = stirling2 (6, 3);
@c ===end===
@example
(%i1) s: @{0, 1, 2, 3, 4, 5@}$
(%i2) p: set_partitions (s, 3)$ 
(%i3) cardinality(p) = stirling2 (6, 3);
(%o3)                        90 = 90
@end example

Each member of @code{p} should have @var{n} = 3 members; let's check.

@c ===beg===
@c s: {0, 1, 2, 3, 4, 5}$
@c p: set_partitions (s, 3)$ 
@c map (cardinality, p);
@c ===end===
@example
(%i1) s: @{0, 1, 2, 3, 4, 5@}$
(%i2) p: set_partitions (s, 3)$ 
(%i3) map (cardinality, p);
(%o3)                          @{3@}
@end example

Finally, for each member of @code{p}, the union of its members should 
equal @code{s}; again let's check.

@c ===beg===
@c s: {0, 1, 2, 3, 4, 5}$
@c p: set_partitions (s, 3)$ 
@c map (lambda ([x], apply (union, listify (x))), p);
@c ===end===
@example
(%i1) s: @{0, 1, 2, 3, 4, 5@}$
(%i2) p: set_partitions (s, 3)$ 
(%i3) map (lambda ([x], apply (union, listify (x))), p);
(%o3)                 @{@{0, 1, 2, 3, 4, 5@}@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{some}
@deffn {Function} some @
@fname{some} (@var{f}, @var{a}) @
@fname{some} (@var{f}, @var{L_1}, ..., @var{L_n})

Returns @code{true} if the predicate @var{f} is @code{true} for one or more given arguments.

Given one set as the second argument, 
@code{some(@var{f}, @var{s})} returns @code{true}
if @code{is(@var{f}(@var{a_i}))} returns @code{true} for one or more @var{a_i} in @var{s}.
@code{some} may or may not evaluate @var{f} for all @var{a_i} in @var{s}.
Since sets are unordered,
@code{some} may evaluate @code{@var{f}(@var{a_i})} in any order.

Given one or more lists as arguments,
@code{some(@var{f}, @var{L_1}, ..., @var{L_n})} returns @code{true}
if @code{is(@var{f}(@var{x_1}, ..., @var{x_n}))} returns @code{true} 
for one or more @var{x_1}, ..., @var{x_n} in @var{L_1}, ..., @var{L_n}, respectively.
@code{some} may or may not evaluate 
@var{f} for some combinations @var{x_1}, ..., @var{x_n}.
@code{some} evaluates lists in the order of increasing index.

Given an empty set @code{@{@}} or empty lists @code{[]} as arguments,
@code{some} returns @code{false}.

When the global flag @code{maperror} is @code{true}, all lists 
@var{L_1}, ..., @var{L_n} must have equal lengths.
When @code{maperror} is @code{false}, list arguments are
effectively truncated to the length of the shortest list. 

Return values of the predicate @var{f} which evaluate (via @code{is})
to something other than @code{true} or @code{false}
are governed by the global flag @code{prederror}.
When @code{prederror} is @code{true},
such values are treated as @code{false}.
When @code{prederror} is @code{false},
such values are treated as @code{unknown}.

Examples:

@code{some} applied to a single set.
The predicate is a function of one argument.

@c ===beg===
@c some (integerp, {1, 2, 3, 4, 5, 6});
@c some (atom, {1, 2, sin(3), 4, 5 + y, 6});
@c ===end===
@example
(%i1) some (integerp, @{1, 2, 3, 4, 5, 6@});
(%o1)                         true
(%i2) some (atom, @{1, 2, sin(3), 4, 5 + y, 6@});
(%o2)                         true
@end example

@code{some} applied to two lists.
The predicate is a function of two arguments.

@c ===beg===
@c some ("=", [a, b, c], [a, b, c]);
@c some ("#", [a, b, c], [a, b, c]);
@c ===end===
@example
(%i1) some ("=", [a, b, c], [a, b, c]);
(%o1)                         true
(%i2) some ("#", [a, b, c], [a, b, c]);
(%o2)                         false
@end example

Return values of the predicate @var{f} which evaluate
to something other than @code{true} or @code{false}
are governed by the global flag @code{prederror}.

@c ===beg===
@c prederror : false;
@c map (lambda ([a, b], is (a < b)), [x, y, z], 
@c            [x^2, y^2, z^2]);
@c some ("<", [x, y, z], [x^2, y^2, z^2]);
@c some ("<", [x, y, z], [x^2, y^2, z + 1]);
@c prederror : true;
@c some ("<", [x, y, z], [x^2, y^2, z^2]);
@c some ("<", [x, y, z], [x^2, y^2, z + 1]);
@c ===end===
@example
(%i1) prederror : false;
(%o1)                         false
(%i2) map (lambda ([a, b], is (a < b)), [x, y, z],
           [x^2, y^2, z^2]);
(%o2)              [unknown, unknown, unknown]
(%i3) some ("<", [x, y, z], [x^2, y^2, z^2]);
(%o3)                        unknown
(%i4) some ("<", [x, y, z], [x^2, y^2, z + 1]);
(%o4)                         true
(%i5) prederror : true;
(%o5)                         true
(%i6) some ("<", [x, y, z], [x^2, y^2, z^2]);
(%o6)                         false
(%i7) some ("<", [x, y, z], [x^2, y^2, z + 1]);
(%o7)                         true
@end example

@opencatbox
@category{Sets}
@category{Lists}
@closecatbox

@end deffn

@anchor{stirling1}
@deffn {Function} stirling1 (@var{n}, @var{m})

Represents the Stirling number of the first kind.

When @var{n} and @var{m} are nonnegative 
integers, the magnitude of @code{stirling1 (@var{n}, @var{m})} is the number of 
permutations of a set with @var{n} members that have @var{m} cycles.

@code{stirling1} is a simplifying function.
Maxima knows the following identities:

@enumerate
@item
@math{stirling1(1,k) = kron_delta(1,k), k >= 0},(see @url{http://dlmf.nist.gov/26.8.E2})
@item
@math{stirling1(n,n) = 1, n >= 0} (see @url{http://dlmf.nist.gov/26.8.E1})
@item
@math{stirling1(n,n-1) = -binomial(n,2), n >= 1}, (see @url{http://dlmf.nist.gov/26.8.E16})
@item
@math{stirling1(n,0) = kron_delta(n,0), n >=0}  (see @url{http://dlmf.nist.gov/26.8.E14} and 
   @url{http://dlmf.nist.gov/26.8.E1})
@item
@math{stirling1(n,1) =(-1)^(n-1) (n-1)!, n >= 1} (see @url{http://dlmf.nist.gov/26.8.E14})
@item
@math{stirling1(n,k) = 0, n >= 0} and @math{k > n}.
@end enumerate

These identities are applied when the arguments are literal integers
or symbols declared as integers, and the first argument is nonnegative.
@code{stirling1} does not simplify for non-integer arguments.


Examples:

@c ===beg===
@c declare (n, integer)$
@c assume (n >= 0)$
@c stirling1 (n, n);
@c ===end===
@example
(%i1) declare (n, integer)$
(%i2) assume (n >= 0)$
(%i3) stirling1 (n, n);
(%o3)                           1
@end example


@opencatbox
@category{Integers}
@closecatbox

@end deffn

@anchor{stirling2}
@deffn {Function} stirling2 (@var{n}, @var{m})

Represents the Stirling number of the second kind.

When @var{n} and @var{m} are nonnegative 
integers, @code{stirling2 (@var{n}, @var{m})} is the number of ways a set with 
cardinality @var{n} can be partitioned into @var{m} disjoint subsets.

@code{stirling2} is a simplifying function.
Maxima knows the following identities.

@enumerate
@item @math{stirling2(n,0) = 1, n >= 1} (see @url{http://dlmf.nist.gov/26.8.E17} and stirling2(0,0) = 1)
@item @math{stirling2(n,n) = 1, n >= 0}, (see @url{http://dlmf.nist.gov/26.8.E4})
@item @math{stirling2(n,1) = 1, n >= 1}, (see @url{http://dlmf.nist.gov/26.8.E17} and stirling2(0,1) = 0)
@item @math{stirling2(n,2) = 2^(n-1) -1, n >= 1}, (see @url{http://dlmf.nist.gov/26.8.E17})
@item @math{stirling2(n,n-1) = binomial(n,2), n>= 1} (see @url{http://dlmf.nist.gov/26.8.E16})
@item @math{stirling2(n,k) = 0, n >= 0} and @math{k > n}.
@end enumerate

These identities are applied when the arguments are literal integers
or symbols declared as integers, and the first argument is nonnegative.
@code{stirling2} does not simplify for non-integer arguments.

Examples:

@c ===beg===
@c declare (n, integer)$
@c assume (n >= 0)$
@c stirling2 (n, n);
@c ===end===
@example
(%i1) declare (n, integer)$
(%i2) assume (n >= 0)$
(%i3) stirling2 (n, n);
(%o3)                           1
@end example

@code{stirling2} does not simplify for non-integer arguments.

@c ===beg===
@c stirling2 (%pi, %pi);
@c ===end===
@example
(%i1) stirling2 (%pi, %pi);
(%o1)                  stirling2(%pi, %pi)
@end example

@opencatbox
@category{Integers}
@closecatbox

@end deffn

@anchor{subset}
@deffn {Function} subset (@var{a}, @var{f})

Returns the subset of the set @var{a} that satisfies the predicate @var{f}. 

@code{subset} returns a set which comprises the elements of @var{a}
for which @var{f} returns anything other than @code{false}.
@code{subset} does not apply @code{is} to the return value of @var{f}.

@code{subset} complains if @var{a} is not a literal set.

See also @mref{partition_set}.

Examples:

@c ===beg===
@c subset ({1, 2, x, x + y, z, x + y + z}, atom);
@c subset ({1, 2, 7, 8, 9, 14}, evenp);
@c ===end===
@example
(%i1) subset (@{1, 2, x, x + y, z, x + y + z@}, atom);
(%o1)                     @{1, 2, x, z@}
(%i2) subset (@{1, 2, 7, 8, 9, 14@}, evenp);
(%o2)                      @{2, 8, 14@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{subsetp}
@deffn {Function} subsetp (@var{a}, @var{b})

Returns @code{true} if and only if the set @var{a} is a subset of @var{b}.

@code{subsetp} complains if either @var{a} or @var{b} is not a literal set.

Examples:

@c ===beg===
@c subsetp ({1, 2, 3}, {a, 1, b, 2, c, 3});
@c subsetp ({a, 1, b, 2, c, 3}, {1, 2, 3});
@c ===end===
@example
(%i1) subsetp (@{1, 2, 3@}, @{a, 1, b, 2, c, 3@});
(%o1)                         true
(%i2) subsetp (@{a, 1, b, 2, c, 3@}, @{1, 2, 3@});
(%o2)                         false
@end example

@opencatbox
@category{Sets}
@category{Predicate functions}
@closecatbox

@end deffn

@anchor{symmdifference}
@deffn {Function} symmdifference (@var{a_1}, @dots{}, @var{a_n})

Returns the symmetric difference of sets @var{a_1}, @dots{}, @var{a_n}.

Given two arguments, @code{symmdifference (@var{a}, @var{b})} is the same as
@code{union (setdifference (@var{a}, @var{b}), setdifference (@var{b},
@var{a}))}.

@code{symmdifference} complains if any argument is not a literal set.

Examples:

@c ===beg===
@c S_1 : {a, b, c};
@c S_2 : {1, b, c};
@c S_3 : {a, b, z};
@c symmdifference ();
@c symmdifference (S_1);
@c symmdifference (S_1, S_2);
@c symmdifference (S_1, S_2, S_3);
@c symmdifference ({}, S_1, S_2, S_3);
@c ===end===
@example
(%i1) S_1 : @{a, b, c@};
(%o1)                       @{a, b, c@}
(%i2) S_2 : @{1, b, c@};
(%o2)                       @{1, b, c@}
(%i3) S_3 : @{a, b, z@};
(%o3)                       @{a, b, z@}
(%i4) symmdifference ();
(%o4)                          @{@}
(%i5) symmdifference (S_1);
(%o5)                       @{a, b, c@}
(%i6) symmdifference (S_1, S_2);
(%o6)                        @{1, a@}
(%i7) symmdifference (S_1, S_2, S_3);
(%o7)                        @{1, b, z@}
(%i8) symmdifference (@{@}, S_1, S_2, S_3);
(%o8)                        @{1,b, z@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

@anchor{union}
@deffn {Function} union (@var{a_1}, ..., @var{a_n})
Returns the union of the sets @var{a_1} through @var{a_n}. 

@code{union()} (with no arguments) returns the empty set.

@code{union} complains if any argument is not a literal set.

Examples:

@c ===beg===
@c S_1 : {a, b, c + d, %e};
@c S_2 : {%pi, %i, %e, c + d};
@c S_3 : {17, 29, 1729, %pi, %i};
@c union ();
@c union (S_1);
@c union (S_1, S_2);
@c union (S_1, S_2, S_3);
@c union ({}, S_1, S_2, S_3);
@c ===end===
@example
(%i1) S_1 : @{a, b, c + d, %e@};
(%o1)                   @{%e, a, b, d + c@}
(%i2) S_2 : @{%pi, %i, %e, c + d@};
(%o2)                 @{%e, %i, %pi, d + c@}
(%i3) S_3 : @{17, 29, 1729, %pi, %i@};
(%o3)                @{17, 29, 1729, %i, %pi@}
(%i4) union ();
(%o4)                          @{@}
(%i5) union (S_1);
(%o5)                   @{%e, a, b, d + c@}
(%i6) union (S_1, S_2);
(%o6)              @{%e, %i, %pi, a, b, d + c@}
(%i7) union (S_1, S_2, S_3);
(%o7)       @{17, 29, 1729, %e, %i, %pi, a, b, d + c@}
(%i8) union (@{@}, S_1, S_2, S_3);
(%o8)       @{17, 29, 1729, %e, %i, %pi, a, b, d + c@}
@end example

@opencatbox
@category{Sets}
@closecatbox

@end deffn

