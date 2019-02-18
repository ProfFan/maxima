@c -*- Mode: texinfo -*-
@menu
* Functions and Variables for Limits::
@end menu

@c -----------------------------------------------------------------------------
@node Functions and Variables for Limits,  , Limits, Limits
@section Functions and Variables for Limits
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
m4_setcat(Limits)
@anchor{lhospitallim}
@c @defvr {Option variable} lhospitallim
m4_defvr({Option variable}, lhospitallim)
Default value: 4

@code{lhospitallim} is the maximum number of times L'Hospital's
rule is used in @mref{limit}.  This prevents infinite looping in cases like
@code{limit (cot(x)/csc(x), x, 0)}.

@c @opencatbox
@c @category{Limits}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{limit}
@c @deffn  {Function} limit @
m4_deffn( {Function}, limit, <<<>>>) @
@fname{limit} (@var{expr}, @var{x}, @var{val}, @var{dir}) @
@fname{limit} (@var{expr}, @var{x}, @var{val}) @
@fname{limit} (@var{expr})

Computes the limit of @var{expr} as the real variable @var{x} approaches the
value @var{val} from the direction @var{dir}.  @var{dir} may have the value
@code{plus} for a limit from above, @code{minus} for a limit from below, or
may be omitted (implying a two-sided limit is to be computed).

@code{limit} uses the following special symbols: @code{inf} (positive infinity)
and @mref{minf} (negative infinity).  On output it may also use @mref{und}
(undefined), @mref{ind} (indefinite but bounded) and @mref{infinity} (complex
infinity).

@code{infinity} (complex infinity) is returned when the limit of
the absolute value of the expression is positive infinity, but
the limit of the expression itself is not positive infinity or
negative infinity.  This includes cases where the limit of the
complex argument is a constant, as in @code{limit(log(x), x, minf)}, 
cases where the complex argument oscillates, as in
@code{limit((-2)^x, x, inf)}, and cases where the complex
argument is different for either side of a two-sided limit, as in
@code{limit(1/x, x, 0)} and @code{limit(log(x), x, 0)}.

@mref{lhospitallim} is the maximum number of times L'Hospital's rule
is used in @code{limit}.  This prevents infinite looping in cases like
@code{limit (cot(x)/csc(x), x, 0)}.

@mref{tlimswitch} when true will allow the @code{limit} command to use
Taylor series expansion when necessary.

@mref{limsubst} prevents @code{limit} from attempting substitutions on
unknown forms.  This is to avoid bugs like @code{limit (f(n)/f(n+1), n, inf)}
giving 1.  Setting @code{limsubst} to @code{true} will allow such
substitutions.

@code{limit} with one argument is often called upon to simplify constant
expressions, for example, @code{limit (inf-1)}.

@c MERGE EXAMPLES INTO THIS FILE
@code{example (limit)} displays some examples.

For the method see Wang, P., "Evaluation of Definite Integrals by Symbolic
Manipulation", Ph.D. thesis, MAC TR-92, October 1971.

@c @opencatbox
@c @category{Limits}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{limsubst}
@c @defvr {Option variable} limsubst
m4_defvr({Option variable}, limsubst)
Default value: @code{false}

prevents @mref{limit} from attempting substitutions on unknown forms.  This is
to avoid bugs like @code{limit (f(n)/f(n+1), n, inf)} giving 1.  Setting
@code{limsubst} to @code{true} will allow such substitutions.

@c @opencatbox
@c @category{Limits}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{tlimit}
@c @deffn  {Function} tlimit @
m4_deffn( {Function}, tlimit, <<<>>>) @
@fname{tlimit} (@var{expr}, @var{x}, @var{val}, @var{dir}) @
@fname{tlimit} (@var{expr}, @var{x}, @var{val}) @
@fname{tlimit} (@var{expr})

Take the limit of the Taylor series expansion of @code{expr} in @code{x}
at @code{val} from direction @code{dir}.

@c @opencatbox
@c @category{Limits}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{tlimswitch}
@c @defvr {Option variable} tlimswitch
m4_defvr({Option variable}, tlimswitch)
Default value: @code{true}

When @code{tlimswitch} is @code{true}, the @mref{limit} command will use a
Taylor series expansion if the limit of the input expression cannot be computed
directly.  This allows evaluation of limits such as
@code{limit(x/(x-1)-1/log(x),x,1,plus)}.  When @code{tlimswitch} is @code{false}
and the limit of input expression cannot be computed directly, @code{limit} will
return an unevaluated limit expression.

@c @opencatbox
@c @category{Limits}
@c @closecatbox
@c @end defvr
m4_end_defvr()

