@c -*- Mode: texinfo -*-
@menu
* Lisp and Maxima::
* Garbage Collection::
* Introduction to Program Flow::
* Functions and Variables for Program Flow::
@end menu

@c -----------------------------------------------------------------------------
@node Lisp and Maxima, Garbage Collection, Program Flow, Program Flow
@section Lisp and Maxima
@c -----------------------------------------------------------------------------

Maxima is a fairly complete programming language. But since it is written in
Lisp, it additionally can provide easy access to Lisp functions and variables
from Maxima and vice versa.  Lisp and Maxima symbols are distinguished by a
naming convention.  A Lisp symbol which begins with a dollar sign @code{$}
corresponds to a Maxima symbol without the dollar sign.

@c NEED TO MENTION THIS OR IS IT JUST CLUTTERING ??
@c This includes special Maxima variables such as @code{%} and input and output
@c labels, which appear as @code{$%}, @code{$%i1}, @code{$%o1}, etc., in Lisp.

A Maxima symbol which begins with a question mark @code{?} corresponds to a Lisp
symbol without the question mark.  For example, the Maxima symbol @code{foo}
corresponds to the Lisp symbol @code{$FOO}, while the Maxima symbol @code{?foo}
corresponds to the Lisp symbol @code{FOO}.  Note that @code{?foo} is written
without a space between @code{?} and @code{foo}; otherwise it might be mistaken
for @code{describe ("foo")}.

Hyphen @code{-}, asterisk @code{*}, or other special characters in Lisp symbols
must be escaped by backslash @code{\} where they appear in Maxima code.  For
example, the Lisp identifier @code{*foo-bar*} is written @code{?\*foo\-bar\*}
in Maxima.

Lisp code may be executed from within a Maxima session.  A single line of Lisp
(containing one or more forms) may be executed by the special command
@code{:lisp}.  For example,

@example
(%i1) :lisp (foo $x $y)
@end example

@noindent
calls the Lisp function @code{foo} with Maxima variables @code{x} and @code{y}
as arguments.  The @code{:lisp} construct can appear at the interactive prompt
or in a file processed by @mref{batch} or @mrefcomma{demo} but not in a file
processed by @mrefcomma{load} @mrefcomma{batchload}@w{}
@mrefcomma{translate_file} or @mrefdot{compile_file}

The function @mref{to_lisp} opens an interactive Lisp session.
Entering @code{(to-maxima)} closes the Lisp session and returns to Maxima.
@c I DON'T EVEN WANT TO MENTION USING CTRL-C TO OPEN A LISP SESSION.
@c (1) IT TAKES EXTRA SET UP TO GET STARTED NAMELY :lisp (setq *debugger-hook* nil)
@c (2) IT GETS SCREWED UP EASILY -- TYPE SOMETHING WRONG AND YOU CAN'T GET BACK TO MAXIMA
@c (3) IT DOESN'T OFFER FUNCTIONALITY NOT PRESENT IN THE to_lisp() SESSION

Lisp functions and variables which are to be visible in Maxima as functions and
variables with ordinary names (no special punctuation) must have Lisp names
beginning with the dollar sign @code{$}.

Maxima is case-sensitive, distinguishing between lowercase and uppercase letters
in identifiers.  There are some rules governing the translation of names between
Lisp and Maxima.

@enumerate
@item
A Lisp identifier not enclosed in vertical bars corresponds to a Maxima
identifier in lowercase.  Whether the Lisp identifier is uppercase, lowercase,
or mixed case, is ignored.  E.g., Lisp @code{$foo}, @code{$FOO}, and @code{$Foo}
all correspond to Maxima @code{foo}.  But this is because @code{$foo},
@code{$FOO} and @code{$Foo} are converted by the Lisp reader by default to the
Lisp symbol @code{$FOO}.
@item
A Lisp identifier which is all uppercase or all lowercase and enclosed in
vertical bars corresponds to a Maxima identifier with case reversed.  That is,
uppercase is changed to lowercase and lowercase to uppercase.  E.g., Lisp
@code{|$FOO|} and @code{|$foo|} correspond to Maxima @code{foo} and @code{FOO},
respectively.
@item
A Lisp identifier which is mixed uppercase and lowercase and enclosed in
vertical bars corresponds to a Maxima identifier with the same case.  E.g.,
Lisp @code{|$Foo|} corresponds to Maxima @code{Foo}.
@end enumerate

