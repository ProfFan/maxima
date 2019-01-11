@c -*- Mode: texinfo -*-
@menu
* Introduction to Function Definition::  
* Function::                    
* Macros::                      
* Functions and Variables for Function Definition::  
@end menu

@c -----------------------------------------------------------------------------
@node Introduction to Function Definition, Function, Function Definition, Function Definition
@section Introduction to Function Definition
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@node Function, Macros, Introduction to Function Definition, Function Definition
@c NEEDS WORK, THIS TOPIC IS IMPORTANT
@c MENTION DYNAMIC SCOPE (VS LEXICAL SCOPE)
@section Function
@c -----------------------------------------------------------------------------

@opencatbox
@category{Function definition}
@category{Programming}
@closecatbox

@c -----------------------------------------------------------------------------
@subsection Ordinary functions
@c -----------------------------------------------------------------------------

To define a function in Maxima you use the @code{:=} operator.
E.g.

@example
f(x) := sin(x)
@end example

@noindent
defines a function @code{f}.
Anonymous functions may also be created using @code{lambda}.
For example

@example
lambda ([i, j], ...)
@end example

@noindent
can be used instead of @code{f}
where

@example
f(i,j) := block ([], ...);
map (lambda ([i], i+1), l)
@end example

@noindent
would return a list with 1 added to each term.

You may also define a function with a variable number of arguments,
by having a final argument which is assigned to a list of the extra
arguments:

@c ===beg===
@c f ([u]) := u;
@c f (1, 2, 3, 4);
@c f (a, b, [u]) := [a, b, u];
@c f (1, 2, 3, 4, 5, 6);
@c ===end===
@example
(%i1) f ([u]) := u;
(%o1)                      f([u]) := u
(%i2) f (1, 2, 3, 4);
(%o2)                     [1, 2, 3, 4]
(%i3) f (a, b, [u]) := [a, b, u];
(%o3)               f(a, b, [u]) := [a, b, u]
(%i4) f (1, 2, 3, 4, 5, 6);
(%o4)                 [1, 2, [3, 4, 5, 6]]
@end example

The right hand side of a function is an expression.  Thus
if you want a sequence of expressions, you do

@example
f(x) := (expr1, expr2, ...., exprn);
@end example

and the value of @var{exprn} is what is returned by the function.

If you wish to make a @code{return} from some expression inside the
function then you must use @code{block} and @code{return}.

@example
block ([], expr1, ..., if (a > 10) then return(a), ..., exprn)
@end example

is itself an expression, and so could take the place of the
right hand side of a function definition.  Here it may happen
that the return happens earlier than the last expression.

@c COPY THIS STUFF TO @defun block AS NEEDED
@c ESPECIALLY STUFF ABOUT LOCAL VARIABLES
The first @code{[]} in the block, may contain a list of variables and
variable assignments, such as @code{[a: 3, b, c: []]}, which would cause the
three variables @code{a},@code{b},and @code{c} to not refer to their
global values, but rather have these special values for as long as the
code executes inside the @code{block}, or inside functions called from
inside the @code{block}.  This is called @i{dynamic} binding, since the
variables last from the start of the block to the time it exits.  Once
you return from the @code{block}, or throw out of it, the old values (if
any) of the variables will be restored.  It is certainly a good idea
to protect your variables in this way.  Note that the assignments
in the block variables, are done in parallel.  This means, that if
you had used @code{c: a} in the above, the value of @code{c} would
have been the value of @code{a} at the time you just entered the block,
but before @code{a} was bound.  Thus doing something like

@example
block ([a: a], expr1, ... a: a+3, ..., exprn)
@end example

will protect the external value of @code{a} from being altered, but
would let you access what that value was.  Thus the right hand
side of the assignments, is evaluated in the entering context, before
any binding occurs.
Using just @code{block ([x], ...)} would cause the @code{x} to have itself
as value, just as if it would have if you entered a fresh Maxima
session.

The actual arguments to a function are treated in exactly same way as
the variables in a block.  Thus in

@example
f(x) := (expr1, ..., exprn);
@end example

and

@example
f(1);
@end example

we would have a similar context for evaluation of the expressions
as if we had done

@example
block ([x: 1], expr1, ..., exprn)
@end example

Inside functions, when the right hand side of a definition,
may be computed at runtime, it is useful to use @code{define} and
possibly @code{buildq}.

@anchor{memoizing function}
@anchor{memoizing functions}
@anchor{Memoizing function}
@anchor{Memoizing functions}
@c -----------------------------------------------------------------------------
@subsection Memoizing Functions
@c -----------------------------------------------------------------------------

A @i{memoizing function} caches the result the first time it is called with a
given argument, and returns the stored value, without recomputing it, when that
same argument is given.  Memoizing functions are often called
@i{array function} and are in fact handled like arrays in many ways:

The names of memoizing functions are appended to the global list @code{arrays}
(not the global list @code{functions}).  @code{arrayinfo} returns the list of
arguments for which there are stored values, and @code{listarray} returns the
stored values.  @code{dispfun} and @code{fundef} return the array function
definition.

@code{arraymake} constructs an array function call,
analogous to @code{funmake} for ordinary functions.
@code{arrayapply} applies an array function to its arguments,
analogous to @code{apply} for ordinary functions.
There is nothing exactly analogous to @code{map} for array functions,
although @code{map(lambda([@var{x}], @var{a}[@var{x}]), @var{L})} or
@code{makelist(@var{a}[@var{x}], @var{x}, @var{L})}, where @var{L} is a list,
are not too far off the mark.

@code{remarray} removes an array function definition (including any stored
function values), analogous to @code{remfunction} for ordinary functions.

@code{kill(@var{a}[@var{x}])} removes the value of the array function @var{a}
stored for the argument @var{x};
the next time @var{a} is called with argument @var{x},
the function value is recomputed.
However, there is no way to remove all of the stored values at once,
except for @code{kill(@var{a})} or @code{remarray(@var{a})},
which also remove the function definition.


Examples

If evaluating the function needs much time and only a limited number of points
is ever evaluated (which means not much time is spent looking up results in a
long list of cached results) Memoizing functions can speed up calculations
considerably.
@c ===beg===
@c showtime:true$
@c a[x]:=float(sum(sin(x*t),t,1,10000));
@c a[1];
@c a[1];
@c ===end===
@example
@group
(%i1) showtime:true$
Evaluation took 0.0000 seconds (0.0000 elapsed) using 0 bytes.
@end group
@group
(%i2) a[x]:=float(sum(sin(x*t),t,1,10000));
Evaluation took 0.0000 seconds (0.0000 elapsed) using 0 bytes.
(%o2)        a  := float(sum(sin(x t), t, 1, 10000))
              x
@end group
@group
(%i3) a[1];
Evaluation took 5.1250 seconds (5.1260 elapsed) using 775.250 MB.
(%o3)                   1.633891021792447
@end group
@group
(%i4) a[1];
Evaluation took 0.0000 seconds (0.0000 elapsed) using 0 bytes.
(%o4)                   1.633891021792447
@end group
@end example

As the memoizing function is only evaluated once for each input value
changes in variables the memoizing function uses are not considered
for values that are already cached:
@c ===beg===
@c a[x]:=b*x;
@c b:1;
@c a[2];
@c b:2;
@c a[1];
@c a[2];
@c ===end===
@example
@group
(%i1) a[x]:=b*x;
(%o1)                       a  := b x
                             x
@end group
@group
(%i2) b:1;
(%o2)                           1
@end group
@group
(%i3) a[2];
(%o3)                           2
@end group
@group
(%i4) b:2;
(%o4)                           2
@end group
@group
(%i5) a[1];
(%o5)                           2
@end group
@group
(%i6) a[2];
(%o6)                           2
@end group
@end example

@c -----------------------------------------------------------------------------
@node Macros, Functions and Variables for Function Definition, Function, Function Definition
@section Macros
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{buildq}
@deffn {Function} buildq (@var{L}, @var{expr})

Substitutes variables named by the list @var{L} into the expression @var{expr},
in parallel, without evaluating @var{expr}.  The resulting expression is
simplified, but not evaluated, after @code{buildq} carries out the substitution.

The elements of @var{L} are symbols or assignment expressions
@code{@var{symbol}: @var{value}}, evaluated in parallel.  That is, the binding
of a variable on the right-hand side of an assignment is the binding of that
variable in the context from which @code{buildq} was called, not the binding of
that variable in the variable list @var{L}.  If some variable in @var{L} is not
given an explicit assignment, its binding in @code{buildq} is the same as in
the context from which @code{buildq} was called.

Then the variables named by @var{L} are substituted into @var{expr} in parallel.
That is, the substitution for every variable is determined before any
substitution is made, so the substitution for one variable has no effect on any
other.

If any variable @var{x} appears as @code{splice (@var{x})} in @var{expr},
then @var{x} must be bound to a list,
and the list is spliced (interpolated) into @var{expr} instead of substituted.

Any variables in @var{expr} not appearing in @var{L} are carried into the result
verbatim, even if they have bindings in the context from which @code{buildq}
was called.

Examples

@code{a} is explicitly bound to @code{x}, while @code{b} has the same binding
(namely 29) as in the calling context, and @code{c} is carried through verbatim.
The resulting expression is not evaluated until the explicit evaluation
@code{''%}.

@c ===beg===
@c (a: 17, b: 29, c: 1729)$
@c buildq ([a: x, b], a + b + c);
@c ''%;
@c ===end===
@example
(%i1) (a: 17, b: 29, c: 1729)$
@group
(%i2) buildq ([a: x, b], a + b + c);
(%o2)                      x + c + 29
@end group
@group
(%i3) ''%;
(%o3)                       x + 1758
@end group
@end example

@code{e} is bound to a list, which appears as such in the arguments of
@code{foo}, and interpolated into the arguments of @code{bar}.

@c ===beg===
@c buildq ([e: [a, b, c]], foo (x, e, y));
@c buildq ([e: [a, b, c]], bar (x, splice (e), y));
@c ===end===
@example
@group
(%i1) buildq ([e: [a, b, c]], foo (x, e, y));
(%o1)                 foo(x, [a, b, c], y)
@end group
@group
(%i2) buildq ([e: [a, b, c]], bar (x, splice (e), y));
(%o2)                  bar(x, a, b, c, y)
@end group
@end example

The result is simplified after substitution.  If simplification were applied
before substitution, these two results would be the same.

@c ===beg===
@c buildq ([e: [a, b, c]], splice (e) + splice (e));
@c buildq ([e: [a, b, c]], 2 * splice (e));
@c ===end===
@example
@group
(%i1) buildq ([e: [a, b, c]], splice (e) + splice (e));
(%o1)                    2 c + 2 b + 2 a
@end group
@group
(%i2) buildq ([e: [a, b, c]], 2 * splice (e));
(%o2)                        2 a b c
@end group
@end example

The variables in @var{L} are bound in parallel; if bound sequentially,
the first result would be @code{foo (b, b)}.
Substitutions are carried out in parallel;
compare the second result with the result of @code{subst},
which carries out substitutions sequentially.

@c ===beg===
@c buildq ([a: b, b: a], foo (a, b));
@c buildq ([u: v, v: w, w: x, x: y, y: z, z: u], 
@c               bar (u, v, w, x, y, z));
@c subst ([u=v, v=w, w=x, x=y, y=z, z=u], 
@c              bar (u, v, w, x, y, z));
@c ===end===
@example
@group
(%i1) buildq ([a: b, b: a], foo (a, b));
(%o1)                       foo(b, a)
@end group
@group
(%i2) buildq ([u: v, v: w, w: x, x: y, y: z, z: u],
              bar (u, v, w, x, y, z));