The @code{#$} Lisp macro allows the use of Maxima expressions in Lisp code.
@code{#$@var{expr}$} expands to a Lisp expression equivalent to the Maxima
expression @var{expr}.

@example
(msetq $foo #$[x, y]$)
@end example

@noindent
This has the same effect as entering

@example
(%i1) foo: [x, y];
@end example

@noindent
The Lisp function @code{displa} prints an expression in Maxima format.

@example
(%i1) :lisp #$[x, y, z]$ 
((MLIST SIMP) $X $Y $Z)
(%i1) :lisp (displa '((MLIST SIMP) $X $Y $Z))
[x, y, z]
NIL
@end example

Functions defined in Maxima are not ordinary Lisp functions.  The Lisp function
@code{mfuncall} calls a Maxima function.  For example:

@example
(%i1) foo(x,y) := x*y$
(%i2) :lisp (mfuncall '$foo 'a 'b)
((MTIMES SIMP) A B)
@end example

Some Lisp functions are shadowed in the Maxima package, namely the following.

@verbatim
   complement     continue      //
   float          functionp     array
   exp            listen        signum
   atan           asin          acos
   asinh          acosh         atanh
   tanh           cosh          sinh
   tan            break         gcd
@end verbatim

@opencatbox
@category{Programming}
@closecatbox

@c -----------------------------------------------------------------------------
@node Garbage Collection, Introduction to Program Flow, Lisp and Maxima, Program Flow
@section Garbage Collection
@c -----------------------------------------------------------------------------

Symbolic computation tends to create a good deal of garbage (temporary or
intermediate results that are eventually not used), and effective handling of
this can be crucial to successful completion of some programs.

@c HOW MUCH OF THE FOLLOWING STILL HOLDS ??
@c WHAT ABOUT GC IN GCL ON MS WINDOWS ??
@c SHOULD WE SAY SOMETHING ABOUT GC FOR OTHER LISPS ??
Under GCL, on UNIX systems where the mprotect system call is available
(including SUN OS 4.0 and some variants of BSD) a stratified garbage collection
is available.  This limits the collection to pages which have been recently
written to.  See the GCL documentation under ALLOCATE and GBC.  At the Lisp
level doing (setq si::*notify-gbc* t) will help you determine which areas might
need more space.

For other Lisps that run Maxima, we refer the reader to the documentation for
that Lisp on how to control GC.

@c -----------------------------------------------------------------------------
@node Introduction to Program Flow, Functions and Variables for Program Flow, Garbage Collection, Program Flow
@section Introduction to Program Flow
@c -----------------------------------------------------------------------------

Maxima provides a @code{do} loop for iteration, as well as more primitive
constructs such as @code{go}.

@c end concepts Program Flow

@c -----------------------------------------------------------------------------
@node Functions and Variables for Program Flow,  , Introduction to Program Flow, Program Flow
@section Functions and Variables for Program Flow
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{backtrace}
@deffn  {Function} backtrace @
@fname{backtrace} () @
@fname{backtrace} (@var{n})

Prints the call stack, that is, the list of functions which
called the currently active function.

@code{backtrace ()} prints the entire call stack.

@code{backtrace (@var{n})} prints the @var{n} most recent 
functions, including the currently active function.

@c IS THIS STATEMENT REALLY NEEDED ?? 
@c (WHY WOULD ANYONE BELIEVE backtrace CANNOT BE CALLED OUTSIDE A DEBUGGING CONTEXT??)
@code{backtrace} can be called from a script, a function, or the interactive
prompt (not only in a debugging context).

Examples:

@itemize @bullet
@item
@code{backtrace ()} prints the entire call stack.

@example
(%i1) h(x) := g(x/7)$
(%i2) g(x) := f(x-11)$
(%i3) f(x) := e(x^2)$
(%i4) e(x) := (backtrace(), 2*x + 13)$
(%i5) h(10);
#0: e(x=4489/49)
#1: f(x=-67/7)
#2: g(x=10/7)
#3: h(x=10)
                              9615
(%o5)                         ----
                               49
@end example
@end itemize

@itemize @bullet
@item
@code{backtrace (@var{n})} prints the @var{n} most recent 
functions, including the currently active function.

@example
(%i1) h(x) := (backtrace(1), g(x/7))$
(%i2) g(x) := (backtrace(1), f(x-11))$
(%i3) f(x) := (backtrace(1), e(x^2))$
(%i4) e(x) := (backtrace(1), 2*x + 13)$
(%i5) h(10);
#0: h(x=10)
#0: g(x=10/7)
#0: f(x=-67/7)
#0: e(x=4489/49)
                              9615
(%o5)                         ----
                               49
@end example
@end itemize

@opencatbox
@category{Debugging}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{do}
@anchor{while}
@anchor{unless}
@anchor{for}
@anchor{from}
@anchor{thru}
@anchor{step}
@anchor{next}
@anchor{in}
@deffn {Special operator} do
@deffnx {Special operator} while
@deffnx {Special operator} unless
@deffnx {Special operator} for
@deffnx {Special operator} from
@deffnx {Special operator} thru
@deffnx {Special operator} step
@deffnx {Special operator} next
@deffnx {Special operator} in

The @code{do} statement is used for performing iteration. The general
form of the @code{do} statements maxima supports is:

@itemize @bullet
@item
@code{for @var{variable}: @var{initial_value} step @var{increment}
      thru @var{limit} do @var{body}}
@item
@code{for @var{variable}: @var{initial_value} step @var{increment}
      while @var{condition} do @var{body}}
@item
@code{for @var{variable}: @var{initial_value} step @var{increment}
      unless @var{condition} do @var{body}}
@item
@code{for @var{variable} in @var{list} do @var{body}}
@end itemize

If the loop is expected to generate a list as output the command
@mref{makelist} may be the appropriate command to use instead,
@xref{Performance considerations for Lists}.

@var{initial_value}, @var{increment}, @var{limit}, and @var{body} can be any
expression. @var{list} is a list.  If the increment is 1 then "@code{step 1}"
may be omitted; As always, if @code{body} needs to contain more than one command
these commands can be specified as a comma-separated list surrounded
by parenthesis or as a @mrefdot{block}
Due to its great generality the @code{do} statement will be described in two parts.
The first form of the @code{do} statement (which is shown in the first three
items above) is analogous to that used in
several other programming languages (Fortran, Algol, PL/I, etc.); then
the other features will be mentioned.

The execution of the @code{do} statement proceeds by first assigning
the @var{initial_value} to the @var{variable} (henceforth called the
control-variable).  Then: (1) If the control-variable has exceeded the
limit of a @code{thru} specification, or if the condition of the
@code{unless} is @code{true}, or if the condition of the @code{while}
is @code{false} then the @code{do} terminates.  (2) The @var{body} is
evaluated.  (3) The increment is added to the control-variable.  The
process from (1) to (3) is performed repeatedly until the termination
condition is satisfied.  One may also give several termination
conditions in which case the @code{do} terminates when any of them is
satisfied.

In general the @code{thru} test is satisfied when the control-variable
is greater than the @var{limit} if the @var{increment} was
non-negative, or when the control-variable is less than the
@var{limit} if the @var{increment} was negative.  The
@var{increment} and @var{limit} may be non-numeric expressions as
long as this inequality can be determined.  However, unless the
@var{increment} is syntactically negative (e.g. is a negative number)
at the time the @code{do} statement is input, Maxima assumes it will
be positive when the @code{do} is executed.  If it is not positive,
then the @code{do} may not terminate properly.

Note that the @var{limit}, @var{increment}, and termination condition are
evaluated each time through the loop.  Thus if any of these involve
much computation, and yield a result that does not change during all
the executions of the @var{body}, then it is more efficient to set a
variable to their value prior to the @code{do} and use this variable in the
@code{do} form.

The value normally returned by a @code{do} statement is the atom
@code{done}.  However, the function @code{return} may be used inside
the @var{body} to exit the @code{do} prematurely and give it any
desired value.  Note however that a @code{return} within a @code{do}
that occurs in a @code{block} will exit only the @code{do} and not the
@code{block}.  Note also that the @code{go} function may not be used
to exit from a @code{do} into a surrounding @code{block}.

The control-variable is always local to the @code{do} and thus any
variable may be used without affecting the value of a variable with
the same name outside of the @code{do}.  The control-variable is unbound
after the @code{do} terminates.

@example
(%i1) for a:-3 thru 26 step 7 do display(a)$
                             a = - 3

                              a = 4

                             a = 11

                             a = 18

                             a = 25
@end example

@example
(%i1) s: 0$
(%i2) for i: 1 while i <= 10 do s: s+i;
(%o2)                         done
(%i3) s;
(%o3)                          55
@end example

Note that the condition @code{while i <= 10}
is equivalent to @code{unless i > 10} and also @code{thru 10}.

@example
(%i1) series: 1$
(%i2) term: exp (sin (x))$
(%i3) for p: 1 unless p > 7 do
          (term: diff (term, x)/p, 
           series: series + subst (x=0, term)*x^p)$
(%i4) series;
                  7    6     5    4    2
                 x    x     x    x    x
(%o4)            -- - --- - -- - -- + -- + x + 1
                 90   240   15   8    2
@end example

which gives 8 terms of the Taylor series for @code{e^sin(x)}.

@example
(%i1) poly: 0$
(%i2) for i: 1 thru 5 do
          for j: i step -1 thru 1 do
              poly: poly + i*x^j$
(%i3) poly;
                  5      4       3       2
(%o3)          5 x  + 9 x  + 12 x  + 14 x  + 15 x
(%i4) guess: -3.0$
(%i5) for i: 1 thru 10 do
          (guess: subst (guess, x, 0.5*(x + 10/x)),
           if abs (guess^2 - 10) < 0.00005 then return (guess));
(%o5)                  - 3.162280701754386
@end example

This example computes the negative square root of 10 using the
Newton- Raphson iteration a maximum of 10 times.  Had the convergence
criterion not been met the value returned would have been @code{done}.

Instead of always adding a quantity to the control-variable one
may sometimes wish to change it in some other way for each iteration.
In this case one may use @code{next @var{expression}} instead of
@code{step @var{increment}}.  This will cause the control-variable to be set to
the result of evaluating @var{expression} each time through the loop.

@example
(%i6) for count: 2 next 3*count thru 20 do display (count)$
                            count = 2

                            count = 6

                           count = 18
@end example

@c UGH. DO WE REALLY NEED TO MENTION THIS??
As an alternative to @code{for @var{variable}: @var{value} ...do...}
the syntax @code{for @var{variable} from @var{value} ...do...}  may be
used.  This permits the @code{from @var{value}} to be placed after the
@code{step} or @code{next} value or after the termination condition.
If @code{from @var{value}} is omitted then 1 is used as the initial
value.

Sometimes one may be interested in performing an iteration where
the control-variable is never actually used.  It is thus permissible
to give only the termination conditions omitting the initialization
and updating information as in the following example to compute the
square-root of 5 using a poor initial guess.

@example
(%i1) x: 1000$
(%i2) thru 20 do x: 0.5*(x + 5.0/x)$
(%i3) x;
(%o3)                   2.23606797749979
(%i4) sqrt(5), numer;
(%o4)                   2.23606797749979
@end example

If it is desired one may even omit the termination conditions entirely
and just give @code{do @var{body}} which will continue to evaluate the
@var{body} indefinitely.  In this case the function @code{return}
should be used to terminate execution of the @code{do}.

@example
(%i1) newton (f, x):= ([y, df, dfx], df: diff (f ('x), 'x),
          do (y: ev(df), x: x - f(x)/y, 
              if abs (f (x)) < 5e-6 then return (x)))$
(%i2) sqr (x) := x^2 - 5.0$
(%i3) newton (sqr, 1000);
(%o3)                   2.236068027062195
@end example

@c DUNNO IF WE NEED THIS LEVEL OF DETAIL; THIS ARTICLE IS GETTING PRETTY LONG
(Note that @code{return}, when executed, causes the current value of @code{x} to
be returned as the value of the @code{do}.  The @code{block} is exited and this
value of the @code{do} is returned as the value of the @code{block} because the
@code{do} is the last statement in the block.)

One other form of the @code{do} is available in Maxima.  The syntax is:

@example
for @var{variable} in @var{list} @var{end_tests} do @var{body}
@end example

The elements of @var{list} are any expressions which will successively
be assigned to the @code{variable} on each iteration of the
@var{body}.  The optional termination tests @var{end_tests} can be
used to terminate execution of the @code{do}; otherwise it will
terminate when the @var{list} is exhausted or when a @code{return} is
executed in the @var{body}.  (In fact, @code{list} may be any
non-atomic expression, and successive parts are taken.)

@example
(%i1)  for f in [log, rho, atan] do ldisp(f(1))$
(%t1)                                  0
(%t2)                                rho(1)
                                     %pi
(%t3)                                 ---
                                      4
(%i4) ev(%t3,numer);
(%o4)                             0.78539816
@end example

@opencatbox
@category{Programming}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{errcatch}
@deffn {Function} errcatch (@var{expr_1}, @dots{}, @var{expr_n})

Evaluates @var{expr_1}, @dots{}, @var{expr_n} one by one and
returns @code{[@var{expr_n}]} (a list) if no error occurs.  If an
error occurs in the evaluation of any argument, @code{errcatch} 
prevents the error from propagating and
returns the empty list @code{[]} without evaluating any more arguments.

@code{errcatch}
is useful in @code{batch} files where one suspects an error might occur which
would terminate the @code{batch} if the error weren't caught.

See also @mrefdot{errormsg}

@opencatbox
@category{Programming}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{error}
@deffn  {Function} error (@var{expr_1}, @dots{}, @var{expr_n})
@deffnx {System variable} error

Evaluates and prints @var{expr_1}, @dots{}, @var{expr_n},
and then causes an error return to top level Maxima
or to the nearest enclosing @code{errcatch}.

The variable @code{error} is set to a list describing the error.
The first element of @code{error} is a format string, which merges all the
strings among the arguments @var{expr_1}, @dots{}, @var{expr_n},
and the remaining elements are the values of any non-string arguments.

@code{errormsg()} formats and prints @code{error}.
This is effectively reprinting the most recent error message.

@opencatbox
@category{Programming}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{warning}
@deffn  {Function} warning (@var{expr_1}, @dots{}, @var{expr_n})

Evaluates and prints @var{expr_1}, @dots{}, @var{expr_n},
as a warning message that is formatted in a standard way so a maxima front-end
may be able to recognize the warning and to format it accordingly.

The function @code{warning} always returns false.

@opencatbox
@category{Programming}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{error_size}
@defvr {Option variable} error_size
Default value: 10

@code{error_size} modifies error messages according to the size of expressions
which appear in them.  If the size of an expression (as determined by the Lisp
function @code{ERROR-SIZE}) is greater than @code{error_size}, the expression is
replaced in the message by a symbol, and the symbol is assigned the expression.
The symbols are taken from the list @code{error_syms}.

Otherwise, the expression is smaller than @code{error_size}, and the expression
is displayed in the message.

See also @mref{error} and @mrefdot{error_syms}

Example:
@c OUTPUT GENERATED BY THE FOLLOWING
@c U: (C^D^E + B + A)/(cos(X-1) + 1)$
@c error_size: 20$
@c error ("Example expression is", U);
@c errexp1;
@c error_size: 30$
@c error ("Example expression is", U);

The size of @code{U}, as determined by @code{ERROR-SIZE}, is 24.

@example
(%i1) U: (C^D^E + B + A)/(cos(X-1) + 1)$

(%i2) error_size: 20$

(%i3) error ("Example expression is", U);

Example expression is errexp1
 -- an error.  Quitting.  To debug this try debugmode(true);
(%i4) errexp1;
                            E
                           D
                          C   + B + A
(%o4)                    --------------
                         cos(X - 1) + 1
(%i5) error_size: 30$

(%i6) error ("Example expression is", U);

                         E
                        D
                       C   + B + A
Example expression is --------------
                      cos(X - 1) + 1
 -- an error.  Quitting.  To debug this try debugmode(true);
@end example

@opencatbox
@category{Debugging} @category{Display flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{error_syms}
@defvr {Option variable} error_syms
Default value: @code{[errexp1, errexp2, errexp3]}

In error messages, expressions larger than @code{error_size} are replaced by
symbols, and the symbols are set to the expressions.  The symbols are taken from
the list @code{error_syms}.  The first too-large expression is replaced by
@code{error_syms[1]}, the second by @code{error_syms[2]}, and so on.

If there are more too-large expressions than there are elements of
@code{error_syms}, symbols are constructed automatically, with the @var{n}-th
symbol equivalent to @code{concat ('errexp, @var{n})}.

See also @mref{error} and @mrefdot{error_size}

@opencatbox
@category{Debugging} @category{Display flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{errormsg_fn}
@deffn {Function} errormsg ()

Reprints the most recent error message.
The variable @code{error} holds the message,
and @code{errormsg} formats and prints it.

@opencatbox
@category{Programming}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{errormsg}
@defvr {Option variable} errormsg
Default value: @code{true}

When @code{false} the output of error messages is suppressed.

The option variable @code{errormsg} can not be set in a block to a local 
value.  The global value of @code{errormsg} is always present.

@c ===beg===
@c errormsg;
@c sin(a,b);
@c errormsg:false;
@c sin(a,b);
@c ===end===
@example
@group
(%i1) errormsg;
(%o1)                         true
@end group
@group
(%i2) sin(a,b);
sin: wrong number of arguments.
 -- an error. To debug this try: debugmode(true);
@end group
@group
(%i3) errormsg:false;
(%o3)                         false
@end group
@group
(%i4) sin(a,b);
 -- an error. To debug this try: debugmode(true);
@end group
@end example

The option variable @code{errormsg} can not be set in a block to a local value.

@c ===beg===
@c f(bool):=block([errormsg:bool], print ("value of errormsg is",errormsg))$
@c errormsg:true;
@c f(false);
@c errormsg:false;
@c f(true);
@c ===end===
@example
(%i1) f(bool):=block([errormsg:bool], print ("value of errormsg is",errormsg))$
@group
(%i2) errormsg:true;
(%o2)                         true
@end group
@group
(%i3) f(false);
value of errormsg is true 
(%o3)                         true
@end group
@group
(%i4) errormsg:false;
(%o4)                         false
@end group
@group
(%i5) f(true);
value of errormsg is false 
(%o5)                         false
@end group
@end example

@opencatbox
@category{Programming}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{go}
@deffn {Function} go (@var{tag})

is used within a @code{block} to transfer control to the statement
of the block which is tagged with the argument to @code{go}.  To tag a
statement, precede it by an atomic argument as another statement in
the @code{block}.  For example:

@example
block ([x], x:1, loop, x+1, ..., go(loop), ...)
@end example

The argument to @code{go} must be the name of a tag appearing in the same
@code{block}.  One cannot use @code{go} to transfer to tag in a @code{block}
other than the one containing the @code{go}.

@opencatbox
@category{Programming}
@closecatbox
@end deffn

@c NEEDS CLARIFICATION, EXPANSION, EXAMPLES
@c THIS ITEM IS IMPORTANT

@c -----------------------------------------------------------------------------
@anchor{if}
@deffn {Special operator} if

Represents conditional evaluation.  Various forms of @code{if} expressions are
recognized.

@code{if @var{cond_1} then @var{expr_1} else @var{expr_0}}
eva@-lu@-ates to @var{expr_1} if @var{cond_1} evaluates to @code{true},
otherwise the expression evaluates to @var{expr_0}.

The command @code{if @var{cond_1} then @var{expr_1} elseif @var{cond_2} then
@var{expr_2} elseif ... else @var{expr_0}} evaluates to @var{expr_k} if
@var{cond_k} is @code{true} and all preceding conditions are @code{false}.  If
none of the conditions are @code{true}, the expression evaluates to
@code{expr_0}.

A trailing @code{else false} is assumed if @code{else} is missing.  That is,
the command @code{if @var{cond_1} then @var{expr_1}} is equivalent to
@code{if @var{cond_1} then @var{expr_1} else false}, and the command
@code{if @var{cond_1} then @var{expr_1} elseif ... elseif @var{cond_n} then
@var{expr_n}} is equivalent to @code{if @var{cond_1} then @var{expr_1} elseif 
... elseif @var{cond_n} then @var{expr_n} else false}.

The alternatives @var{expr_0}, @dots{}, @var{expr_n} may be any Maxima
expressions, including nested @code{if} expressions.  The alternatives are
neither simplified nor evaluated unless the corresponding condition is
@code{true}.

The conditions @var{cond_1}, @dots{}, @var{cond_n} are expressions which
potentially or actually evaluate to @code{true} or @code{false}.
When a condition does not actually evaluate to @code{true} or @code{false},
the behavior of @code{if} is governed by the global flag @code{prederror}.
When @code{prederror} is @code{true}, it is an error if any evaluated condition
does not evaluate to @code{true} or @code{false}.  Otherwise, conditions which
do not evaluate to @code{true} or @code{false} are accepted, and the result is
a conditional expression.

Among other elements, conditions may comprise relational and logical operators
as follows.

@c - SEEMS LIKE THIS TABLE WANTS TO BE IN A DISCUSSION OF PREDICATE FUNCTIONS; PRESENT LOCATION IS OK I GUESS
@c - REFORMAT THIS TABLE USING TEXINFO MARKUP (MAYBE)
@example
Operation            Symbol      Type
 
less than            <           relational infix
less than            <=
  or equal to                    relational infix
equality (syntactic) =           relational infix
negation of =        #           relational infix
equality (value)     equal       relational function
negation of equal    notequal    relational function
greater than         >=
  or equal to                    relational infix
greater than         >           relational infix
and                  and         logical infix
or                   or          logical infix
not                  not         logical prefix
@end example

@opencatbox
@category{Programming} @category{Predicate functions}
@closecatbox
@end deffn

@c NEEDS CLARIFICATION
@c THIS ITEM IS IMPORTANT

@c -----------------------------------------------------------------------------
@anchor{map}
@deffn {Function} map (@var{f}, @var{expr_1}, @dots{}, @var{expr_n})

Returns an expression whose leading operator is the same as that of the
expressions @var{expr_1}, @dots{}, @var{expr_n} but whose subparts are the
results of applying @var{f} to the corresponding subparts of the expressions.
@var{f} is either the name of a function of @math{n} arguments or is a
@code{lambda} form of @math{n} arguments.

@code{maperror} - if @code{false} will cause all of the mapping
functions to (1) stop when they finish going down the shortest
@var{expr_i} if not all of the @var{expr_i} are of the same length and
(2) apply @var{f} to [@var{expr_1}, @var{expr_2}, @dots{}]  if the
@var{expr_i} are not all the same type of object.  If @code{maperror}
is @code{true} then an error message will be given in the above two
instances.

One of the uses of this function is to @code{map} a function (e.g.
@code{partfrac}) onto each term of a very large expression where it ordinarily
wouldn't be possible to use the function on the entire expression due to an
exhaustion of list storage space in the course of the computation.

See also @mrefcomma{scanmap} @mrefcomma{maplist} @mrefcomma{outermap} @mref{matrixmap} and @mrefdot{apply}

@c IN THESE EXAMPLES, SPELL OUT WHAT IS THE MAIN OPERATOR 
@c AND SHOW HOW THE RESULT FOLLOWS FROM THE DESCRIPTION STATED IN THE FIRST PARAGRAPH
@example
(%i1) map(f,x+a*y+b*z);
(%o1)                        f(b z) + f(a y) + f(x)
(%i2) map(lambda([u],partfrac(u,x)),x+1/(x^3+4*x^2+5*x+2));
                           1       1        1
(%o2)                     ----- - ----- + -------- + x
                         x + 2   x + 1          2
                                         (x + 1)
(%i3) map(ratsimp, x/(x^2+x)+(y^2+y)/y);
                                      1
(%o3)                            y + ----- + 1
                                    x + 1
(%i4) map("=",[a,b],[-0.5,3]);
(%o4)                          [a = - 0.5, b = 3]


@end example

@opencatbox
@category{Function application}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{mapatom}
@deffn {Function} mapatom (@var{expr})

Returns @code{true} if and only if @var{expr} is treated by the mapping
routines as an atom.  "Mapatoms" are atoms, numbers
(including rational numbers), and subscripted variables.
@c WHAT ARE "THE MAPPING ROUTINES", AND WHY DO THEY HAVE A SPECIALIZED NOTION OF ATOMS ??

@opencatbox
@category{Predicate functions}
@closecatbox
@end deffn

@c NEEDS CLARIFICATION

@c -----------------------------------------------------------------------------
@anchor{maperror}
@defvr {Option variable} maperror
Default value: @code{true}

When @code{maperror} is @code{false}, causes all of the mapping functions,
for example

@example
map (@var{f}, @var{expr_1}, @var{expr_2}, ...)
@end example

to (1) stop when they finish going down the shortest @var{expr_i} if
not all of the @var{expr_i} are of the same length and (2) apply
@var{f} to [@var{expr_1}, @var{expr_2}, @dots{}] if the @var{expr_i} are
not all the same type of object.

If @code{maperror} is @code{true} then an error message
is displayed in the above two instances.

@opencatbox
@category{Function application}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{mapprint}
@defvr {Option variable} mapprint
Default value: @code{true}

When @code{mapprint} is @code{true}, various information messages from
@code{map}, @code{maplist}, and @code{fullmap} are produced in certain
situations.  These include situations where @code{map} would use
@code{apply}, or @code{map} is truncating on the shortest list.

If @code{mapprint} is @code{false}, these messages are suppressed.

@opencatbox
@category{Function application}
@closecatbox
@end defvr

@c NEEDS CLARIFICATION

@c -----------------------------------------------------------------------------
@anchor{maplist}
@deffn {Function} maplist (@var{f}, @var{expr_1}, @dots{}, @var{expr_n})

Returns a list of the applications of @var{f} to the parts of the expressions
@var{expr_1}, @dots{}, @var{expr_n}.  @var{f} is the name of a function, or a
lambda expression.

@code{maplist} differs from @code{map(@var{f}, @var{expr_1}, ..., @var{expr_n})}
which returns an expression with the same main operator as @var{expr_i} has
(except for simplifications and the case where @code{map} does an @code{apply}).

@opencatbox
@category{Function application}
@closecatbox
@end deffn

@c NEEDS CLARIFICATION

@c -----------------------------------------------------------------------------
@anchor{prederror}
@defvr {Option variable} prederror
Default value: @code{false}

When @code{prederror} is @code{true}, an error message is displayed whenever the
predicate of an @code{if} statement or an @code{is} function fails to evaluate
to either @code{true} or @code{false}.

If @code{false}, @code{unknown} is returned
instead in this case.  The @code{prederror: false} mode is not supported in
translated code;
however, @code{maybe} is supported in translated code.

See also @mref{is} and @mrefdot{maybe}

@opencatbox
@category{Programming} @category{Predicate functions}
@closecatbox

@end defvr

@anchor{return}
@deffn {Function} return (@var{value})
May be used to exit explicitly from the current @mrefcomma{block} @mrefcomma{while}
@mref{for} or @mref{do} loop bringing its argument. It therefore can be compared
with the @code{return} statement found in other programming languages but it yields
one difference: In maxima only returns from the current block, not from the entire
function it was called in. In this aspect it more closely resembles the @code{break}
statement from C.

@c ===beg===
@c for i:1 thru 10 do o:i;
@c for i:1 thru 10 do if i=3 then return(i);
@c for i:1 thru 10 do 
@c     (
@c         block([i],
@c             i:3,
@c             return(i)
@c         ), 
@c         return(8)
@c     );
@c block([i],
@c     i:4,
@c     block([o],
@c         o:5,
@c         return(o)
@c     ),
@c     return(i),
@c     return(10)
@c  );
@c ===end===
@example
@group
(%i1) for i:1 thru 10 do o:i;
(%o1)                         done
@end group
@group
(%i2) for i:1 thru 10 do if i=3 then return(i);
(%o2)                           3
@end group
@group
(%i3) for i:1 thru 10 do
    (
        block([i],
            i:3,
            return(i)
        ),
        return(8)
    );
(%o3)                           8
@end group
(%i4) block([i],
    i:4,
    block([o],
        o:5,
        return(o)
    ),
    return(i),
    return(10)
 );
(%o4)                           4
@end example


See also @mrefcomma{for} @mrefcomma{while} @mref{do} and @mref{block}.

@opencatbox
@category{Programming}
@closecatbox
@end deffn

@c NEEDS CLARIFICATION
@anchor{scanmap}
@deffn {Function} scanmap @
@fname{scanmap} (@var{f}, @var{expr}) @
@fname{scanmap} (@var{f}, @var{expr}, bottomup)

Recursively applies @var{f} to @var{expr}, in a top
down manner.  This is most useful when complete factorization is
desired, for example:

@example
(%i1) exp:(a^2+2*a+1)*y + x^2$
(%i2) scanmap(factor,exp);
                                    2      2
(%o2)                         (a + 1)  y + x
@end example

Note the way in which @code{scanmap} applies the given function
@code{factor} to the constituent subexpressions of @var{expr}; if
another form of @var{expr} is presented to @code{scanmap} then the
result may be different.  Thus, @code{%o2} is not recovered when
@code{scanmap} is applied to the expanded form of @code{exp}:

@example
(%i3) scanmap(factor,expand(exp));
                           2                  2
(%o3)                      a  y + 2 a y + y + x
@end example

Here is another example of the way in which @code{scanmap} recursively
applies a given function to all subexpressions, including exponents:

@example
(%i4) expr : u*v^(a*x+b) + c$
(%i5) scanmap('f, expr);
                    f(f(f(a) f(x)) + f(b))
(%o5) f(f(f(u) f(f(v)                      )) + f(c))
@end example

@code{scanmap (@var{f}, @var{expr}, bottomup)} applies @var{f} to @var{expr} in a
bottom-up manner.  E.g., for undefined @code{f},

@example
scanmap(f,a*x+b) ->
   f(a*x+b) -> f(f(a*x)+f(b)) -> f(f(f(a)*f(x))+f(b))
scanmap(f,a*x+b,bottomup) -> f(a)*f(x)+f(b)
    -> f(f(a)*f(x))+f(b) ->
     f(f(f(a)*f(x))+f(b))
@end example

In this case, you get the same answer both
ways.

@opencatbox
@category{Function application}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{throw}
@deffn {Function} throw (@var{expr})

Evaluates @var{expr} and throws the value back to the most recent
@code{catch}.  @code{throw} is used with @code{catch} as a nonlocal return
mechanism.

@opencatbox
@category{Programming}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{outermap}
@deffn {Function} outermap (@var{f}, @var{a_1}, @dots{}, @var{a_n})

Applies the function @var{f} to each one of the elements of the outer product
@var{a_1} cross @var{a_2} @dots{} cross @var{a_n}.

@var{f} is the name of a function of @math{n} arguments or a lambda expression
of @math{n} arguments.  Each argument @var{a_k} may be a list or nested list,
or a matrix, or any other kind of expression.

The @code{outermap} return value is a nested structure.  Let @var{x} be the
return value.  Then @var{x} has the same structure as the first list, nested
list, or matrix argument, @code{@var{x}[i_1]...[i_m]} has the same structure as
the second list, nested list, or matrix argument,
@code{@var{x}[i_1]...[i_m][j_1]...[j_n]} has the same structure as the third
list, nested list, or matrix argument, and so on, where @var{m}, @var{n},
@dots{} are the numbers of indices required to access the elements of each
argument (one for a list, two for a matrix, one or more for a nested list).
Arguments which are not lists or matrices have no effect on the structure of
the return value.

Note that the effect of @code{outermap} is different from that of applying
@var{f} to each one of the elements of the outer product returned by
@code{cartesian_product}.  @code{outermap} preserves the structure of the
arguments in the return value, while @code{cartesian_product} does not.

@code{outermap} evaluates its arguments.

See also @mrefcomma{map} @mrefcomma{maplist} and @mrefdot{apply}
@c CROSS REF OTHER FUNCTIONS HERE ??

Examples:

Elementary examples of @code{outermap}.
To show the argument combinations more clearly, @code{F} is left undefined.

@c ===beg===
@c outermap (F, [a, b, c], [1, 2, 3]);
@c outermap (F, matrix ([a, b], [c, d]), matrix ([1, 2], [3, 4]));
@c outermap (F, [a, b], x, matrix ([1, 2], [3, 4]));
@c outermap (F, [a, b], matrix ([1, 2]), matrix ([x], [y]));
@c outermap ("+", [a, b, c], [1, 2, 3]);
@c ===end===
@example
@group
(%i1) outermap (F, [a, b, c], [1, 2, 3]);
(%o1) [[F(a, 1), F(a, 2), F(a, 3)], [F(b, 1), F(b, 2), F(b, 3)], 
                                     [F(c, 1), F(c, 2), F(c, 3)]]
@end group
@group
(%i2) outermap (F, matrix ([a, b], [c, d]), matrix ([1, 2], [3, 4]));
         [ [ F(a, 1)  F(a, 2) ]  [ F(b, 1)  F(b, 2) ] ]
         [ [                  ]  [                  ] ]
         [ [ F(a, 3)  F(a, 4) ]  [ F(b, 3)  F(b, 4) ] ]
(%o2)    [                                            ]
         [ [ F(c, 1)  F(c, 2) ]  [ F(d, 1)  F(d, 2) ] ]
         [ [                  ]  [                  ] ]
         [ [ F(c, 3)  F(c, 4) ]  [ F(d, 3)  F(d, 4) ] ]
@end group
@group
(%i3) outermap (F, [a, b], x, matrix ([1, 2], [3, 4]));
       [ F(a, x, 1)  F(a, x, 2) ]  [ F(b, x, 1)  F(b, x, 2) ]
(%o3) [[                        ], [                        ]]
       [ F(a, x, 3)  F(a, x, 4) ]  [ F(b, x, 3)  F(b, x, 4) ]
@end group
@group
(%i4) outermap (F, [a, b], matrix ([1, 2]), matrix ([x], [y]));
       [ [ F(a, 1, x) ]  [ F(a, 2, x) ] ]
(%o4) [[ [            ]  [            ] ], 
       [ [ F(a, 1, y) ]  [ F(a, 2, y) ] ]
                              [ [ F(b, 1, x) ]  [ F(b, 2, x) ] ]
                              [ [            ]  [            ] ]]
                              [ [ F(b, 1, y) ]  [ F(b, 2, y) ] ]
@end group
@group
(%i5) outermap ("+", [a, b, c], [1, 2, 3]);
(%o5) [[a + 1, a + 2, a + 3], [b + 1, b + 2, b + 3], 
                                           [c + 1, c + 2, c + 3]]
@end group
@end example

A closer examination of the @code{outermap} return value.  The first, second,
and third arguments are a matrix, a list, and a matrix, respectively.
The return value is a matrix.
Each element of that matrix is a list,
and each element of each list is a matrix.

@c ===beg===
@c arg_1 :  matrix ([a, b], [c, d]);
@c arg_2 : [11, 22];
@c arg_3 : matrix ([xx, yy]);
@c xx_0 : outermap (lambda ([x, y, z], x / y + z), arg_1, 
@c                                                    arg_2, arg_3);
@c xx_1 : xx_0 [1][1];
@c xx_2 : xx_0 [1][1] [1];
@c xx_3 : xx_0 [1][1] [1] [1][1];
@c [op (arg_1), op (arg_2), op (arg_3)];
@c [op (xx_0), op (xx_1), op (xx_2)];
@c ===end===
@example
@group
(%i1) arg_1 :  matrix ([a, b], [c, d]);
                            [ a  b ]
(%o1)                       [      ]
                            [ c  d ]
@end group
@group
(%i2) arg_2 : [11, 22];
(%o2)                       [11, 22]
@end group
@group
(%i3) arg_3 : matrix ([xx, yy]);
(%o3)                      [ xx  yy ]
@end group
(%i4) xx_0 : outermap (lambda ([x, y, z], x / y + z), arg_1,
                                                   arg_2, arg_3);
               [  [      a        a  ]  [      a        a  ]  ]
               [ [[ xx + --  yy + -- ], [ xx + --  yy + -- ]] ]
               [  [      11       11 ]  [      22       22 ]  ]
(%o4)  Col 1 = [                                              ]
               [  [      c        c  ]  [      c        c  ]  ]
               [ [[ xx + --  yy + -- ], [ xx + --  yy + -- ]] ]
               [  [      11       11 ]  [      22       22 ]  ]
                 [  [      b        b  ]  [      b        b  ]  ]
                 [ [[ xx + --  yy + -- ], [ xx + --  yy + -- ]] ]
                 [  [      11       11 ]  [      22       22 ]  ]
         Col 2 = [                                              ]
                 [  [      d        d  ]  [      d        d  ]  ]
                 [ [[ xx + --  yy + -- ], [ xx + --  yy + -- ]] ]
                 [  [      11       11 ]  [      22       22 ]  ]
@group
(%i5) xx_1 : xx_0 [1][1];
           [      a        a  ]  [      a        a  ]
(%o5)     [[ xx + --  yy + -- ], [ xx + --  yy + -- ]]
           [      11       11 ]  [      22       22 ]
@end group
@group
(%i6) xx_2 : xx_0 [1][1] [1];
                      [      a        a  ]
(%o6)                 [ xx + --  yy + -- ]
                      [      11       11 ]
@end group
@group
(%i7) xx_3 : xx_0 [1][1] [1] [1][1];
                                  a
(%o7)                        xx + --
                                  11
@end group
@group
(%i8) [op (arg_1), op (arg_2), op (arg_3)];
(%o8)                  [matrix, [, matrix]
@end group
@group
(%i9) [op (xx_0), op (xx_1), op (xx_2)];
(%o9)                  [matrix, [, matrix]
@end group
@end example

@code{outermap} preserves the structure of the arguments in the return value,
while @code{cartesian_product} does not.

@c ===beg===
@c outermap (F, [a, b, c], [1, 2, 3]);
@c setify (flatten (%));
@c map (lambda ([L], apply (F, L)), 
@c                      cartesian_product ({a, b, c}, {1, 2, 3}));
@c is (equal (%, %th (2)));
@c ===end===
@example
@group
(%i1) outermap (F, [a, b, c], [1, 2, 3]);
(%o1) [[F(a, 1), F(a, 2), F(a, 3)], [F(b, 1), F(b, 2), F(b, 3)], 
                                     [F(c, 1), F(c, 2), F(c, 3)]]
@end group
@group
(%i2) setify (flatten (%));
(%o2) @{F(a, 1), F(a, 2), F(a, 3), F(b, 1), F(b, 2), F(b, 3), 
                                       F(c, 1), F(c, 2), F(c, 3)@}
@end group
@group
(%i3) map (lambda ([L], apply (F, L)),
                     cartesian_product (@{a, b, c@}, @{1, 2, 3@}));
(%o3) @{F(a, 1), F(a, 2), F(a, 3), F(b, 1), F(b, 2), F(b, 3), 
                                       F(c, 1), F(c, 2), F(c, 3)@}
@end group
@group
(%i4) is (equal (%, %th (2)));
(%o4)                         true
@end group
@end example

@opencatbox
@category{Function application}
@closecatbox
@end deffn