(%o2)                 bar(v, w, x, y, z, u)
@end group
@group
(%i3) subst ([u=v, v=w, w=x, x=y, y=z, z=u],
             bar (u, v, w, x, y, z));
(%o3)                 bar(u, u, u, u, u, u)
@end group
@end example

Construct a list of equations with some variables or expressions on the
left-hand side and their values on the right-hand side.  @code{macroexpand}
shows the expression returned by @code{show_values}.

@c ===beg===
@c show_values ([L]) ::= buildq ([L], map ("=", 'L, L));
@c (a: 17, b: 29, c: 1729)$
@c show_values (a, b, c - a - b);
@c macroexpand (show_values (a, b, c - a - b));
@c ===end===
@example
@group
(%i1) show_values ([L]) ::= buildq ([L], map ("=", 'L, L));
(%o1)   show_values([L]) ::= buildq([L], map("=", 'L, L))
@end group
(%i2) (a: 17, b: 29, c: 1729)$
@group
(%i3) show_values (a, b, c - a - b);
(%o3)          [a = 17, b = 29, c - b - a = 1683]
@end group
@group
(%i4) macroexpand (show_values (a, b, c - a - b));
(%o4)    map(=, '([a, b, c - b - a]), [a, b, c - b - a])
@end group
@end example

Given a function of several arguments,
create another function for which some of the arguments are fixed.

@c ===beg===
@c curry (f, [a]) :=
@c         buildq ([f, a], lambda ([[x]], apply (f, append (a, x))))$
@c by3 : curry ("*", 3);
@c by3 (a + b);
@c ===end===
@example
@group
(%i1) curry (f, [a]) :=
        buildq ([f, a], lambda ([[x]], apply (f, append (a, x))))$
@end group
@group
(%i2) by3 : curry ("*", 3);
(%o2)        lambda([[x]], apply(*, append([3], x)))
@end group
@group
(%i3) by3 (a + b);
(%o3)                       3 (b + a)
@end group
@end example

@opencatbox
@category{Function definition}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{macroexpand}
@deffn {Function} macroexpand (@var{expr})

Returns the macro expansion of @var{expr} without evaluating it,
when @code{expr} is a macro function call.
Otherwise, @code{macroexpand} returns @var{expr}.

If the expansion of @var{expr} yields another macro function call,
that macro function call is also expanded.

@code{macroexpand} quotes its argument.
However, if the expansion of a macro function call has side effects,
those side effects are executed.

See also @mrefcomma{::=} @mrefcomma{macros} and @mrefdot{macroexpand1}.

Examples

@c ===beg===
@c g (x) ::= x / 99;
@c h (x) ::= buildq ([x], g (x - a));
@c a: 1234;
@c macroexpand (h (y));
@c h (y);
@c ===end===
@example
@group
(%i1) g (x) ::= x / 99;
                                    x
(%o1)                      g(x) ::= --
                                    99
@end group
@group
(%i2) h (x) ::= buildq ([x], g (x - a));
(%o2)            h(x) ::= buildq([x], g(x - a))
@end group
@group
(%i3) a: 1234;
(%o3)                         1234
@end group
@group
(%i4) macroexpand (h (y));
                              y - a
(%o4)                         -----
                               99
@end group
@group
(%i5) h (y);
                            y - 1234
(%o5)                       --------
                               99
@end group
@end example

@opencatbox
@category{Function application}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{macroexpand1}
@deffn {Function} macroexpand1 (@var{expr})

Returns the macro expansion of @var{expr} without evaluating it,
when @code{expr} is a macro function call.
Otherwise, @code{macroexpand1} returns @var{expr}.

@code{macroexpand1} quotes its argument.
However, if the expansion of a macro function call has side effects,
those side effects are executed.

If the expansion of @var{expr} yields another macro function call,
that macro function call is not expanded.

See also @mrefcomma{::=} @mrefcomma{macros} and @mrefdot{macroexpand}

Examples

@c ===beg===
@c g (x) ::= x / 99;
@c h (x) ::= buildq ([x], g (x - a));
@c a: 1234;
@c macroexpand1 (h (y));
@c h (y);
@c ===end===
@example
@group
(%i1) g (x) ::= x / 99;
                                    x
(%o1)                      g(x) ::= --
                                    99
@end group
@group
(%i2) h (x) ::= buildq ([x], g (x - a));
(%o2)            h(x) ::= buildq([x], g(x - a))
@end group
@group
(%i3) a: 1234;
(%o3)                         1234
@end group
@group
(%i4) macroexpand1 (h (y));
(%o4)                       g(y - a)
@end group
@group
(%i5) h (y);
                            y - 1234
(%o5)                       --------
                               99
@end group
@end example

@opencatbox
@category{Function application}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{macros}
@defvr {Global variable} macros
Default value: @code{[]}

@code{macros} is the list of user-defined macro functions.
The macro function definition operator @code{::=} puts a new macro function
onto this list, and @code{kill}, @code{remove}, and @code{remfunction} remove
macro functions from the list.

See also @mrefdot{infolists}

@opencatbox
@category{Function definition}
@category{Global variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{splice}
@deffn {Function} splice (@var{a})

Splices (interpolates) the list named by the atom @var{a} into an expression,
but only if @code{splice} appears within @code{buildq};
otherwise, @code{splice} is treated as an undefined function.
If appearing within @code{buildq} as @var{a} alone (without @code{splice}),
@var{a} is substituted (not interpolated) as a list into the result.
The argument of @code{splice} can only be an atom;
it cannot be a literal list or an expression which yields a list.

Typically @code{splice} supplies the arguments for a function or operator.
For a function @code{f}, the expression @code{f (splice (@var{a}))} within
@code{buildq} expands to @code{f (@var{a}[1], @var{a}[2], @var{a}[3], ...)}.
For an operator @code{o}, the expression @code{"o" (splice (@var{a}))} within
@code{buildq} expands to @code{"o" (@var{a}[1], @var{a}[2], @var{a}[3], ...)},
where @code{o} may be any type of operator (typically one which takes multiple
arguments).  Note that the operator must be enclosed in double quotes @code{"}.

Examples

@c ===beg===
@c buildq ([x: [1, %pi, z - y]], foo (splice (x)) / length (x));
@c buildq ([x: [1, %pi]], "/" (splice (x)));
@c matchfix ("<>", "<>");
@c buildq ([x: [1, %pi, z - y]], "<>" (splice (x)));
@c ===end===
@example
@group
(%i1) buildq ([x: [1, %pi, z - y]], foo (splice (x)) / length (x));
                       foo(1, %pi, z - y)
(%o1)                -----------------------
                     length([1, %pi, z - y])
@end group
@group
(%i2) buildq ([x: [1, %pi]], "/" (splice (x)));
                                1
(%o2)                          ---
                               %pi
@end group
@group
(%i3) matchfix ("<>", "<>");
(%o3)                          <>
@end group
@group
(%i4) buildq ([x: [1, %pi, z - y]], "<>" (splice (x)));
(%o4)                   <>1, %pi, z - y<>
@end group
@end example

@opencatbox
@category{Function definition}
@closecatbox
@end deffn

@c end concepts Function Definition

@c -----------------------------------------------------------------------------
@node Functions and Variables for Function Definition,  , Macros, Function Definition
@section Functions and Variables for Function Definition
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{apply}
@deffn {Function} apply (@var{F}, [@var{x_1}, @dots{}, @var{x_n}])

Constructs and evaluates an expression @code{@var{F}(@var{arg_1}, ...,
@var{arg_n})}.

@code{apply} does not attempt to distinguish a @mref{memoizing function} from an ordinary 
function; when @var{F} is the name of a memoizing function, @code{apply} evaluates
@code{@var{F}(...)} (that is, a function call with parentheses instead of square
brackets).  @code{arrayapply} evaluates a function call with square brackets in
this case.

See also @mref{funmake} and @mrefdot{args}

Examples:

@code{apply} evaluates its arguments.
In this example, @code{min} is applied to the value of @code{L}.

@c ===beg===
@c L : [1, 5, -10.2, 4, 3];
@c apply (min, L);
@c ===end===
@example
@group
(%i1) L : [1, 5, -10.2, 4, 3];
(%o1)                 [1, 5, - 10.2, 4, 3]
@end group
@group
(%i2) apply (min, L);
(%o2)                        - 10.2
@end group
@end example

@code{apply} evaluates arguments, even if the function @var{F} quotes them.

@c ===beg===
@c F (x) := x / 1729;
@c fname : F;
@c dispfun (F);
@c dispfun (fname);
@c apply (dispfun, [fname]);
@c ===end===
@example
@group
(%i1) F (x) := x / 1729;
                                   x
(%o1)                     F(x) := ----
                                  1729
@end group
@group
(%i2) fname : F;
(%o2)                           F
@end group
@group
(%i3) dispfun (F);
                                   x
(%t3)                     F(x) := ----
                                  1729

(%o3)                         [%t3]
@end group
@group
(%i4) dispfun (fname);
fundef: no such function: fname
 -- an error. To debug this try: debugmode(true);
@end group
@group
(%i5) apply (dispfun, [fname]);
                                   x
(%t5)                     F(x) := ----
                                  1729

(%o5)                         [%t5]
@end group
@end example

@code{apply} evaluates the function name @var{F}.
Single quote @code{'} defeats evaluation.
@code{demoivre} is the name of a global variable and also a function.

@c ===beg===
@c demoivre;
@c demoivre (exp (%i * x));
@c apply (demoivre, [exp (%i * x)]);
@c apply ('demoivre, [exp (%i * x)]);
@c ===end===
@example
@group
(%i1) demoivre;
(%o1)                         false
@end group
@group
(%i2) demoivre (exp (%i * x));
(%o2)                  %i sin(x) + cos(x)
@end group
@group
(%i3) apply (demoivre, [exp (%i * x)]);
apply: found false where a function was expected.
 -- an error. To debug this try: debugmode(true);
@end group
@group
(%i4) apply ('demoivre, [exp (%i * x)]);
(%o4)                  %i sin(x) + cos(x)
@end group
@end example

How to convert a nested list into a matrix:

@c ===beg===
@c a:[[1,2],[3,4]];
@c apply(matrix,a);
@c ===end===
@example
@group
(%i1) a:[[1,2],[3,4]];
(%o1)                   [[1, 2], [3, 4]]
@end group
@group
(%i2) apply(matrix,a);
                            [ 1  2 ]
(%o2)                       [      ]
                            [ 3  4 ]
@end group
@end example


@opencatbox
@category{Function application}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{block}
@deffn  {Function} block @
@fname{block} ([@var{v_1}, @dots{}, @var{v_m}], @var{expr_1}, @dots{}, @var{expr_n}) @
@fname{block} (@var{expr_1}, @dots{}, @var{expr_n})

The function @code{block} allows to make the variables @var{v_1}, @dots{},
@var{v_m} to be local for a sequence of commands. If these variables
are already bound @code{block} saves the current values of the
variables @var{v_1}, @dots{}, @var{v_m} (if any) upon entry to the
block, then unbinds the variables so that they evaluate to themselves;
The local variables may be bound to arbitrary values within the block
but when the block is exited the saved values are restored, and the
values assigned within the block are lost.

If there is no need to define local variables then the list at the
beginning of the @code{block} command may be omitted.
In this case if neither @mref{return} nor @mref{go} are used
@code{block} behaves similar to the following construct:

@example
( expr_1, expr_2,... , expr_n );
@end example

@var{expr_1}, @dots{}, @var{expr_n} will be evaluated in sequence and
the value of the last expression will be returned. The sequence can be 
modified by the @code{go}, @code{throw}, and @code{return} functions.  The last
expression is @var{expr_n} unless @code{return} or an expression containing
@code{throw} is evaluated.

The declaration @code{local(@var{v_1}, ..., @var{v_m})} within @code{block}
saves the properties associated with the symbols @var{v_1}, @dots{}, @var{v_m},
removes any properties before evaluating other expressions, and restores any
saved properties on exit from the block.  Some declarations are implemented as
properties of a symbol, including @code{:=}, @code{array}, @code{dependencies},
@code{atvalue}, @code{matchdeclare}, @code{atomgrad}, @code{constant},
@code{nonscalar}, @code{assume}, and some others.  The effect of @code{local}
is to make such declarations effective only within the block; otherwise
declarations within a block are actually global declarations.

@code{block} may appear within another @code{block}.
Local variables are established each time a new @code{block} is evaluated.
Local variables appear to be global to any enclosed blocks.
If a variable is non-local in a block,
its value is the value most recently assigned by an enclosing block, if any,
otherwise, it is the value of the variable in the global environment.
This policy may coincide with the usual understanding of "dynamic scope".

The value of the block is the value of the last statement or the
value of the argument to the function @code{return} which may be used to exit
explicitly from the block. The function @code{go} may be used to transfer
control to the statement of the block that is tagged with the argument
to @code{go}.  To tag a statement, precede it by an atomic argument as
another statement in the block.  For example:
@code{block ([x], x:1, loop, x: x+1, ..., go(loop), ...)}.  The argument to
@code{go} must be the name of a tag appearing within the block.  One cannot use
@code{go} to transfer to a tag in a block other than the one containing the
@code{go}.

Blocks typically appear on the right side of a function definition
but can be used in other places as well.

See also @mref{return} and @mrefdot{go}

@c Needs some examples.

@opencatbox
@category{Expressions}
@category{Programming}
@closecatbox
@end deffn

@c REPHRASE, NEEDS EXAMPLE

@c -----------------------------------------------------------------------------
@anchor{break}
@deffn {Function} break (@var{expr_1}, @dots{}, @var{expr_n})

Evaluates and prints @var{expr_1}, @dots{}, @var{expr_n} and then
causes a Maxima break at which point the user can examine and change
his environment.  Upon typing @code{exit;} the computation resumes.

@opencatbox
@category{Debugging}
@closecatbox
@end deffn

@c FOR SOME REASON throw IS IN SOME OTHER FILE. MOVE throw INTO THIS FILE.
@c NEEDS CLARIFICATION

@c -----------------------------------------------------------------------------
@anchor{catch}
@deffn {Function} catch (@var{expr_1}, @dots{}, @var{expr_n})

Evaluates @var{expr_1}, @dots{}, @var{expr_n} one by one; if any
leads to the evaluation of an expression of the
form @code{throw (arg)}, then the value of the @code{catch} is the value of
@code{throw (arg)}, and no further expressions are evaluated.
This "non-local return" thus goes through any depth of
nesting to the nearest enclosing @code{catch}.  If there is no @code{catch}
enclosing a @code{throw}, an error message is printed.

If the evaluation of the arguments does not lead to the evaluation of any
@code{throw} then the value of @code{catch} is the value of @var{expr_n}.

@c ===beg===
@c lambda ([x], if x < 0 then throw(x) else f(x))$
@c g(l) := catch (map (''%, l))$
@c g ([1, 2, 3, 7]);
@c g ([1, 2, -3, 7]);
@c ===end===
@example
(%i1) lambda ([x], if x < 0 then throw(x) else f(x))$
(%i2) g(l) := catch (map (''%, l))$
(%i3) g ([1, 2, 3, 7]);
(%o3)               [f(1), f(2), f(3), f(7)]
(%i4) g ([1, 2, -3, 7]);
(%o4)                          - 3
@end example

@c REWORD THIS PART.
The function @code{g} returns a list of @code{f} of each element of @code{l} if
@code{l} consists only of non-negative numbers; otherwise, @code{g} "catches"
the first negative element of @code{l} and "throws" it up.

@opencatbox
@category{Programming}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{compfile}
@deffn  {Function} compfile @
@fname{compfile} (@var{filename}, @var{f_1}, @dots{}, @var{f_n}) @
@fname{compfile} (@var{filename}, functions) @
@fname{compfile} (@var{filename}, all)

Translates Maxima functions into Lisp and writes the translated code into the
file @var{filename}.

@code{compfile(@var{filename}, @var{f_1}, ..., @var{f_n})} translates the
specified functions.  @code{compfile (@var{filename}, functions)} and
@code{compfile (@var{filename}, all)} translate all user-defined functions.

The Lisp translations are not evaluated, nor is the output file processed by
the Lisp compiler.
@c SO LET'S CONSIDER GIVING THIS FUNCTION A MORE ACCURATE NAME.
@code{translate} creates and evaluates Lisp translations.  @code{compile_file}
translates Maxima into Lisp, and then executes the Lisp compiler.

See also @mrefcomma{translate} @mrefcomma{translate_file} and @mrefdot{compile_file}

@opencatbox
@category{Translation and compilation}
@closecatbox
@end deffn

@c THIS VARIABLE IS OBSOLETE: ASSIGNING compgrind: true CAUSES compfile
@c TO EVENTUALLY CALL AN OBSOLETE FUNCTION SPRIN1.
@c RECOMMENDATION IS TO CUT THIS ITEM, AND CUT $compgrind FROM src/transs.lisp
@c @defvar compgrind
@c Default value: @code{false}
@c 
@c When @code{compgrind} is @code{true}, function definitions printed by
@c @code{compfile} are pretty-printed.
@c 
@c @end defvar

@c -----------------------------------------------------------------------------
@anchor{compile}
@deffn  {Function} compile @
@fname{compile} (@var{f_1}, @dots{}, @var{f_n}) @
@fname{compile} (functions) @
@fname{compile} (all)

Translates Maxima functions @var{f_1}, @dots{}, @var{f_n} into Lisp, evaluates
the Lisp translations, and calls the Lisp function @code{COMPILE} on each
translated function.  @code{compile} returns a list of the names of the
compiled functions.

@code{compile (all)} or @code{compile (functions)} compiles all user-defined
functions.

@code{compile} quotes its arguments; 
the quote-quote operator @code{'@w{}'} defeats quotation.

Compiling a function to native code can mean a big increase in speed and might 
cause the memory footprint to reduce drastically.
Code tends to be especially effective when the flexibility it needs to provide
is limited. If compilation doesn't provide the speed that is needed a few ways
to limit the code's functionality are the following:
@itemize @bullet
@item If the function accesses global variables the complexity of the function
      can be drastically be reduced by limiting these variables to one data type,
      for example using @mref{mode_declare} or a statement like the following one:
      @code{put(x_1, bigfloat, numerical_type)}
@item The compiler might warn about undeclared variables if text could either be
      a named option to a command or (if they are assigned a value to) the name
      of a variable. Prepending the option with a single quote @code{'}
      tells the compiler that the text is meant as an option.
@end itemize

@opencatbox
@category{Translation and compilation}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{define}
@deffn  {Function} define @
@fname{define} (@var{f}(@var{x_1}, @dots{}, @var{x_n}), @var{expr}) @
@fname{define} (@var{f}[@var{x_1}, @dots{}, @var{x_n}], @var{expr}) @
@fname{define} (@var{f}[@var{x_1}, @dots{}, @var{x_n}](@var{y_1}, @dots{}, @var{y_m}), @var{expr}) @
@fname{define} (funmake (@var{f}, [@var{x_1}, @dots{}, @var{x_n}]), @var{expr}) @
@fname{define} (arraymake (@var{f}, [@var{x_1}, @dots{}, @var{x_n}]), @var{expr}) @
@fname{define} (ev (@var{expr_1}), @var{expr_2})

Defines a function named @var{f} with arguments @var{x_1}, @dots{}, @var{x_n}
and function body @var{expr}.  @code{define} always evaluates its second
argument (unless explicitly quoted).  The function so defined may be an ordinary
Maxima function (with arguments enclosed in parentheses) or a @mref{memoizing function}
(with arguments enclosed in square brackets).

When the last or only function argument @var{x_n} is a list of one element,
the function defined by @code{define} accepts a variable number of arguments.
Actual arguments are assigned one-to-one to formal arguments @var{x_1}, @dots{},
@var{x_(n - 1)}, and any further actual arguments, if present, are assigned to
@var{x_n} as a list.

When the first argument of @code{define} is an expression of the form
@code{@var{f}(@var{x_1}, ..., @var{x_n})} or @code{@var{f}[@var{x_1}, ...,
@var{x_n}]}, the function arguments are evaluated but @var{f} is not evaluated,
even if there is already a function or variable by that name.

When the first argument is an expression with operator @code{funmake},
@code{arraymake}, or @code{ev}, the first argument is evaluated;
this allows for the function name to be computed, as well as the body.

All function definitions appear in the same namespace; defining a function
@code{f} within another function @code{g} does not automatically limit the scope
of @code{f} to @code{g}.  However, @code{local(f)} makes the definition of
function @code{f} effective only within the block or other compound expression
in which @code{local} appears.

If some formal argument @var{x_k} is a quoted symbol (after evaluation), the
function defined by @code{define} does not evaluate the corresponding actual
argument.  Otherwise all actual arguments are evaluated.

See also @mref{:=} and @mrefdot{::=}

Examples:

@code{define} always evaluates its second argument (unless explicitly quoted).

@c ===beg===
@c expr : cos(y) - sin(x);
@c define (F1 (x, y), expr);
@c F1 (a, b);
@c F2 (x, y) := expr;
@c F2 (a, b);
@c ===end===
@example
@group
(%i1) expr : cos(y) - sin(x);
(%o1)                    cos(y) - sin(x)
@end group
@group
(%i2) define (F1 (x, y), expr);
(%o2)              F1(x, y) := cos(y) - sin(x)
@end group
@group
(%i3) F1 (a, b);
(%o3)                    cos(b) - sin(a)
@end group
@group
(%i4) F2 (x, y) := expr;
(%o4)                   F2(x, y) := expr
@end group
@group
(%i5) F2 (a, b);
(%o5)                    cos(y) - sin(x)
@end group
@end example

The function defined by @code{define} may be an ordinary Maxima function or a
@mref{memoizing function}.

@c ===beg===
@c define (G1 (x, y), x.y - y.x);
@c define (G2 [x, y], x.y - y.x);
@c ===end===
@example
@group
(%i1) define (G1 (x, y), x.y - y.x);
(%o1)               G1(x, y) := x . y - y . x
@end group
@group
(%i2) define (G2 [x, y], x.y - y.x);
(%o2)                G2     := x . y - y . x
                       x, y
@end group
@end example

When the last or only function argument @var{x_n} is a list of one element,
the function defined by @code{define} accepts a variable number of arguments.

@c ===beg===
@c define (H ([L]), '(apply ("+", L)));
@c H (a, b, c);
@c ===end===
@example
@group
(%i1) define (H ([L]), '(apply ("+", L)));
(%o1)                H([L]) := apply("+", L)
@end group
@group
(%i2) H (a, b, c);
(%o2)                       c + b + a
@end group
@end example

When the first argument is an expression with operator @code{funmake},
@code{arraymake}, or @code{ev}, the first argument is evaluated.

@c ===beg===
@c [F : I, u : x];
@c funmake (F, [u]);
@c define (funmake (F, [u]), cos(u) + 1);
@c define (arraymake (F, [u]), cos(u) + 1);
@c define (foo (x, y), bar (y, x));
@c define (ev (foo (x, y)), sin(x) - cos(y));
@c ===end===
@example
@group
(%i1) [F : I, u : x];
(%o1)                        [I, x]
@end group
@group
(%i2) funmake (F, [u]);
(%o2)                         I(x)
@end group
@group
(%i3) define (funmake (F, [u]), cos(u) + 1);
(%o3)                  I(x) := cos(x) + 1
@end group
@group
(%i4) define (arraymake (F, [u]), cos(u) + 1);
(%o4)                   I  := cos(x) + 1
                         x
@end group
@group
(%i5) define (foo (x, y), bar (y, x));
(%o5)                foo(x, y) := bar(y, x)
@end group
@group
(%i6) define (ev (foo (x, y)), sin(x) - cos(y));
(%o6)             bar(y, x) := sin(x) - cos(y)
@end group
@end example

@opencatbox
@category{Function definition}
@closecatbox
@end deffn

@c SEE NOTE BELOW ABOUT THE DOCUMENTATION STRING
@c @deffn {Function} define_variable (@var{name}, @var{default_value}, @var{mode}, @var{documentation})

@c -----------------------------------------------------------------------------
@anchor{define_variable}
@deffn {Function} define_variable (@var{name}, @var{default_value}, @var{mode})

Introduces a global variable into the Maxima environment.
@code{define_variable} is useful in user-written packages, which are often
translated or compiled as it gives the compiler hints of the type (``mode'')
of a variable and therefore avoids requiring it to generate generic code that
can deal with every variable being an integer, float, maxima object, array etc.

@code{define_variable} carries out the following steps:

@enumerate
@item
@code{mode_declare (@var{name}, @var{mode})} declares the mode (``type'') of
@var{name} to the translator which can considerably speed up compiled code as
it allows having to create generic code. See @mref{mode_declare} for a list of
the possible modes.

@item
If the variable is unbound, @var{default_value} is assigned to @var{name}.

@item
Associates @var{name} with a test function
to ensure that @var{name} is only assigned values of the declared mode.
@end enumerate


@c FOLLOWING STATEMENT APPEARS TO BE OUT OF DATE.
@c EXAMINING DEFMSPEC $DEFINE_VARIABLE AND DEF%TR $DEFINE_VARIABLE IN src/trmode.lisp,
@c IT APPEARS THAT THE 4TH ARGUMENT IS NEVER REFERRED TO.
@c EXECUTING translate_file ON A MAXIMA BATCH FILE WHICH CONTAINS
@c define_variable (foo, 2222, integer, "THIS IS FOO");
@c DOES NOT PUT "THIS IS FOO" INTO THE LISP FILE NOR THE UNLISP FILE.
@c The optional 4th argument is a documentation string.  When
@c @code{translate_file} is used on a package which includes documentation
@c strings, a second file is output in addition to the Lisp file which
@c will contain the documentation strings, formatted suitably for use in
@c manuals, usage files, or (for instance) @code{describe}.

The @code{value_check} property can be assigned to any variable which has been
defined via @code{define_variable} with a mode other than @code{any}.
The @code{value_check} property is a lambda expression or the name of a function
of one variable, which is called when an attempt is made to assign a value to
the variable.  The argument of the @code{value_check} function is the would-be
assigned value.

@code{define_variable} evaluates @code{default_value}, and quotes @code{name}
and @code{mode}.  @code{define_variable} returns the current value of
@code{name}, which is @code{default_value} if @code{name} was unbound before,
and otherwise it is the previous value of @code{name}.

Examples:

@code{foo} is a Boolean variable, with the initial value @code{true}.

@c ===beg===
@c define_variable (foo, true, boolean);
@c foo;
@c foo: false;
@c foo: %pi;
@c foo;
@c ===end===
@example
@group
(%i1) define_variable (foo, true, boolean);
(%o1)                         true
@end group
@group
(%i2) foo;
(%o2)                         true
@end group
@group
(%i3) foo: false;
(%o3)                         false
@end group
@group
(%i4) foo: %pi;
translator: foo was declared with mode boolean
                                          , but it has value: %pi
 -- an error. To debug this try: debugmode(true);
@end group
@group
(%i5) foo;
(%o5)                         false
@end group
@end example

@code{bar} is an integer variable, which must be prime.

@c ===beg===
@c define_variable (bar, 2, integer);
@c qput (bar, prime_test, value_check);
@c prime_test (y) := if not primep(y) then 
@c                            error (y, "is not prime.");
@c bar: 1439;
@c bar: 1440;
@c bar;
@c ===end===
@example
@group
(%i1) define_variable (bar, 2, integer);
(%o1)                           2
@end group
@group
(%i2) qput (bar, prime_test, value_check);
(%o2)                      prime_test
@end group
@group
(%i3) prime_test (y) := if not primep(y) then
                           error (y, "is not prime.");
(%o3) prime_test(y) := if not primep(y)
                                   then error(y, "is not prime.")
@end group
@group
(%i4) bar: 1439;
(%o4)                         1439
@end group
@group
(%i5) bar: 1440;
1440 is not prime.
#0: prime_test(y=1440)
 -- an error. To debug this try: debugmode(true);
@end group
@group
(%i6) bar;
(%o6)                         1439
@end group
@end example

@code{baz_quux} is a variable which cannot be assigned a value.
The mode @code{any_check} is like @code{any}, but @code{any_check} enables the
@code{value_check} mechanism, and @code{any} does not.

@c ===beg===
@c define_variable (baz_quux, 'baz_quux, any_check);
@c F: lambda ([y], if y # 'baz_quux then 
@c                  error ("Cannot assign to `baz_quux'."));
@c qput (baz_quux, ''F, value_check);
@c baz_quux: 'baz_quux;
@c baz_quux: sqrt(2);
@c baz_quux;
@c ===end===
@example
@group
(%i1) define_variable (baz_quux, 'baz_quux, any_check);
(%o1)                       baz_quux
@end group
@group
(%i2) F: lambda ([y], if y # 'baz_quux then
                 error ("Cannot assign to `baz_quux'."));
(%o2) lambda([y], if y # 'baz_quux
                        then error(Cannot assign to `baz_quux'.))
@end group
@group
(%i3) qput (baz_quux, ''F, value_check);
(%o3) lambda([y], if y # 'baz_quux
                        then error(Cannot assign to `baz_quux'.))
@end group
@group
(%i4) baz_quux: 'baz_quux;
(%o4)                       baz_quux
@end group
@group
(%i5) baz_quux: sqrt(2);
Cannot assign to `baz_quux'.
#0: lambda([y],if y # 'baz_quux then error("Cannot assign to `baz_quux'."))(y=sqrt(2))
 -- an error. To debug this try: debugmode(true);
@end group
@group
(%i6) baz_quux;
(%o6)                       baz_quux
@end group
@end example

@opencatbox
@category{Translation and compilation}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{dispfun}
@deffn  {Function} dispfun @
@fname{dispfun} (@var{f_1}, @dots{}, @var{f_n}) @
@fname{dispfun} (all)

Displays the definition of the user-defined functions @var{f_1}, @dots{},
@var{f_n}.  Each argument may be the name of a macro (defined with @code{::=}),
an ordinary function (defined with @code{:=} or @code{define}), an array
function (defined with @code{:=} or @code{define}, but enclosing arguments in
square brackets @code{[ ]}), a subscripted function (defined with @code{:=} or
@code{define}, but enclosing some arguments in square brackets and others in
parentheses @code{( )}), one of a family of subscripted functions selected by a
particular subscript value, or a subscripted function defined with a constant
subscript.

@code{dispfun (all)} displays all user-defined functions as
given by the @code{functions}, @code{arrays}, and @code{macros} lists,
omitting subscripted functions defined with constant subscripts.

@code{dispfun} creates an intermediate expression label
(@code{%t1}, @code{%t2}, etc.)
for each displayed function, and assigns the function definition to the label.
In contrast, @code{fundef} returns the function definition.

@code{dispfun} quotes its arguments; the quote-quote operator @code{'@w{}'}
defeats quotation.  @code{dispfun} returns the list of intermediate expression
labels corresponding to the displayed functions.

Examples:

@c ===beg===
@c m(x, y) ::= x^(-y);
@c f(x, y) :=  x^(-y);
@c g[x, y] :=  x^(-y);
@c h[x](y) :=  x^(-y);
@c i[8](y) :=  8^(-y);
@c dispfun (m, f, g, h, h[5], h[10], i[8]);
@c ''%;
@c ===end===
@example
@group
(%i1) m(x, y) ::= x^(-y);
                                     - y
(%o1)                   m(x, y) ::= x
@end group
@group
(%i2) f(x, y) :=  x^(-y);
                                     - y
(%o2)                    f(x, y) := x
@end group
@group
(%i3) g[x, y] :=  x^(-y);
                                    - y
(%o3)                     g     := x
                           x, y
@end group
@group
(%i4) h[x](y) :=  x^(-y);
                                    - y
(%o4)                     h (y) := x
                           x
@end group
@group
(%i5) i[8](y) :=  8^(-y);
                                    - y
(%o5)                     i (y) := 8
                           8
@end group
@group
(%i6) dispfun (m, f, g, h, h[5], h[10], i[8]);
                                     - y
(%t6)                   m(x, y) ::= x

                                     - y
(%t7)                    f(x, y) := x

                                    - y
(%t8)                     g     := x
                           x, y

                                    - y
(%t9)                     h (y) := x
                           x

                                    1
(%t10)                     h (y) := --
                            5        y
                                    5

                                     1
(%t11)                    h  (y) := ---
                           10         y
                                    10

                                    - y
(%t12)                    i (y) := 8
                           8

(%o12)       [%t6, %t7, %t8, %t9, %t10, %t11, %t12]
@end group
@group
(%i13) ''%;
                     - y              - y            - y
(%o13) [m(x, y) ::= x   , f(x, y) := x   , g     := x   , 
                                            x, y
                  - y           1              1             - y
        h (y) := x   , h (y) := --, h  (y) := ---, i (y) := 8   ]
         x              5        y   10         y   8
                                5             10
@end group
@end example

@opencatbox
@category{Function definition}
@category{Display functions}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{fullmap}
@deffn {Function} fullmap (@var{f}, @var{expr_1}, @dots{})

Similar to @code{map}, but @code{fullmap} keeps mapping down all subexpressions
until the main operators are no longer the same.

@code{fullmap} is used by the Maxima simplifier for certain matrix
manipulations; thus, Maxima sometimes generates an error message concerning
@code{fullmap} even though @code{fullmap} was not explicitly called by the user.

Examples:

@c ===beg===
@c a + b * c;
@c fullmap (g, %);
@c map (g, %th(2));
@c ===end===
@example
@group
(%i1) a + b * c;
(%o1)                        b c + a
@end group
@group
(%i2) fullmap (g, %);
(%o2)                   g(b) g(c) + g(a)
@end group
@group
(%i3) map (g, %th(2));
(%o3)                     g(b c) + g(a)
@end group
@end example

@opencatbox
@category{Function application}
@category{Expressions}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{fullmapl}
@deffn {Function} fullmapl (@var{f}, @var{list_1}, @dots{})

Similar to @code{fullmap}, but @code{fullmapl} only maps onto lists and
matrices.

Example:

@c ===beg===
@c fullmapl ("+", [3, [4, 5]], [[a, 1], [0, -1.5]]);
@c ===end===
@example
@group
(%i1) fullmapl ("+", [3, [4, 5]], [[a, 1], [0, -1.5]]);
(%o1)                [[a + 3, 4], [4, 3.5]]
@end group
@end example

@opencatbox
@category{Function application}
@category{Expressions}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{functions}
@defvr {System variable} functions
Default value: @code{[]}

@code{functions} is the list of ordinary Maxima functions
in the current session.
An ordinary function is a function constructed by
@code{define} or @code{:=} and called with parentheses @code{()}.
A function may be defined at the Maxima prompt
or in a Maxima file loaded by @code{load} or @code{batch}.

@mref{Memoizing functions} (called with square brackets, e.g., @code{F[x]}) and subscripted
functions (called with square brackets and parentheses, e.g., @code{F[x](y)})
are listed by the global variable @code{arrays}, and not by @code{functions}.

Lisp functions are not kept on any list.

Examples:

@c ===beg===
@c F_1 (x) := x - 100;
@c F_2 (x, y) := x / y;
@c define (F_3 (x), sqrt (x));
@c G_1 [x] := x - 100;
@c G_2 [x, y] := x / y;
@c define (G_3 [x], sqrt (x));
@c H_1 [x] (y) := x^y;
@c functions;
@c arrays;
@c ===end===
@example
@group
(%i1) F_1 (x) := x - 100;
(%o1)                   F_1(x) := x - 100
@end group
@group
(%i2) F_2 (x, y) := x / y;
                                      x
(%o2)                    F_2(x, y) := -
                                      y
@end group
@group
(%i3) define (F_3 (x), sqrt (x));
(%o3)                   F_3(x) := sqrt(x)
@end group
@group
(%i4) G_1 [x] := x - 100;
(%o4)                    G_1  := x - 100
                            x
@end group
@group
(%i5) G_2 [x, y] := x / y;
                                     x
(%o5)                     G_2     := -
                             x, y    y
@end group
@group
(%i6) define (G_3 [x], sqrt (x));
(%o6)                    G_3  := sqrt(x)
                            x
@end group
@group
(%i7) H_1 [x] (y) := x^y;
                                      y
(%o7)                     H_1 (y) := x
                             x
@end group
@group
(%i8) functions;
(%o8)              [F_1(x), F_2(x, y), F_3(x)]
@end group
@group
(%i9) arrays;
(%o9)                 [G_1, G_2, G_3, H_1]
@end group
@end example

@opencatbox
@category{Function definition}
@category{Global variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{fundef}
@deffn {Function} fundef (@var{f})

Returns the definition of the function @var{f}.

The argument may be
@itemize @bullet
@item the name of a macro (defined with @code{::=}),
@item an ordinary function (defined with @code{:=} or @code{define}),
@item a @mref{memoizing function} (defined with @code{:=} or @code{define}, but enclosing arguments in square brackets @code{[ ]}),
@item a subscripted function (defined with @code{:=} or @code{define},
but enclosing some arguments in square brackets and others in parentheses
@code{( )}),
@item one of a family of subscripted functions selected by a particular
subscript value,
@item or a subscripted function defined with a constant subscript.
@end itemize

@code{fundef} quotes its argument;
the quote-quote operator @code{'@w{}'} defeats quotation.

@code{fundef (@var{f})} returns the definition of @var{f}.
In contrast, @code{dispfun (@var{f})} creates an intermediate expression label
and assigns the definition to the label.

@c PROBABLY NEED SOME EXAMPLES HERE
@opencatbox
@category{Function definition}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{funmake}
@deffn {Function} funmake (@var{F}, [@var{arg_1}, @dots{}, @var{arg_n}])

Returns an expression @code{@var{F}(@var{arg_1}, ..., @var{arg_n})}.
The return value is simplified, but not evaluated,
so the function @var{F} is not called, even if it exists.

@code{funmake} does not attempt to distinguish @mref{memoizing functions} from ordinary 
functions; when @var{F} is the name of a memoizing function,
@code{funmake} returns @code{@var{F}(...)}
(that is, a function call with parentheses instead of square brackets).
@code{arraymake} returns a function call with square brackets in this case.

@code{funmake} evaluates its arguments.

See also @mref{apply} and @mrefdot{args}

Examples:

@code{funmake} applied to an ordinary Maxima function.

@c ===beg===
@c F (x, y) := y^2 - x^2;
@c funmake (F, [a + 1, b + 1]);
@c ''%;
@c ===end===
@example
@group
(%i1) F (x, y) := y^2 - x^2;
                                   2    2
(%o1)                  F(x, y) := y  - x
@end group
@group
(%i2) funmake (F, [a + 1, b + 1]);
(%o2)                    F(a + 1, b + 1)
@end group
@group
(%i3) ''%;
                              2          2
(%o3)                  (b + 1)  - (a + 1)
@end group
@end example

@code{funmake} applied to a macro.

@c ===beg===
@c G (x) ::= (x - 1)/2;
@c funmake (G, [u]);
@c ''%;
@c ===end===
@example
@group
(%i1) G (x) ::= (x - 1)/2;
                                  x - 1
(%o1)                    G(x) ::= -----
                                    2
@end group
@group
(%i2) funmake (G, [u]);
(%o2)                         G(u)
@end group
@group
(%i3) ''%;
                              u - 1
(%o3)                         -----
                                2
@end group
@end example

@code{funmake} applied to a subscripted function.

@c ===beg===
@c H [a] (x) := (x - 1)^a;
@c funmake (H [n], [%e]);
@c ''%;
@c funmake ('(H [n]), [%e]);
@c ''%;
@c ===end===
@example
@group
(%i1) H [a] (x) := (x - 1)^a;
                                        a
(%o1)                   H (x) := (x - 1)
                         a
@end group
@group
(%i2) funmake (H [n], [%e]);
                                       n
(%o2)               lambda([x], (x - 1) )(%e)
@end group
@group
(%i3) ''%;
                                    n
(%o3)                       (%e - 1)
@end group
@group
(%i4) funmake ('(H [n]), [%e]);
(%o4)                        H (%e)
                              n
@end group
@group
(%i5) ''%;
                                    n
(%o5)                       (%e - 1)
@end group
@end example

@code{funmake} applied to a symbol which is not a defined function of any kind.

@c ===beg===
@c funmake (A, [u]);
@c ''%;
@c ===end===
@example
@group
(%i1) funmake (A, [u]);
(%o1)                         A(u)
@end group
@group
(%i2) ''%;
(%o2)                         A(u)
@end group
@end example

@code{funmake} evaluates its arguments, but not the return value.

@c ===beg===
@c det(a,b,c) := b^2 -4*a*c;
@c (x : 8, y : 10, z : 12);
@c f : det;
@c funmake (f, [x, y, z]);
@c ''%;
@c ===end===
@example
@group
(%i1) det(a,b,c) := b^2 -4*a*c;
                                    2
(%o1)              det(a, b, c) := b  - 4 a c
@end group
@group
(%i2) (x : 8, y : 10, z : 12);
(%o2)                          12
@end group
@group
(%i3) f : det;
(%o3)                          det
@end group
@group
(%i4) funmake (f, [x, y, z]);
(%o4)                    det(8, 10, 12)
@end group
@group
(%i5) ''%;
(%o5)                         - 284
@end group
@end example

Maxima simplifies @code{funmake}'s return value.

@c ===beg===
@c funmake (sin, [%pi / 2]);
@c ===end===
@example
@group
(%i1) funmake (sin, [%pi / 2]);
(%o1)                           1
@end group
@end example

@opencatbox
@category{Function application}
@category{Expressions}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{lambda}
@deffn  {Function} lambda @
@fname{lambda} ([@var{x_1}, @dots{}, @var{x_m}], @var{expr_1}, @dots{}, @var{expr_n}) @
@fname{lambda} ([[@var{L}]], @var{expr_1}, @dots{}, @var{expr_n}) @
@fname{lambda} ([@var{x_1}, @dots{}, @var{x_m}, [@var{L}]], @var{expr_1}, @dots{}, @var{expr_n})

Defines and returns a lambda expression (that is, an anonymous function).
The function may have required arguments @var{x_1}, @dots{}, @var{x_m} and/or
optional arguments @var{L}, which appear within the function body as a list.
The return value of the function is @var{expr_n}.  A lambda expression can be
assigned to a variable and evaluated like an ordinary function.  A lambda
expression may appear in some contexts in which a function name is expected.

When the function is evaluated, unbound local variables @var{x_1}, @dots{},
@var{x_m} are created.  @code{lambda} may appear within @code{block} or another
@code{lambda}; local variables are established each time another @code{block} or
@code{lambda} is evaluated.  Local variables appear to be global to any enclosed
@code{block} or @code{lambda}.  If a variable is not local, its value is the
value most recently assigned in an enclosing @code{block} or @code{lambda}, if
any, otherwise, it is the value of the variable in the global environment.
This policy may coincide with the usual understanding of "dynamic scope".

After local variables are established, @var{expr_1} through @var{expr_n} are
evaluated in turn.  The special variable @code{%%}, representing the value of
the preceding expression, is recognized.  @code{throw} and @code{catch} may also
appear in the list of expressions.

@code{return} cannot appear in a lambda expression unless enclosed by
@code{block}, in which case @code{return} defines the return value of the block
and not of the lambda expression, unless the block happens to be @var{expr_n}.
Likewise, @code{go} cannot appear in a lambda expression unless enclosed by
@code{block}.

@code{lambda} quotes its arguments; 
the quote-quote operator @code{'@w{}'} defeats quotation.

Examples:

@itemize @bullet
@item
A lambda expression can be assigned to a variable and evaluated like an ordinary
function.
@end itemize

@c ===beg===
@c f: lambda ([x], x^2);
@c f(a);
@c ===end===
@example
@group
(%i1) f: lambda ([x], x^2);
                                      2
(%o1)                    lambda([x], x )
@end group
@group
(%i2) f(a);
                                2
(%o2)                          a
@end group
@end example

@itemize @bullet
@item
A lambda expression may appear in contexts in which a function evaluation is expected.
@end itemize

@c ===beg===
@c lambda ([x], x^2) (a);
@c apply (lambda ([x], x^2), [a]);
@c map (lambda ([x], x^2), [a, b, c, d, e]);
@c ===end===
@example
@group
(%i1) lambda ([x], x^2) (a);
                                2
(%o1)                          a
@end group
@group
(%i2) apply (lambda ([x], x^2), [a]);
                                2
(%o2)                          a
@end group
@group
(%i3) map (lambda ([x], x^2), [a, b, c, d, e]);
                        2   2   2   2   2
(%o3)                 [a , b , c , d , e ]
@end group
@end example

@itemize @bullet
@item
Argument variables are local variables.
Other variables appear to be global variables.
Global variables are evaluated at the time the lambda expression is evaluated,
unless some special evaluation is forced by some means, such as @code{'@w{}'}.
@end itemize

@c ===beg===
@c a: %pi$
@c b: %e$
@c g: lambda ([a], a*b);
@c b: %gamma$
@c g(1/2);
@c g2: lambda ([a], a*''b);
@c b: %e$
@c g2(1/2);
@c ===end===
@example
(%i1) a: %pi$
(%i2) b: %e$
@group
(%i3) g: lambda ([a], a*b);
(%o3)                   lambda([a], a b)
@end group
(%i4) b: %gamma$
@group
(%i5) g(1/2);
                             %gamma
(%o5)                        ------
                               2
@end group
@group
(%i6) g2: lambda ([a], a*''b);
(%o6)                 lambda([a], a %gamma)
@end group
(%i7) b: %e$
@group
(%i8) g2(1/2);
                             %gamma
(%o8)                        ------
                               2
@end group
@end example

@itemize @bullet
@item
Lambda expressions may be nested.  Local variables within the outer lambda
expression appear to be global to the inner expression unless masked by local
variables of the same names.
@end itemize

@c ===beg===
@c h: lambda ([a, b], h2: lambda ([a], a*b), h2(1/2));
@c h(%pi, %gamma);
@c ===end===
@example
@group
(%i1) h: lambda ([a, b], h2: lambda ([a], a*b), h2(1/2));
                                                   1
(%o1)     lambda([a, b], h2 : lambda([a], a b), h2(-))
                                                   2
@end group
@group
(%i2) h(%pi, %gamma);
                             %gamma
(%o2)                        ------
                               2
@end group
@end example

@itemize @bullet
@item
Since @code{lambda} quotes its arguments, lambda expression @code{i} below does
not define a "multiply by @code{a}" function.  Such a function can be defined
via @code{buildq}, as in lambda expression @code{i2} below.
@end itemize

@c ===beg===
@c i: lambda ([a], lambda ([x], a*x));
@c i(1/2);
@c i2: lambda([a], buildq([a: a], lambda([x], a*x)));
@c i2(1/2);
@c i2(1/2)(%pi);
@c ===end===
@example
@group
(%i1) i: lambda ([a], lambda ([x], a*x));
(%o1)             lambda([a], lambda([x], a x))
@end group
@group
(%i2) i(1/2);
(%o2)                   lambda([x], a x)
@end group
@group
(%i3) i2: lambda([a], buildq([a: a], lambda([x], a*x)));
(%o3)    lambda([a], buildq([a : a], lambda([x], a x)))
@end group
@group
(%i4) i2(1/2);
                                    1
(%o4)                  lambda([x], (-) x)
                                    2
@end group
@group
(%i5) i2(1/2)(%pi);
                               %pi
(%o5)                          ---
                                2
@end group
@end example

@itemize @bullet
@item
A lambda expression may take a variable number of arguments,
which are indicated by @code{[@var{L}]} as the sole or final argument.
The arguments appear within the function body as a list.
@end itemize

@c ===beg===
@c f : lambda ([aa, bb, [cc]], aa * cc + bb);
@c f (foo, %i, 17, 29, 256);
@c g : lambda ([[aa]], apply ("+", aa));
@c g (17, 29, x, y, z, %e);
@c ===end===
@example
@group
(%i1) f : lambda ([aa, bb, [cc]], aa * cc + bb);
(%o1)          lambda([aa, bb, [cc]], aa cc + bb)
@end group
@group
(%i2) f (foo, %i, 17, 29, 256);
(%o2)       [17 foo + %i, 29 foo + %i, 256 foo + %i]
@end group
@group
(%i3) g : lambda ([[aa]], apply ("+", aa));
(%o3)             lambda([[aa]], apply(+, aa))
@end group
@group
(%i4) g (17, 29, x, y, z, %e);
(%o4)                  z + y + x + %e + 46
@end group
@end example

@opencatbox
@category{Function definition}
@closecatbox
@end deffn

@c NEEDS CLARIFICATION AND EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{local}
@deffn {Function} local (@var{v_1}, @dots{}, @var{v_n})

Saves the properties associated with the symbols @var{v_1}, @dots{}, @var{v_n},
removes any properties before evaluating other expressions,
and restores any saved properties on exit
from the block or other compound expression in which @code{local} appears.

Some declarations are implemented as properties of a symbol, including
@code{:=}, @code{array}, @code{dependencies}, @code{atvalue},
@code{matchdeclare}, @code{atomgrad}, @code{constant}, @code{nonscalar},
@code{assume}, and some others.  The effect of @code{local} is to make such
declarations effective only within the block or other compound expression in
which @code{local} appears; otherwise such declarations are global declarations.

@code{local} can only appear in @code{block}
or in the body of a function definition or @code{lambda} expression,
and only one occurrence is permitted in each.

@code{local} quotes its arguments.
@code{local} returns @code{done}.

Example:

A local function definition.

@c ===beg===
@c foo (x) := 1 - x;
@c foo (100);
@c block (local (foo), foo (x) := 2 * x, foo (100));
@c foo (100);
@c ===end===
@example
@group
(%i1) foo (x) := 1 - x;
(%o1)                    foo(x) := 1 - x
@end group
@group
(%i2) foo (100);
(%o2)                         - 99
@end group
@group
(%i3) block (local (foo), foo (x) := 2 * x, foo (100));
(%o3)                          200
@end group
@group
(%i4) foo (100);
(%o4)                         - 99
@end group
@end example

@opencatbox
@category{Function definition}
@category{Programming}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{macroexpansion}
@defvr {Option variable} macroexpansion
Default value: @code{false}

@code{macroexpansion} controls whether the expansion (that is, the return value)
of a macro function is substituted for the macro function call.
A substitution may speed up subsequent expression evaluations,
at the cost of storing the expansion.

@table @code
@item false
The expansion of a macro function is not substituted for the macro function call.
@item expand
The first time a macro function call is evaluated,
the expansion is stored.
The expansion is not recomputed on subsequent calls;
any side effects (such as @code{print} or assignment to global variables) happen
only when the macro function call is first evaluated.
Expansion in an expression does not affect other expressions
which have the same macro function call.
@item displace
The first time a macro function call is evaluated,
the expansion is substituted for the call,
thus modifying the expression from which the macro function was called.
The expansion is not recomputed on subsequent calls;
any side effects happen only when the macro function call is first evaluated.
Expansion in an expression does not affect other expressions
which have the same macro function call.
@end table

Examples

When @code{macroexpansion} is @code{false},
a macro function is called every time the calling expression is evaluated,
and the calling expression is not modified.

@c ===beg===
@c f (x) := h (x) / g (x);
@c g (x) ::= block (print ("x + 99 is equal to", x), 
@c                        return (x + 99));
@c h (x) ::= block (print ("x - 99 is equal to", x), 
@c                        return (x - 99));
@c macroexpansion: false;
@c f (a * b);
@c dispfun (f);
@c f (a * b);
@c ===end===
@example
@group
(%i1) f (x) := h (x) / g (x);
                                  h(x)
(%o1)                     f(x) := ----
                                  g(x)
@end group
@group
(%i2) g (x) ::= block (print ("x + 99 is equal to", x),
                       return (x + 99));
(%o2) g(x) ::= block(print("x + 99 is equal to", x), 
                                                  return(x + 99))
@end group
@group
(%i3) h (x) ::= block (print ("x - 99 is equal to", x),
                       return (x - 99));
(%o3) h(x) ::= block(print("x - 99 is equal to", x), 
                                                  return(x - 99))
@end group
@group
(%i4) macroexpansion: false;
(%o4)                         false
@end group
@group
(%i5) f (a * b);
x - 99 is equal to x 
x + 99 is equal to x 
                            a b - 99
(%o5)                       --------
                            a b + 99
@end group
@group
(%i6) dispfun (f);
                                  h(x)
(%t6)                     f(x) := ----
                                  g(x)

(%o6)                         [%t6]
@end group
@group
(%i7) f (a * b);
x - 99 is equal to x 
x + 99 is equal to x 
                            a b - 99
(%o7)                       --------
                            a b + 99
@end group
@end example

When @code{macroexpansion} is @code{expand},
a macro function is called once,
and the calling expression is not modified.

@c ===beg===
@c f (x) := h (x) / g (x);
@c g (x) ::= block (print ("x + 99 is equal to", x), 
@c                        return (x + 99));
@c h (x) ::= block (print ("x - 99 is equal to", x), 
@c                        return (x - 99));
@c macroexpansion: expand;
@c f (a * b);
@c dispfun (f);
@c f (a * b);
@c ===end===
@example
@group
(%i1) f (x) := h (x) / g (x);
                                  h(x)
(%o1)                     f(x) := ----
                                  g(x)
@end group
@group
(%i2) g (x) ::= block (print ("x + 99 is equal to", x),
                       return (x + 99));
(%o2) g(x) ::= block(print("x + 99 is equal to", x), 
                                                  return(x + 99))
@end group
@group
(%i3) h (x) ::= block (print ("x - 99 is equal to", x),
                       return (x - 99));
(%o3) h(x) ::= block(print("x - 99 is equal to", x), 
                                                  return(x - 99))
@end group
@group
(%i4) macroexpansion: expand;
(%o4)                        expand
@end group
@group
(%i5) f (a * b);
x - 99 is equal to x 
x + 99 is equal to x 
                            a b - 99
(%o5)                       --------
                            a b + 99
@end group
@group
(%i6) dispfun (f);
                      mmacroexpanded(x - 99, h(x))
(%t6)         f(x) := ----------------------------
                      mmacroexpanded(x + 99, g(x))

(%o6)                         [%t6]
@end group
@group
(%i7) f (a * b);
                            a b - 99
(%o7)                       --------
                            a b + 99
@end group
@end example

When @code{macroexpansion} is @code{displace},
a macro function is called once,
and the calling expression is modified.

@c ===beg===
@c f (x) := h (x) / g (x);
@c g (x) ::= block (print ("x + 99 is equal to", x), 
@c                        return (x + 99));
@c h (x) ::= block (print ("x - 99 is equal to", x), 
@c                        return (x - 99));
@c macroexpansion: displace;
@c f (a * b);
@c dispfun (f);
@c f (a * b);
@c ===end===
@example
@group
(%i1) f (x) := h (x) / g (x);
                                  h(x)
(%o1)                     f(x) := ----
                                  g(x)
@end group
@group
(%i2) g (x) ::= block (print ("x + 99 is equal to", x),
                       return (x + 99));
(%o2) g(x) ::= block(print("x + 99 is equal to", x), 
                                                  return(x + 99))
@end group
@group
(%i3) h (x) ::= block (print ("x - 99 is equal to", x),
                       return (x - 99));
(%o3) h(x) ::= block(print("x - 99 is equal to", x), 
                                                  return(x - 99))
@end group
@group
(%i4) macroexpansion: displace;
(%o4)                       displace
@end group
@group
(%i5) f (a * b);
x - 99 is equal to x 
x + 99 is equal to x 
                            a b - 99
(%o5)                       --------
                            a b + 99
@end group
@group
(%i6) dispfun (f);
                                 x - 99
(%t6)                    f(x) := ------
                                 x + 99

(%o6)                         [%t6]
@end group
@group
(%i7) f (a * b);
                            a b - 99
(%o7)                       --------
                            a b + 99
@end group
@end example

@opencatbox
@category{Function application}
@category{Global flags}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{mode_declare}
@anchor{modedeclare}
@deffn {Function} mode_declare (@var{y_1}, @var{mode_1}, @dots{}, @var{y_n}, @var{mode_n})

A @code{mode_declare} informs the compiler which type (lisp programmers name the type:
``mode'') a function parameter or its return value will be of. This can greatly
boost the efficiency of the code the compiler generates: Without knowing the type of
all variables and knowing the return value of all functions a function uses
in advance very generic (and thus potentially slow) code needs to be generated.

The arguments of @code{mode_declare} are pairs consisting of a variable (or a list
of variables all having the same mode) and a mode. Available modes (``types'') are:
@example
array            an declared array (see the detailed description below)
string           a string
boolean          true or false
integer          integers (including arbitrary-size integers)
fixnum           integers (excluding arbitrary-size integers)
float            machine-size floating-point numbers
real             machine-size floating-point or integer
@c DOES NUMBER, EVEN AND ODD INCLUDE BFLOATS AND ARBITRARY-SIZE INTS?
number           Numbers
even             Even integers
odd              Odd integers
any              any kind of object (useful for arrays of any)
@end example

A function parameter named @code{a} can be declared as an array filled with elements
of the type @code{t} the following way:
@example
mode_declare (a, array(t, dim1, dim2, ...))
@end example
If none of the elements of the array @code{a} needs to be checked if it still doesn't
contain a value additional code can be omitted by declaring this fact, too:
@example
mode_declare (a, array (t, complete, dim1, dim2, ...))
@end example
The @code{complete} has no effect if all array elements are of the type
@code{fixnum} or @code{float}: Machine-sized numbers inevitably contain a value
(and will automatically be initialized to 0 in most lisp implementations).

Another way to tell that all entries of the array @code{a} are of the type
(``mode'') @code{m} and have been assigned a value to would be:
@example
mode_declare (completearray (a), m))
@end example

Numeric code using arrays might run faster still if the size of the array is
known at compile time, as well, as in:
@example
mode_declare (completearray (a [10, 10]), float)
@end example
for a floating point number array named @code{a} which is 10 x 10.

@code{mode_declare} also can be used in order to declare the type of the result
of a function. In this case the function compilation needs to be preceded by
another @code{mode_declare} statement. For example the expression,
@example
mode_declare ([function (f_1, f_2, ...)], fixnum)
@end example
declares that the values returned by @code{f_1}, @code{f_2}, @dots{} are
single-word integers.

@code{modedeclare} is a synonym for @code{mode_declare}.

If the type of function parameters and results doesn't match the declaration by
@code{mode_declare} the function may misbehave or a warning or an error might
occur, see @mrefcomma{mode_checkp} @mref{mode_check_errorp} and
@mrefdot{mode_check_warnp}

See @mref{mode_identity} for declaring the type of lists and @mref{define_variable} for
declaring the type of all global variables compiled code uses, as well.

Example:
@c ===beg===
@c square_float(f):=(
@c      mode_declare(f,float),
@c      f*f
@c  );
@c mode_declare([function(f)],float);
@c compile(square_float);
@c square_float(100.0);
@c ===end===
@example
@group
(%i1) square_float(f):=(
     mode_declare(f,float),
     f*f
 );
(%o1)   square_float(f) := (mode_declare(f, float), f f)
@end group
@group
(%i2) mode_declare([function(f)],float);
(%o2)                    [[function(f)]]
@end group
@group
(%i3) compile(square_float);
(%o3)                    [square_float]
@end group
@group
(%i4) square_float(100.0);
(%o4)                        10000.0
@end group
@end example


@opencatbox
@category{Translation and compilation}
@closecatbox
@end deffn

@c NEEDS MORE EXAMPLES?

@c -----------------------------------------------------------------------------
@anchor{mode_checkp}
@defvr {Option variable} mode_checkp
Default value: @code{true}

When @code{mode_checkp} is @code{true}, @mref{mode_declare} does not only define
which type a variable will be of so the compiler can generate more efficient code,
but will also create a runtime warning if the variable isn't of the variable type
the code was compiled to deal with.

@c ===beg===
@c mode_checkp:true;
@c square(f):=(
@c          mode_declare(f,float),
@c          f^2);
@c      compile(square);
@c      square(2.3);
@c      square(4);
@c ===end===
@example
@group
(%i1) mode_checkp:true;
(%o1)                         true
@end group
@group
(%i2) square(f):=(
    mode_declare(f,float),
    f^2);
                                                   2
(%o2)       square(f) := (mode_declare(f, float), f )
@end group
@group
(%i3) compile(square);
(%o3)                       [square]
@end group
@group
(%i4) square(2.3);
(%o4)                   5.289999999999999
@end group
@group
(%i5) square(4);
Maxima encountered a Lisp error:

 The value
   4
 is not of type
   DOUBLE-FLOAT
 when binding $F

Automatically continuing.
To enable the Lisp debugger set *debugger-hook* to nil.
@end group
@end example

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{mode_check_errorp}
@defvr {Option variable} mode_check_errorp
Default value: @code{false}

When @code{mode_check_errorp} is @code{true}, @code{mode_declare} calls
error.
@c NEED SOME EXAMPLES HERE.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{mode_check_warnp}
@defvr {Option variable} mode_check_warnp
Default value: @code{true}

@c WHAT DOES THIS MEAN ??
When @code{mode_check_warnp} is @code{true}, mode errors are
described.
@c NEED SOME EXAMPLES HERE.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c NEEDS AN EXAMPLE FOR DECLARING THE RETURN TYPE

@c -----------------------------------------------------------------------------
@anchor{mode_identity}
@deffn {Function} mode_identity (@var{arg_1}, @var{arg_2})

@code{mode_identity} works similar to @mref{mode_declare}, but is used for
informing the compiler that a thing like a @code{macro} or a list operation
will only return a specific type of object. The purpose of doing so is that
maxima supports many objects: Machine integers, arbitrary length integers,
equations, machine floats, big floats, which means that for everything that
deals with return values of operations that can result in any object the
compiler needs to output generic (and therefore potentially slow) code.

The first argument to @code{mode_identity} is the type of return value
something will return (for possible types see @mref{mode_declare}).
(i.e., one of @code{float}, @code{fixnum}, @code{number},
The second argument is the expression that will return an object of this
type.

If the the return value of this expression is of a type the code was not
compiled for error or warning is signalled.
@c ARE THE MODE_DECLARE VARIABLES FOR TURNING OFF THIS ERROR OR WARNING
@c EFFECTIVE HERE, TOO?

If you knew that @code{first (l)} returned a number then you could write

@example
@code{mode_identity (number, first (l))}.
@end example
However, if you need this construct more often it would be more efficient
to define a function that returns a number fist:
@example
firstnumb (x) ::= buildq ([x], mode_identity (number, first(x)));
compile(firstnumb)
@end example
@code{firstnumb} now can be used every time you need the first element
of a list that is guaranteed to be filled with numbers.
@opencatbox
@category{Translation and compilation}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{remfunction}
@deffn  {Function} remfunction @
@fname{remfunction} (@var{f_1}, @dots{}, @var{f_n}) @
@fname{remfunction} (all)

Unbinds the function definitions of the symbols @var{f_1}, @dots{}, @var{f_n}.
The arguments may be the names of ordinary functions (created by @mref{:=} or
@mref{define}) or macro functions (created by @mref{::=}).

@code{remfunction (all)} unbinds all function definitions.

@code{remfunction} quotes its arguments.

@code{remfunction} returns a list of the symbols for which the function
definition was unbound.  @code{false} is returned in place of any symbol for
which there is no function definition.

@code{remfunction} does not apply to @mref{memoizing functions} or subscripted functions.
@mref{remarray} applies to those types of functions.

@opencatbox
@category{Function definition}
@closecatbox
@end deffn

@c NEEDS MORE WORK !!!

@c -----------------------------------------------------------------------------
@anchor{savedef}
@defvr {Option variable} savedef
Default value: @code{true}

When @code{savedef} is @code{true}, the Maxima version of a user function is
preserved when the function is translated.  This permits the definition to be
displayed by @code{dispfun} and allows the function to be edited.

When @code{savedef} is @code{false}, the names of translated functions are
removed from the @code{functions} list.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c IS THERE ANY REASON TO SET transcompile: false ??
@c MAYBE THIS VARIABLE COULD BE PERMANENTLY SET TO true AND STRUCK FROM THE DOCUMENTATION.

@c -----------------------------------------------------------------------------
@anchor{transcompile}
@defvr {Option variable} transcompile
Default value: @code{true}

When @code{transcompile} is @code{true}, @code{translate} and
@code{translate_file} generate declarations to make the translated code more
suitable for compilation.
@c BUT THE DECLARATIONS DON'T SEEM TO BE NECESSARY, SO WHAT'S THE POINT AGAIN ??

@code{compfile} sets @code{transcompile: true} for the duration.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{translate}
@deffn  {Function} translate @
@fname{translate} (@var{f_1}, @dots{}, @var{f_n}) @
@fname{translate} (functions) @
@fname{translate} (all)

Translates the user-defined functions @var{f_1}, @dots{}, @var{f_n} from the
Maxima language into Lisp and evaluates the Lisp translations.
Typically the translated functions run faster than the originals.

@code{translate (all)} or @code{translate (functions)} translates all
user-defined functions.

Functions to be translated should include a call to @code{mode_declare} at the
beginning when possible in order to produce more efficient code.  For example:

@example
f (x_1, x_2, ...) := block ([v_1, v_2, ...],
    mode_declare (v_1, mode_1, v_2, mode_2, ...), ...)
@end example

@noindent
where the @var{x_1}, @var{x_2}, @dots{}  are the parameters to the function and
the @var{v_1}, @var{v_2}, @dots{} are the local variables.

The names of translated functions are removed from the @code{functions} list
if @code{savedef} is @code{false} (see below) and are added to the @code{props}
lists.

Functions should not be translated unless they are fully debugged.

Expressions are assumed simplified; if they are not, correct but non-optimal
code gets generated.  Thus, the user should not set the @code{simp} switch to
@code{false} which inhibits simplification of the expressions to be translated.

The switch @code{translate}, if @code{true}, causes automatic
translation of a user's function to Lisp.

Note that translated
functions may not run identically to the way they did before
translation as certain incompatibilities may exist between the Lisp
and Maxima versions.  Principally, the @code{rat} function with more than
one argument and the @code{ratvars} function should not be used if any
variables are @code{mode_declare}'d canonical rational expressions (CRE).
Also the @code{prederror: false} setting
will not translate.
@c WHAT ABOUT % AND %% ???

@code{savedef} - if @code{true} will cause the Maxima version of a user
function to remain when the function is @code{translate}'d.  This permits the
definition to be displayed by @code{dispfun} and allows the function to be
edited.

@code{transrun} - if @code{false} will cause the interpreted version of all
functions to be run (provided they are still around) rather than the
translated version.

The result returned by @code{translate} is a list of the names of the
functions translated.

@opencatbox
@category{Translation and compilation}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{translate_file}
@deffn  {Function} translate_file @
@fname{translate_file} (@var{maxima_filename}) @
@fname{translate_file} (@var{maxima_filename}, @var{lisp_filename})

Translates a file of Maxima code into a file of Lisp code.
@code{translate_file} returns a list of three filenames:
the name of the Maxima file, the name of the Lisp file, and the name of file
containing additional information about the translation.
@code{translate_file} evaluates its arguments.

@code{translate_file ("foo.mac"); load("foo.LISP")} is the same as the command
@code{batch ("foo.mac")} except for certain restrictions, the use of
@code{'@w{}'} and @code{%}, for example.
@c FIGURE OUT WHAT THE RESTRICTIONS ARE AND STATE THEM

@code{translate_file (@var{maxima_filename})} translates a Maxima file
@var{maxima_filename} into a similarly-named Lisp file.
For example, @code{foo.mac} is translated into @code{foo.LISP}.
The Maxima filename may include a directory name or names,
in which case the Lisp output file is written
to the same directory from which the Maxima input comes.

@code{translate_file (@var{maxima_filename}, @var{lisp_filename})} translates
a Maxima file @var{maxima_filename} into a Lisp file @var{lisp_filename}.
@code{translate_file} ignores the filename extension, if any, of
@code{lisp_filename}; the filename extension of the Lisp output file is always
@code{LISP}.  The Lisp filename may include a directory name or names,
in which case the Lisp output file is written to the specified directory.

@code{translate_file} also writes a file of translator warning
messages of various degrees of severity.
The filename extension of this file is @code{UNLISP}.
This file may contain valuable information, though possibly obscure,
for tracking down bugs in translated code.
The @code{UNLISP} file is always written
to the same directory from which the Maxima input comes.

@code{translate_file} emits Lisp code which causes
some declarations and definitions to take effect as soon
as the Lisp code is compiled.
See @code{compile_file} for more on this topic.

@c CHECK ALL THESE AND SEE WHICH ONES ARE OBSOLETE
See also 
@flushleft
@code{tr_array_as_ref}
@c tr_bind_mode_hook EXISTS BUT IT APPEARS TO BE A GROTESQUE UNDOCUMENTED HACK
@c WE DON'T WANT TO MENTION IT
@c @code{tr_bind_mode_hook}, 
@mrefcomma{tr_bound_function_applyp}
@c tr_exponent EXISTS AND WORKS AS ADVERTISED IN src/troper.lisp
@c NOT OTHERWISE DOCUMENTED; ITS EFFECT SEEMS TOO WEAK TO MENTION
@code{tr_exponent}
@mrefcomma{tr_file_tty_messagesp}
@mrefcomma{tr_float_can_branch_complex}
@mrefcomma{tr_function_call_default}
@mrefcomma{tr_numer}
@mrefcomma{tr_optimize_max_loop}
@mrefcomma{tr_semicompile}
@mrefcomma{tr_state_vars}
@mrefcomma{tr_warnings_get}
@c Not documented
@code{tr_warn_bad_function_calls}
@mrefcomma{tr_warn_fexpr} 
@mrefcomma{tr_warn_meval}
@mrefcomma{tr_warn_mode}
@mrefcomma{tr_warn_undeclared}
and @mrefdot{tr_warn_undefined_variable}
@end flushleft

@opencatbox
@category{Translation and compilation}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{transrun}
@defvr {Option variable} transrun
Default value: @code{true}

When @code{transrun} is @code{false} will cause the interpreted
version of all functions to be run (provided they are still around)
rather than the translated version.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c IN WHAT CONTEXT IS tr_array_as_ref: false APPROPRIATE ??? NOT SEEING THE USEFULNESS HERE.
@c ALSO, I GUESS WE SHOULD HAVE AN ITEM FOR translate_fast_arrays, ANOTHER CONFUSING FLAG ...

@c -----------------------------------------------------------------------------
@anchor{tr_array_as_ref}
@defvr {Option variable} tr_array_as_ref
Default value: @code{true}

If @code{translate_fast_arrays} is @code{false}, array references in Lisp code
emitted by @code{translate_file} are affected by @code{tr_array_as_ref}.
When @code{tr_array_as_ref} is @code{true},
array names are evaluated,
otherwise array names appear as literal symbols in translated code.

@code{tr_array_as_ref} has no effect if @code{translate_fast_arrays} is
@code{true}.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c WHY IS THIS FLAG NEEDED ??? UNDER WHAT CIRCUMSTANCES CAN TRANSLATION
@c OF A BOUND VARIABLE USED AS A FUNCTION GO WRONG ???

@c -----------------------------------------------------------------------------
@anchor{tr_bound_function_applyp}
@defvr {Option variable} tr_bound_function_applyp
Default value: @code{true}

When @code{tr_bound_function_applyp} is @code{true}, Maxima gives a warning if a
bound variable (such as a function argument) is found being used as a function.
@c WHAT DOES THIS MEAN ??
@code{tr_bound_function_applyp} does not affect the code generated in such
cases.

For example, an expression such as @code{g (f, x) := f (x+1)} will trigger
the warning message.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{tr_file_tty_messagesp}
@defvr {Option variable} tr_file_tty_messagesp
Default value: @code{false}

When @code{tr_file_tty_messagesp} is @code{true}, messages generated by
@code{translate_file} during translation of a file are displayed on the console
and inserted into the UNLISP file.  When @code{false}, messages about
translation of the file are only inserted into the UNLISP file.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c THIS FLAG APPEARS TO HAVE NO EFFECT. SHOULD CUT OUT THIS ITEM AND RELATED CODE.
@c NOTE THAT THERE IS CODE IN src/transf.lisp WHICH USES THIS FLAG BUT THE MODE
@c FLAG IS LOST SOMEWHERE ALONG THE WAY TO THE LISP OUTPUT FILE.

@c -----------------------------------------------------------------------------
@anchor{tr_float_can_branch_complex}
@defvr {Option variable} tr_float_can_branch_complex
Default value: @code{true}

Tells the Maxima-to-Lisp translator to assume that the functions 
@code{acos}, @code{asin}, @code{asec}, and @code{acsc} can return complex results.

The ostensible effect of @code{tr_float_can_branch_complex} is the following.
However, it appears that this flag has no effect on the translator output.

When it is @code{true} then @code{acos(x)} is of mode @code{any}
even if @code{x} is of mode @code{float} (as set by @code{mode_declare}).
When @code{false} then @code{acos(x)} is of mode
@code{float} if and only if @code{x} is of mode @code{float}.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{tr_function_call_default}
@defvr {Option variable} tr_function_call_default
Default value: @code{general}

@code{false} means give up and call @code{meval}, @code{expr} means assume Lisp
fixed arg function.  @code{general}, the default gives code good for
@code{mexprs} and @code{mlexprs} but not @code{macros}.  @code{general} assures
variable bindings are correct in compiled code.  In @code{general} mode, when
translating F(X), if F is a bound variable, then it assumes that
@code{apply (f, [x])} is meant, and translates a such, with appropriate warning.
There is no need to turn this off.  With the default settings, no warning
messages implies full compatibility of translated and compiled code with the
Maxima interpreter.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{tr_numer}
@defvr {Option variable} tr_numer
Default value: @code{false}

When @code{tr_numer} is @code{true}, @code{numer} properties are used for
atoms which have them, e.g. @code{%pi}.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{tr_optimize_max_loop}
@defvr {Option variable} tr_optimize_max_loop
Default value: 100

@code{tr_optimize_max_loop} is the maximum number of times the
macro-expansion and optimization pass of the translator will loop in
considering a form.  This is to catch macro expansion errors, and
non-terminating optimization properties.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{tr_semicompile}
@defvr {Option variable} tr_semicompile
Default value: @code{false}

When @code{tr_semicompile} is @code{true}, @code{translate_file} and
@code{compfile} output forms which will be macroexpanded but not compiled into
machine code by the Lisp compiler.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c ARE ANY OF THESE OBSOLETE ??

@c -----------------------------------------------------------------------------
@anchor{tr_state_vars}
@defvr {System variable} tr_state_vars
Default value:
@example
[transcompile, tr_semicompile, tr_warn_undeclared, tr_warn_meval,
tr_warn_fexpr, tr_warn_mode, tr_warn_undefined_variable,
tr_function_call_default, tr_array_as_ref,tr_numer]
@end example

The list of the switches that affect the form of the
translated output.
@c DOES THE GENERAL USER REALLY CARE ABOUT DEBUGGING THE TRANSLATOR ???
This information is useful to system people when
trying to debug the translator.  By comparing the translated product
to what should have been produced for a given state, it is possible to
track down bugs.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c tr_warnings_get EXISTS AND FUNCTIONS AS ADVERTISED (SORT OF) -- RETURNS *tr-runtime-warned*
@c WHICH HAS ONLY A FEW KINDS OF WARNINGS PUSHED ONTO IT; IT'S CERTAINLY NOT COMPREHENSIVE
@c DO WE REALLY NEED THIS SLIGHTLY WORKING FUNCTION ??

@c -----------------------------------------------------------------------------
@anchor{tr_warnings_get}
@deffn {Function} tr_warnings_get ()

Prints a list of warnings which have been given by
the translator during the current translation.

@opencatbox
@category{Translation and compilation}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@defvr {Option variable} tr_warn_bad_function_calls
Default value: @code{true}

- Gives a warning when
when function calls are being made which may not be correct due to
improper declarations that were made at translate time.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{tr_warn_fexpr}
@defvr {Option variable} tr_warn_fexpr
Default value: @code{compfile}

- Gives a warning if any FEXPRs are
encountered.  FEXPRs should not normally be output in translated code,
all legitimate special program forms are translated.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{tr_warn_meval}
@defvr {Option variable} tr_warn_meval
Default value: @code{compfile}

- Gives a warning if the function @code{meval} gets called.  If @code{meval} is
called that indicates problems in the translation.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{tr_warn_mode}
@defvr {Option variable} tr_warn_mode
Default value: @code{all}

- Gives a warning when variables are
assigned values inappropriate for their mode.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{tr_warn_undeclared}
@defvr {Option variable} tr_warn_undeclared
Default value: @code{compile}

- Determines when to send
warnings about undeclared variables to the TTY.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{tr_warn_undefined_variable}
@defvr {Option variable} tr_warn_undefined_variable
Default value: @code{all}

- Gives a warning when
undefined global variables are seen.

@opencatbox
@category{Translation flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{compile_file}
@deffn  {Function} compile_file @
@fname{compile_file} (@var{filename}) @
@fname{compile_file} (@var{filename}, @var{compiled_filename}) @
@fname{compile_file} (@var{filename}, @var{compiled_filename}, @var{lisp_filename})

Translates the Maxima file @var{filename} into Lisp, executes the Lisp compiler,
and, if the translation and compilation succeed, loads the compiled code into
Maxima.

@code{compile_file} returns a list of the names of four files: the original
Maxima file, the Lisp translation, notes on translation, and the compiled code.
If the compilation fails, the fourth item is @code{false}.

Some declarations and definitions take effect as soon
as the Lisp code is compiled (without loading the compiled code).
These include functions defined with the @code{:=} operator,
macros define with the @code{::=} operator,
@c HEDGE -- DON'T KNOW IF THERE IS ANOTHER WAY
@code{alias}, @code{declare},
@code{define_variable},  @code{mode_declare},
and 
@code{infix}, @code{matchfix},
@code{nofix}, @code{postfix}, @code{prefix},
and @code{compfile}.

Assignments and function calls are not evaluated until the compiled code is
loaded.  In particular, within the Maxima file, assignments to the translation
flags (@code{tr_numer}, etc.) have no effect on the translation.

@c @code{compile_file} may mistake warnings for errors and
@c return @code{false} as the name of the compiled code when, in fact,
@c the compilation succeeded. This is a bug. 
@c REPORTED AS SOURCEFORGE BUG # 1103722.

@var{filename} may not contain @code{:lisp} statements.

@code{compile_file} evaluates its arguments.

@opencatbox
@category{Translation and compilation}
@closecatbox
@end deffn

@c NEEDS CLARIFICATION

@c -----------------------------------------------------------------------------
@anchor{declare_translated}
@deffn {Function} declare_translated (@var{f_1}, @var{f_2}, @dots{})

When translating a file of Maxima code
to Lisp, it is important for the translator to know which functions it
sees in the file are to be called as translated or compiled functions,
and which ones are just Maxima functions or undefined.  Putting this
declaration at the top of the file, lets it know that although a symbol
does which does not yet have a Lisp function value, will have one at
call time.  @code{(MFUNCTION-CALL fn arg1 arg2 ...)} is generated when
the translator does not know @code{fn} is going to be a Lisp function.

@opencatbox
@category{Translation and compilation}
@closecatbox
@end deffn

