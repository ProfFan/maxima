@c -*- Mode: texinfo -*-
@menu
* Introduction to stats::
* Functions and Variables for inference_result::
* Functions and Variables for stats::
* Functions and Variables for special distributions::
@end menu

@node Introduction to stats, Functions and Variables for inference_result, Top, Top
@section Introduction to stats


Package @code{stats} contains a set of classical statistical inference and
hypothesis testing procedures.

All these functions return an @code{inference_result} Maxima object which contains
the necessary results for population inferences and decision making.

Global variable @code{stats_numer} controls whether results are given in 
floating point or symbolic and rational format; its default value is @code{true}
and results are returned in floating point format.

Package @code{descriptive} contains some utilities to manipulate data structures
(lists and matrices); for example, to extract subsamples. It also contains some
examples on how to use package @code{numericalio} to read data from plain text
files. See @code{descriptive} and @code{numericalio} for more details.

Package @code{stats} loads packages @code{descriptive}, @code{distrib} and
@code{inference_result}.

For comments, bugs or suggestions, please contact the author at

@var{'mario AT edu DOT xunta DOT es'}.

@opencatbox
@category{Statistical inference} @category{Share packages} @category{Package stats}
@closecatbox

@node Functions and Variables for inference_result, Functions and Variables for stats, Introduction to stats, Top
@section Functions and Variables for inference_result

@anchor{inference_result}
@deffn {Function} inference_result (@var{title}, @var{values}, @var{numbers})

Constructs an @code{inference_result} object of the type returned by the
stats functions. Argument @var{title} is a
string with the name of the procedure; @var{values} is a list with
elements of the form @code{symbol = value} and @var{numbers} is a list
with positive integer numbers ranging from one to @code{length(@var{values})},
indicating which values will be shown by default.

Example:

This is a simple example showing results concerning a rectangle. The title of
this object is the string @code{"Rectangle"}, it stores five results, named
@code{'base}, @code{'height}, @code{'diagonal}, @code{'area},
and @code{'perimeter}, but only the first, second, fifth, and fourth
will be displayed. The @code{'diagonal} is stored in this object, but it is
not displayed; to access its value, make use of function @code{take_inference}.

@c ===beg===
@c load ("inference_result")$
@c b: 3$ h: 2$
@c inference_result("Rectangle",
@c                  ['base=b,
@c                   'height=h,
@c                   'diagonal=sqrt(b^2+h^2),
@c                   'area=b*h,
@c                   'perimeter=2*(b+h)],
@c                  [1,2,5,4] );
@c take_inference('diagonal,%);
@c ===end===
@example
(%i1) load(inference_result)$
(%i2) b: 3$ h: 2$
(%i3) inference_result("Rectangle",
                        ['base=b,
                         'height=h,
                         'diagonal=sqrt(b^2+h^2),
                         'area=b*h,
                         'perimeter=2*(b+h)],
                        [1,2,5,4] );
                        |   Rectangle
                        |
                        |    base = 3
                        |
(%o3)                   |   height = 2
                        |
                        | perimeter = 10
                        |
                        |    area = 6
(%i4) take_inference('diagonal,%);
(%o4)                        sqrt(13)
@end example

See also @mrefdot{take_inference}

@opencatbox
@category{Package stats}
@closecatbox

@end deffn






@anchor{inferencep}
@deffn {Function} inferencep (@var{obj})

Returns @code{true} or @code{false}, depending on whether @var{obj} is an
@code{inference_result} object or not.

@opencatbox
@category{Package stats}
@closecatbox

@end deffn






@anchor{items_inference}
@deffn {Function} items_inference (@var{obj})

Returns a list with the names of the items stored in @var{obj}, which must
be an @code{inference_result} object.

Example:

The @code{inference_result} object stores two values, named @code{'pi} and @code{'e},
but only the second is displayed. The @code{items_inference} function returns the names
of all items, no matter they are displayed or not.

@c ===beg===
@c load ("inference_result")$
@c inference_result("Hi", ['pi=%pi,'e=%e],[2]);
@c items_inference(%);
@c ===end===
@example
(%i1) load(inference_result)$
(%i2) inference_result("Hi", ['pi=%pi,'e=%e],[2]);
                            |   Hi
(%o2)                       |
                            | e = %e
(%i3) items_inference(%);
(%o3)                        [pi, e]
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn







@anchor{take_inference}
@deffn {Function} take_inference @
@fname{take_inference} (@var{n}, @var{obj}) @
@fname{take_inference} (@var{name}, @var{obj}) @
@fname{take_inference} (@var{list}, @var{obj})

Returns the @var{n}-th value stored in @var{obj} if @var{n} is a positive integer,
or the item named @var{name} if this is the name of an item. If the first
argument is a list of numbers and/or symbols, function @code{take_inference} returns
a list with the corresponding results.

Example:

Given an @code{inference_result} object, function @code{take_inference} is
called in order to extract some information stored in it.

@c ===beg===
@c load ("inference_result")$
@c b: 3$ h: 2$
@c sol:inference_result("Rectangle",
@c                      ['base=b,
@c                       'height=h,
@c                       'diagonal=sqrt(b^2+h^2),
@c                       'area=b*h,
@c                       'perimeter=2*(b+h)],
@c                      [1,2,5,4] );
@c take_inference('base,sol);
@c take_inference(5,sol);
@c take_inference([1,'diagonal],sol);
@c take_inference(items_inference(sol),sol);
@c ===end===
@example
(%i1) load(inference_result)$
(%i2) b: 3$ h: 2$
(%i3) sol: inference_result("Rectangle",
                            ['base=b,
                             'height=h,
                             'diagonal=sqrt(b^2+h^2),
                             'area=b*h,
                             'perimeter=2*(b+h)],
                            [1,2,5,4] );
                        |   Rectangle
                        |
                        |    base = 3
                        |
(%o3)                   |   height = 2
                        |
                        | perimeter = 10
                        |
                        |    area = 6
(%i4) take_inference('base,sol);
(%o4)                           3
(%i5) take_inference(5,sol);
(%o5)                          10
(%i6) take_inference([1,'diagonal],sol);
(%o6)                     [3, sqrt(13)]
(%i7) take_inference(items_inference(sol),sol);
(%o7)                [3, 2, sqrt(13), 6, 10]
@end example

See also @mrefcomma{inference_result} and @mrefdot{take_inference}

@opencatbox
@category{Package stats}
@closecatbox

@end deffn









@node Functions and Variables for stats, Functions and Variables for special distributions, Functions and Variables for inference_result, Top
@section Functions and Variables for stats


@anchor{stats_numer}
@defvr {Option variable} stats_numer
Default value: @code{true}

If @code{stats_numer} is @code{true}, inference statistical functions 
return their results in floating point numbers. If it is @code{false},
results are given in symbolic and rational format.

@opencatbox
@category{Package stats} @category{Numerical evaluation}
@closecatbox

@end defvr



@anchor{test_mean}
@deffn {Function} test_mean @
@fname{test_mean} (@var{x}) @
@fname{test_mean} (@var{x}, @var{options} ...)

This is the mean @var{t}-test. Argument @var{x} is a list or a column matrix
containing a one dimensional sample. It also performs an asymptotic test
based on the @i{Central Limit Theorem} if option @code{'asymptotic} is
@code{true}.

Options:

@itemize @bullet

@item
@code{'mean}, default @code{0}, is the mean value to be checked.

@item
@code{'alternative}, default @code{'twosided}, is the alternative hypothesis;
valid values are: @code{'twosided}, @code{'greater} and @code{'less}.

@item
@code{'dev}, default @code{'unknown}, this is the value of the standard deviation when it is 
known; valid values are: @code{'unknown} or a positive expression.

@item
@code{'conflevel}, default @code{95/100}, confidence level for the confidence interval; it must
be an expression which takes a value in (0,1).

@item
@code{'asymptotic}, default @code{false}, indicates whether it performs an exact @var{t}-test or
an asymptotic one based on the @i{Central Limit Theorem};
valid values are @code{true} and @code{false}.

@end itemize

The output of function @code{test_mean} is an @code{inference_result} Maxima object
showing the following results:

@enumerate

@item
@code{'mean_estimate}: the sample mean.

@item
@code{'conf_level}: confidence level selected by the user.

@item
@code{'conf_interval}: confidence interval for the population mean.

@item
@code{'method}: inference procedure.

@item
@code{'hypotheses}: null and alternative hypotheses to be tested.

@item
@code{'statistic}: value of the sample statistic used for testing the null hypothesis.

@item
@code{'distribution}: distribution of the sample statistic, together with its parameter(s).

@item
@code{'p_value}: @math{p}-value of the test.

@end enumerate

Examples:

Performs an exact @var{t}-test with unknown variance. The null hypothesis
is @math{H_0: mean=50} against the one sided alternative @math{H_1: mean<50};
according to the results, the @math{p}-value is too great, there are no
evidence for rejecting @math{H_0}.

@c ===beg===
@c load ("stats")$
@c data: [78,64,35,45,45,75,43,74,42,42]$
@c test_mean(data,'conflevel=0.9,'alternative='less,'mean=50);
@c ===end===
@example
(%i1) load("stats")$
(%i2) data: [78,64,35,45,45,75,43,74,42,42]$
(%i3) test_mean(data,'conflevel=0.9,'alternative='less,'mean=50);
          |                 MEAN TEST
          |
          |            mean_estimate = 54.3
          |
          |              conf_level = 0.9
          |
          | conf_interval = [minf, 61.51314273502712]
          |
(%o3)     |  method = Exact t-test. Unknown variance.
          |
          | hypotheses = H0: mean = 50 , H1: mean < 50
          |
          |       statistic = .8244705235071678
          |
          |       distribution = [student_t, 9]
          |
          |        p_value = .7845100411786889
@end example

This time Maxima performs an asymptotic test, based on the @i{Central Limit Theorem}.
The null hypothesis is @math{H_0: equal(mean, 50)} against the two sided alternative @math{H_1: not equal(mean, 50)};
according to the results, the @math{p}-value is very small, @math{H_0} should be rejected in
favor of the alternative @math{H_1}. Note that, as indicated by the @code{Method} component,
this procedure should be applied to large samples.

@c ===beg===
@c load ("stats")$
@c test_mean([36,118,52,87,35,256,56,178,57,57,89,34,25,98,35,
@c         98,41,45,198,54,79,63,35,45,44,75,42,75,45,45,
@c         45,51,123,54,151],
@c         'asymptotic=true,'mean=50);
@c ===end===
@example
(%i1) load("stats")$
(%i2) test_mean([36,118,52,87,35,256,56,178,57,57,89,34,25,98,35,
              98,41,45,198,54,79,63,35,45,44,75,42,75,45,45,
              45,51,123,54,151],
              'asymptotic=true,'mean=50);
          |                       MEAN TEST
          |
          |           mean_estimate = 74.88571428571429
          |
          |                   conf_level = 0.95
          |
          | conf_interval = [57.72848600856194, 92.04294256286663]
          |
(%o2)     |    method = Large sample z-test. Unknown variance.
          |
          |       hypotheses = H0: mean = 50 , H1: mean # 50
          |
          |             statistic = 2.842831192874313
          |
          |             distribution = [normal, 0, 1]
          |
          |             p_value = .004471474652002261
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn







@anchor{test_means_difference}
@deffn {Function} test_means_difference @
@fname{test_means_difference} (@var{x1}, @var{x2}) @
@fname{test_means_difference} (@var{x1}, @var{x2}, @var{options} ...)

This is the difference of means @var{t}-test for two samples.
Arguments @var{x1} and @var{x2} are lists or column matrices
containing two independent samples. In case of different unknown variances
(see options @code{'dev1}, @code{'dev2} and @code{'varequal} bellow),
the degrees of freedom are computed by means of the Welch approximation.
It also performs an asymptotic test
based on the @i{Central Limit Theorem} if option @code{'asymptotic} is
set to @code{true}.

Options:

@itemize @bullet

@item

@item
@code{'alternative}, default @code{'twosided}, is the alternative hypothesis;
valid values are: @code{'twosided}, @code{'greater} and @code{'less}.

@item
@code{'dev1}, default @code{'unknown}, this is the value of the standard deviation
of the @var{x1} sample when it is known; valid values are: @code{'unknown} or a positive expression.

@item
@code{'dev2}, default @code{'unknown}, this is the value of the standard deviation
of the @var{x2} sample when it is known; valid values are: @code{'unknown} or a positive expression.

@item
@code{'varequal}, default @code{false}, whether variances should be considered to be equal or not;
this option takes effect only when @code{'dev1} and/or @code{'dev2} are  @code{'unknown}.

@item
@code{'conflevel}, default @code{95/100}, confidence level for the confidence interval; it must
be an expression which takes a value in (0,1).

@item
@code{'asymptotic}, default @code{false}, indicates whether it performs an exact @var{t}-test or
an asymptotic one based on the @i{Central Limit Theorem};
valid values are @code{true} and @code{false}.

@end itemize

The output of function @code{test_means_difference} is an @code{inference_result} Maxima object
showing the following results:

@enumerate

@item
@code{'diff_estimate}: the difference of means estimate.

@item
@code{'conf_level}: confidence level selected by the user.

@item
@code{'conf_interval}: confidence interval for the difference of means.

@item
@code{'method}: inference procedure.

@item
@code{'hypotheses}: null and alternative hypotheses to be tested.

@item
@code{'statistic}: value of the sample statistic used for testing the null hypothesis.

@item
@code{'distribution}: distribution of the sample statistic, together with its parameter(s).

@item
@code{'p_value}: @math{p}-value of the test.

@end enumerate

Examples:

The equality of means is tested with two small samples @var{x} and @var{y},
against the alternative @math{H_1: m_1>m_2}, being @math{m_1} and @math{m_2}
the populations means; variances are unknown and supposed to be different.

@c equivalent code for R:
@c x <- c(20.4,62.5,61.3,44.2,11.1,23.7)
@c y <- c(1.2,6.9,38.7,20.4,17.2)
@c t.test(x,y,alternative="greater")

@c ===beg===
@c load ("stats")$
@c x: [20.4,62.5,61.3,44.2,11.1,23.7]$
@c y: [1.2,6.9,38.7,20.4,17.2]$
@c test_means_difference(x,y,'alternative='greater);
@c ===end===
@example
(%i1) load("stats")$
(%i2) x: [20.4,62.5,61.3,44.2,11.1,23.7]$
(%i3) y: [1.2,6.9,38.7,20.4,17.2]$
(%i4) test_means_difference(x,y,'alternative='greater);
            |              DIFFERENCE OF MEANS TEST
            |
            |         diff_estimate = 20.31999999999999
            |
            |                 conf_level = 0.95
            |
            |    conf_interval = [- .04597417812882298, inf]
            |
(%o4)       |        method = Exact t-test. Welch approx.
            |
            | hypotheses = H0: mean1 = mean2 , H1: mean1 > mean2
            |
            |           statistic = 1.838004300728477
            |
            |    distribution = [student_t, 8.62758740184604]
            |
            |            p_value = .05032746527991905
@end example

The same test as before, but now variances are supposed to be
equal.

@c equivalent code for R:
@c x <- c(20.4,62.5,61.3,44.2,11.1,23.7)
@c y <- c(1.2,6.9,38.7,20.4,17.2)
@c t.test(x,y,var.equal=T,alternative="greater")

@c ===beg===
@c load ("stats")$
@c x: [20.4,62.5,61.3,44.2,11.1,23.7]$
@c y: [1.2,6.9,38.7,20.4,17.2]$
@c test_means_difference(x,y,'alternative='greater,
@c                                                  'varequal=true);
@c ===end===
@example
(%i1) load("stats")$
(%i2) x: [20.4,62.5,61.3,44.2,11.1,23.7]$
(%i3) y: matrix([1.2],[6.9],[38.7],[20.4],[17.2])$
(%i4) test_means_difference(x,y,'alternative='greater,
                                                 'varequal=true);
            |              DIFFERENCE OF MEANS TEST
            |
            |         diff_estimate = 20.31999999999999
            |
            |                 conf_level = 0.95
            |
            |     conf_interval = [- .7722627696897568, inf]
            |
(%o4)       |   method = Exact t-test. Unknown equal variances
            |
            | hypotheses = H0: mean1 = mean2 , H1: mean1 > mean2
            |
            |           statistic = 1.765996124515009
            |
            |           distribution = [student_t, 9]
            |
            |            p_value = .05560320992529344
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn

@anchor{test_variance}
@deffn {Function} test_variance @
@fname{test_variance} (@var{x}) @
@fname{test_variance} (@var{x}, @var{options}, ...)

This is the variance @var{chi^2}-test. Argument @var{x} is a list or a column matrix
containing a one dimensional sample taken from a normal population.

Options:

@itemize @bullet

@item
@code{'mean}, default @code{'unknown}, is the population's mean, when it is known.

@item
@code{'alternative}, default @code{'twosided}, is the alternative hypothesis;
valid values are: @code{'twosided}, @code{'greater} and @code{'less}.

@item
@code{'variance}, default @code{1}, this is the variance value (positive) to be checked.

@item
@code{'conflevel}, default @code{95/100}, confidence level for the confidence interval; it must
be an expression which takes a value in (0,1).

@end itemize

The output of function @code{test_variance} is an @code{inference_result} Maxima object
showing the following results:

@enumerate

@item
@code{'var_estimate}: the sample variance.

@item
@code{'conf_level}: confidence level selected by the user.

@item
@code{'conf_interval}: confidence interval for the population variance.

@item
@code{'method}: inference procedure.

@item
@code{'hypotheses}: null and alternative hypotheses to be tested.

@item
@code{'statistic}: value of the sample statistic used for testing the null hypothesis.

@item
@code{'distribution}: distribution of the sample statistic, together with its parameter.

@item
@code{'p_value}: @math{p}-value of the test.

@end enumerate

Examples:

It is tested whether the variance of a population with unknown mean
is equal to or greater than 200.

@c ===beg===
@c load ("stats")$
@c x: [203,229,215,220,223,233,208,228,20]$
@c test_variance(x,'alternative='greater,'variance=200);
@c ===end===
@example
(%i1) load("stats")$
(%i2) x: [203,229,215,220,223,233,208,228,209]$
(%i3) test_variance(x,'alternative='greater,'variance=200);
             |                  VARIANCE TEST
             |
             |              var_estimate = 110.75
             |
             |                conf_level = 0.95
             |
             |     conf_interval = [57.13433376937479, inf]
             |
(%o3)        | method = Variance Chi-square test. Unknown mean.
             |
             |    hypotheses = H0: var = 200 , H1: var > 200
             |
             |                 statistic = 4.43
             |
             |             distribution = [chi2, 8]
             |
             |           p_value = .8163948512777689
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn







@anchor{test_variance_ratio}
@deffn {Function} test_variance_ratio @
@fname{test_variance_ratio} (@var{x1}, @var{x2}) @
@fname{test_variance_ratio} (@var{x1}, @var{x2}, @var{options} ...)

This is the variance ratio @var{F}-test for two normal populations.
Arguments @var{x1} and @var{x2} are lists or column matrices
containing two independent samples.

Options:

@itemize @bullet

@item
@code{'alternative}, default @code{'twosided}, is the alternative hypothesis;
valid values are: @code{'twosided}, @code{'greater} and @code{'less}.

@item
@code{'mean1}, default @code{'unknown}, when it is known, this is the mean of
the population from which @var{x1} was taken.

@item
@code{'mean2}, default @code{'unknown}, when it is known, this is the mean of
the population from which @var{x2} was taken.

@item
@code{'conflevel}, default @code{95/100}, confidence level for the confidence interval of the
ratio; it must be an expression which takes a value in (0,1).

@end itemize

The output of function @code{test_variance_ratio} is an @code{inference_result} Maxima object
showing the following results:

@enumerate

@item
@code{'ratio_estimate}: the sample variance ratio.

@item
@code{'conf_level}: confidence level selected by the user.

@item
@code{'conf_interval}: confidence interval for the variance ratio.

@item
@code{'method}: inference procedure.

@item
@code{'hypotheses}: null and alternative hypotheses to be tested.

@item
@code{'statistic}: value of the sample statistic used for testing the null hypothesis.

@item
@code{'distribution}: distribution of the sample statistic, together with its parameters.

@item
@code{'p_value}: @math{p}-value of the test.

@end enumerate


Examples:

The equality of the variances of two normal populations is checked
against the alternative that the first is greater than the second.

@c equivalent code for R:
@c x <- c(20.4,62.5,61.3,44.2,11.1,23.7)
@c y <- c(1.2,6.9,38.7,20.4,17.2)
@c var.test(x,y,alternative="greater")

@c ===beg===
@c load ("stats")$
@c x: [20.4,62.5,61.3,44.2,11.1,23.7]$
@c y: [1.2,6.9,38.7,20.4,17.2]$
@c test_variance_ratio(x,y,'alternative='greater);
@c ===end===
@example
(%i1) load("stats")$
(%i2) x: [20.4,62.5,61.3,44.2,11.1,23.7]$
(%i3) y: [1.2,6.9,38.7,20.4,17.2]$
(%i4) test_variance_ratio(x,y,'alternative='greater);
              |              VARIANCE RATIO TEST
              |
              |       ratio_estimate = 2.316933391522034
              |
              |               conf_level = 0.95
              |
              |    conf_interval = [.3703504689507268, inf]
              |
(%o4)         | method = Variance ratio F-test. Unknown means.
              |
              | hypotheses = H0: var1 = var2 , H1: var1 > var2
              |
              |         statistic = 2.316933391522034
              |
              |            distribution = [f, 5, 4]
              |
              |          p_value = .2179269692254457
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn




@anchor{test_proportion}
@deffn {Function} test_proportion @
@fname{test_proportion} (@var{x}, @var{n}) @
@fname{test_proportion} (@var{x}, @var{n}, @var{options} ...)

Inferences on a proportion. Argument @var{x} is the number of successes
in @var{n} trials in a Bernoulli experiment with unknown probability.

Options:

@itemize @bullet

@item
@code{'proportion}, default @code{1/2}, is the value of the proportion to be checked.

@item
@code{'alternative}, default @code{'twosided}, is the alternative hypothesis;
valid values are: @code{'twosided}, @code{'greater} and @code{'less}.

@item
@code{'conflevel}, default @code{95/100}, confidence level for the confidence interval; it must
be an expression which takes a value in (0,1).

@item
@code{'asymptotic}, default @code{false}, indicates whether it performs an exact test
based on the binomial distribution, or an asymptotic one based on the @i{Central Limit Theorem};
valid values are @code{true} and @code{false}.

@item
@code{'correct}, default @code{true}, indicates whether Yates correction is applied or not.

@end itemize

The output of function @code{test_proportion} is an @code{inference_result} Maxima object
showing the following results:

@enumerate

@item
@code{'sample_proportion}: the sample proportion.

@item
@code{'conf_level}: confidence level selected by the user.

@item
@code{'conf_interval}: Wilson confidence interval for the proportion.

@item
@code{'method}: inference procedure.

@item
@code{'hypotheses}: null and alternative hypotheses to be tested.

@item
@code{'statistic}: value of the sample statistic used for testing the null hypothesis.

@item
@code{'distribution}: distribution of the sample statistic, together with its parameters.

@item
@code{'p_value}: @math{p}-value of the test.

@end enumerate

Examples:

Performs an exact test. The null hypothesis
is @math{H_0: p=1/2} against the one sided alternative @math{H_1: p<1/2}.

@c ===beg===
@c load ("stats")$
@c test_proportion(45, 103, alternative = less);
@c ===end===
@example
(%i1) load("stats")$
(%i2) test_proportion(45, 103, alternative = less);
         |            PROPORTION TEST              
         |                                         
         | sample_proportion = .4368932038834951   
         |                                         
         |           conf_level = 0.95             
         |                                         
         | conf_interval = [0, 0.522714149150231]  
         |                                         
(%o2)    |     method = Exact binomial test.       
         |                                         
         | hypotheses = H0: p = 0.5 , H1: p < 0.5  
         |                                         
         |             statistic = 45              
         |                                         
         |  distribution = [binomial, 103, 0.5]    
         |                                         
         |      p_value = .1184509388901454 
@end example

A two sided asymptotic test. Confidence level is 99/100.

@c ===beg===
@c load ("stats")$
@c fpprintprec:7$
@c test_proportion(45, 103, 
@c               conflevel = 99/100, asymptotic=true);
@c ===end===
@example
(%i1) load("stats")$
(%i2) fpprintprec:7$
(%i3) test_proportion(45, 103, 
                  conflevel = 99/100, asymptotic=true);
      |                 PROPORTION TEST                  
      |                                                  
      |           sample_proportion = .43689             
      |                                                  
      |                conf_level = 0.99                 
      |                                                  
      |        conf_interval = [.31422, .56749]          
      |                                                  
(%o3) | method = Asympthotic test with Yates correction.
      |                                                  
      |     hypotheses = H0: p = 0.5 , H1: p # 0.5       
      |                                                  
      |               statistic = .43689                 
      |                                                  
      |      distribution = [normal, 0.5, .048872]       
      |                                                  
      |                p_value = .19662
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn





@anchor{test_proportions_difference}
@deffn {Function} test_proportions_difference @
@fname{test_proportions_difference} (@var{x1}, @var{n1}, @var{x2}, @var{n2}) @
@fname{test_proportions_difference} (@var{x1}, @var{n1}, @var{x2}, @var{n2}, @var{options} @dots{})

Inferences on the difference of two proportions. Argument @var{x1} is the number of successes
in @var{n1} trials in a Bernoulli experiment in the first population, and @var{x2} and @var{n2}
are the corresponding values in the second population. Samples are independent and the test
is asymptotic.

Options:

@itemize @bullet

@item
@code{'alternative}, default @code{'twosided}, is the alternative hypothesis;
valid values are: @code{'twosided} (@code{p1 # p2}), @code{'greater} (@code{p1 > p2})
and @code{'less} (@code{p1 < p2}).

@item
@code{'conflevel}, default @code{95/100}, confidence level for the confidence interval; it must
be an expression which takes a value in (0,1).

@item
@code{'correct}, default @code{true}, indicates whether Yates correction is applied or not.

@end itemize

The output of function @code{test_proportions_difference} is an @code{inference_result} Maxima object
showing the following results:

@enumerate

@item
@code{'proportions}: list with the two sample proportions.

@item
@code{'conf_level}: confidence level selected by the user.

@item
@code{'conf_interval}: Confidence interval for the difference of proportions @code{p1 - p2}.

@item
@code{'method}: inference procedure and warning message in case of any of the samples sizes
is less than 10.

@item
@code{'hypotheses}: null and alternative hypotheses to be tested.

@item
@code{'statistic}: value of the sample statistic used for testing the null hypothesis.

@item
@code{'distribution}: distribution of the sample statistic, together with its parameters.

@item
@code{'p_value}: @math{p}-value of the test.

@end enumerate

Examples:

A machine produced 10 defective articles in a batch of 250.
After some maintenance work, it produces 4 defective in a batch of 150.
In order to know if the machine has improved, we test the null
hypothesis @code{H0:p1=p2}, against the alternative @code{H0:p1>p2},
where @code{p1} and @code{p2} are the probabilities for one produced
article to be defective before and after maintenance. According to
the p value, there is not enough evidence to accept the alternative.

@c ===beg===
@c load ("stats")$
@c fpprintprec:7$
@c test_proportions_difference(10, 250, 4, 150,
@c                             alternative = greater);
@c ===end===
@example
(%i1) load("stats")$
(%i2) fpprintprec:7$
(%i3) test_proportions_difference(10, 250, 4, 150,
                                alternative = greater);
      |       DIFFERENCE OF PROPORTIONS TEST         
      |                                              
      |       proportions = [0.04, .02666667]        
      |                                              
      |              conf_level = 0.95               
      |                                              
      |      conf_interval = [- .02172761, 1]        
      |                                              
(%o3) | method = Asymptotic test. Yates correction.  
      |                                              
      |   hypotheses = H0: p1 = p2 , H1: p1 > p2     
      |                                              
      |            statistic = .01333333             
      |                                              
      |    distribution = [normal, 0, .01898069]     
      |                                              
      |             p_value = .2411936 
@end example

Exact standard deviation of the asymptotic normal
distribution when the data are unknown.

@c ===beg===
@c load(stats)$
@c stats_numer: false$
@c sol: test_proportions_difference(x1,n1,x2,n2)$
@c last(take_inference('distribution,sol));
@c ===end===
@example
(%i1) load("stats")$
(%i2) stats_numer: false$
(%i3) sol: test_proportions_difference(x1,n1,x2,n2)$
(%i4) last(take_inference('distribution,sol));
               1    1                  x2 + x1
              (-- + --) (x2 + x1) (1 - -------)
               n2   n1                 n2 + n1
(%o4)    sqrt(---------------------------------)
                           n2 + n1
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn

@anchor{test_sign}
@deffn {Function} test_sign @
@fname{test_sign} (@var{x}) @
@fname{test_sign} (@var{x}, @var{options} @dots{})

This is the non parametric sign test for the median of a continuous population.
Argument @var{x} is a list or a column matrix containing a one dimensional sample.

Options:

@itemize @bullet

@item
@code{'alternative}, default @code{'twosided}, is the alternative hypothesis;
valid values are: @code{'twosided}, @code{'greater} and @code{'less}.

@item
@code{'median}, default @code{0}, is the median value to be checked.

@end itemize

The output of function @code{test_sign} is an @code{inference_result} Maxima object
showing the following results:

@enumerate

@item
@code{'med_estimate}: the sample median.

@item
@code{'method}: inference procedure.

@item
@code{'hypotheses}: null and alternative hypotheses to be tested.

@item
@code{'statistic}: value of the sample statistic used for testing the null hypothesis.

@item
@code{'distribution}: distribution of the sample statistic, together with its parameter(s).

@item
@code{'p_value}: @math{p}-value of the test.

@end enumerate

Examples:

Checks whether the population from which the sample was taken has median 6, 
against the alternative @math{H_1: median > 6}.

@c ===beg===
@c load ("stats")$
@c x: [2,0.1,7,1.8,4,2.3,5.6,7.4,5.1,6.1,6]$
@c test_sign(x,'median=6,'alternative='greater);
@c ===end===
@example
(%i1) load("stats")$
(%i2) x: [2,0.1,7,1.8,4,2.3,5.6,7.4,5.1,6.1,6]$
(%i3) test_sign(x,'median=6,'alternative='greater);
               |                  SIGN TEST
               |
               |              med_estimate = 5.1
               |
               |      method = Non parametric sign test.
               |
(%o3)          | hypotheses = H0: median = 6 , H1: median > 6
               |
               |                statistic = 7
               |
               |      distribution = [binomial, 10, 0.5]
               |
               |         p_value = .05468749999999989
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn

@anchor{test_signed_rank}
@deffn {Function} test_signed_rank @
@fname{test_signed_rank} (@var{x}) @
@fname{test_signed_rank} (@var{x}, @var{options} @dots{})

This is the Wilcoxon signed rank test to make inferences about the median of a
continuous population. Argument @var{x} is a list or a column matrix
containing a one dimensional sample. Performs normal approximation if the
sample size is greater than 20, or if there are zeroes or ties.

@c TODO: These two variables/functions aren't documented
See also @code{pdf_rank_test} and @code{cdf_rank_test}

Options:

@itemize @bullet

@item
@code{'median}, default @code{0}, is the median value to be checked.

@item
@code{'alternative}, default @code{'twosided}, is the alternative hypothesis;
valid values are: @code{'twosided}, @code{'greater} and @code{'less}.

@end itemize

The output of function @code{test_signed_rank} is an @code{inference_result} Maxima object
with the following results:

@enumerate

@item
@code{'med_estimate}: the sample median.

@item
@code{'method}: inference procedure.

@item
@code{'hypotheses}: null and alternative hypotheses to be tested.

@item
@code{'statistic}: value of the sample statistic used for testing the null hypothesis.

@item
@code{'distribution}: distribution of the sample statistic, together with its parameter(s).

@item
@code{'p_value}: @math{p}-value of the test.

@end enumerate

Examples:

Checks the null hypothesis @math{H_0: median = 15} against the 
alternative @math{H_1: median > 15}. This is an exact test, since
there are no ties.

@c equivalent code for R:
@c x <- c(17.1,15.9,13.7,13.4,15.5,17.6)
@c wilcox.test(x,mu=15,alternative="greater")

@c ===beg===
@c load ("stats")$
@c x: [17.1,15.9,13.7,13.4,15.5,17.6]$
@c test_signed_rank(x,median=15,alternative=greater);
@c ===end===
@example
(%i1) load("stats")$
(%i2) x: [17.1,15.9,13.7,13.4,15.5,17.6]$
(%i3) test_signed_rank(x,median=15,alternative=greater);
                 |             SIGNED RANK TEST
                 |
                 |           med_estimate = 15.7
                 |
                 |           method = Exact test
                 |
(%o3)            | hypotheses = H0: med = 15 , H1: med > 15
                 |
                 |              statistic = 14
                 |
                 |     distribution = [signed_rank, 6]
                 |
                 |            p_value = 0.28125
@end example

Checks the null hypothesis @math{H_0: equal(median, 2.5)} against the 
alternative @math{H_1: not equal(median, 2.5)}. This is an approximated test,
since there are ties.

@c equivalent code for R:
@c y<-c(1.9,2.3,2.6,1.9,1.6,3.3,4.2,4,2.4,2.9,1.5,3,2.9,4.2,3.1)
@c wilcox.test(y,mu=2.5)

@c ===beg===
@c load ("stats")$
@c y:[1.9,2.3,2.6,1.9,1.6,3.3,4.2,4,2.4,2.9,1.5,3,2.9,4.2,3.1]$
@c test_signed_rank(y,median=2.5);
@c ===end===
@example
(%i1) load("stats")$
(%i2) y:[1.9,2.3,2.6,1.9,1.6,3.3,4.2,4,2.4,2.9,1.5,3,2.9,4.2,3.1]$
(%i3) test_signed_rank(y,median=2.5);
             |                 SIGNED RANK TEST
             |
             |                med_estimate = 2.9
             |
             |          method = Asymptotic test. Ties
             |
(%o3)        |    hypotheses = H0: med = 2.5 , H1: med # 2.5
             |
             |                 statistic = 76.5
             |
             | distribution = [normal, 60.5, 17.58195097251724]
             |
             |           p_value = .3628097734643669
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn

@anchor{test_rank_sum}
@deffn {Function} test_rank_sum @
@fname{test_rank_sum} (@var{x1}, @var{x2}) @
@fname{test_rank_sum} (@var{x1}, @var{x2}, @var{option})

This is the Wilcoxon-Mann-Whitney test for comparing the medians of two
continuous populations. The first two arguments @var{x1} and @var{x2} are lists
or column matrices with the data of two independent samples. Performs normal
approximation if any of the sample sizes is greater than 10, or if there are ties.

Option:

@itemize @bullet

@item
@code{'alternative}, default @code{'twosided}, is the alternative hypothesis;
valid values are: @code{'twosided}, @code{'greater} and @code{'less}.

@end itemize

The output of function @code{test_rank_sum} is an @code{inference_result} Maxima object
with the following results:

@enumerate

@item
@code{'method}: inference procedure.

@item
@code{'hypotheses}: null and alternative hypotheses to be tested.

@item
@code{'statistic}: value of the sample statistic used for testing the null hypothesis.

@item
@code{'distribution}: distribution of the sample statistic, together with its parameters.

@item
@code{'p_value}: @math{p}-value of the test.

@end enumerate

Examples:

Checks whether populations have similar medians. Samples sizes
are small and an exact test is made.

@c equivalent code for R:
@c x <- c(12,15,17,38,42,10,23,35,28)
@c y <- c(21,18,25,14,52,65,40,43)
@c wilcox.test(x,y)

@c ===beg===
@c load ("stats")$
@c x:[12,15,17,38,42,10,23,35,28]$
@c y:[21,18,25,14,52,65,40,43]$
@c test_rank_sum(x,y);
@c ===end===
@example
(%i1) load("stats")$
(%i2) x:[12,15,17,38,42,10,23,35,28]$
(%i3) y:[21,18,25,14,52,65,40,43]$
(%i4) test_rank_sum(x,y);
              |                 RANK SUM TEST
              |
              |              method = Exact test
              |
              | hypotheses = H0: med1 = med2 , H1: med1 # med2
(%o4)         |
              |                 statistic = 22
              |
              |        distribution = [rank_sum, 9, 8]
              |
              |          p_value = .1995886466474702
@end example

Now, with greater samples and ties, the procedure makes 
normal approximation. The alternative hypothesis is
@math{H_1: median1 < median2}.

@c equivalent code for R:
@c x <- c(39,42,35,13,10,23,15,20,17,27)
@c y <- c(20,52,66,19,41,32,44,25,14,39,43,35,19,56,27,15)
@c wilcox.test(x,y,alternative="less")

@c ===beg===
@c load ("stats")$
@c x: [39,42,35,13,10,23,15,20,17,27]$
@c y: [20,52,66,19,41,32,44,25,14,39,43,35,19,56,27,15]$
@c test_rank_sum(x,y,'alternative='less);
@c ===end===
@example
(%i1) load("stats")$
(%i2) x: [39,42,35,13,10,23,15,20,17,27]$
(%i3) y: [20,52,66,19,41,32,44,25,14,39,43,35,19,56,27,15]$
(%i4) test_rank_sum(x,y,'alternative='less);
             |                  RANK SUM TEST
             |
             |          method = Asymptotic test. Ties
             |
             |  hypotheses = H0: med1 = med2 , H1: med1 < med2
(%o4)        |
             |                 statistic = 48.5
             |
             | distribution = [normal, 79.5, 18.95419580097078]
             |
             |           p_value = .05096985666598441
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn







@anchor{test_normality}
@deffn {Function} test_normality (@var{x})

Shapiro-Wilk test for normality. Argument @var{x} is a list of numbers, and sample
size must be greater than 2 and less or equal than 5000, otherwise, function
@code{test_normality} signals an error message.

Reference:

  [1] Algorithm AS R94, Applied Statistics (1995), vol.44, no.4, 547-551

The output of function @code{test_normality} is an @code{inference_result} Maxima object
with the following results:

@enumerate

@item
@code{'statistic}: value of the @var{W} statistic.

@item
@code{'p_value}: @math{p}-value under normal assumption.

@end enumerate

Examples:

Checks for the normality of a population, based on a sample of size 9.

@c equivalent code for R:
@c x <- c(12,15,17,38,42,10,23,35,28)
@c shapiro.test(x)

@c ===beg===
@c load ("stats")$
@c x:[12,15,17,38,42,10,23,35,28]$
@c test_normality(x);
@c ===end===
@example
(%i1) load("stats")$
(%i2) x:[12,15,17,38,42,10,23,35,28]$
(%i3) test_normality(x);
                       |      SHAPIRO - WILK TEST
                       |
(%o3)                  | statistic = .9251055695162436
                       |
                       |  p_value = .4361763918860381
@end example

@opencatbox
@category{Package stats}
@closecatbox

@end deffn

@anchor{linear_regression}
@deffn {Function} linear_regression @
@fname{linear_regression} (@var{x}) @
@fname{linear_regression} (@var{x} @var{option})

Multivariate linear regression, 
@math{y_i = b0 + b1*x_1i + b2*x_2i + ... + bk*x_ki + u_i},
where @math{u_i} are @math{N(0,sigma)} independent random variables.
Argument @var{x} must be a matrix with more than one column. The
last column is considered as the responses (@math{y_i}).

Option:

@itemize @bullet

@item
@code{'conflevel}, default @code{95/100}, confidence level for the
confidence intervals; it must be an expression which takes a value
in (0,1).
@end itemize

The output of function @code{linear_regression} is an 
@code{inference_result} Maxima object with the following results:

@enumerate

@item
@code{'b_estimation}: regression coefficients estimates.

@item
@code{'b_covariances}: covariance matrix of the regression 
coefficients estimates.

@item
@code{b_conf_int}: confidence intervals of the regression coefficients.

@item
@code{b_statistics}: statistics for testing coefficient.

@item
@code{b_p_values}: p-values for coefficient tests.

@item
@code{b_distribution}: probability distribution for coefficient tests.

@item
@code{v_estimation}: unbiased variance estimator.

@item
@code{v_conf_int}: variance confidence interval.

@item
@code{v_distribution}: probability distribution for variance test.

@item
@code{residuals}: residuals.

@item
@code{adc}: adjusted determination coefficient.

@item
@code{aic}: Akaike's information criterion.

@item
@code{bic}: Bayes's information criterion.

@end enumerate

Only items 1, 4, 5, 6, 7, 8, 9 and 11 above, in this order, 
are shown by default. The rest remain hidden until the user
makes use of functions @code{items_inference} and @code{take_inference}.

Example:

Fitting a linear model to a trivariate sample. The
last column is considered as the responses (@math{y_i}).

@c ===beg===
@c load ("stats")$
@c X:matrix(
@c    [58,111,64],[84,131,78],[78,158,83],
@c    [81,147,88],[82,121,89],[102,165,99],
@c    [85,174,101],[102,169,102])$
@c fpprintprec: 4$
@c res: linear_regression(X);
@c items_inference(res);
@c take_inference('b_covariances, res);
@c take_inference('bic, res);
@c load("draw")$
@c draw2d(
@c    points_joined = true,
@c    grid = true,
@c    points(take_inference('residuals, res)) )$
@c ===end===
@example
(%i2) load("stats")$
(%i3) X:matrix(
    [58,111,64],[84,131,78],[78,158,83],
    [81,147,88],[82,121,89],[102,165,99],
    [85,174,101],[102,169,102])$
(%i4) fpprintprec: 4$
(%i5) res: linear_regression(X);
             |       LINEAR REGRESSION MODEL         
             |                                       
             | b_estimation = [9.054, .5203, .2397]  
             |                                       
             | b_statistics = [.6051, 2.246, 1.74]   
             |                                       
             | b_p_values = [.5715, .07466, .1423]   
             |                                       
(%o5)        |   b_distribution = [student_t, 5]     
             |                                       
             |         v_estimation = 35.27          
             |                                       
             |     v_conf_int = [13.74, 212.2]       
             |                                       
             |      v_distribution = [chi2, 5]       
             |                                       
             |             adc = .7922               
(%i6) items_inference(res);
(%o6) [b_estimation, b_covariances, b_conf_int, b_statistics, 
b_p_values, b_distribution, v_estimation, v_conf_int, 
v_distribution, residuals, adc, aic, bic]
(%i7) take_inference('b_covariances, res);
                  [  223.9    - 1.12   - .8532  ]
                  [                             ]
(%o7)             [ - 1.12    .05367   - .02305 ]
                  [                             ]
                  [ - .8532  - .02305   .01898  ]
(%i8) take_inference('bic, res);
(%o8)                          30.98
(%i9) load("draw")$
(%i10) draw2d(
    points_joined = true,
    grid = true,
    points(take_inference('residuals, res)) )$
@end example

@opencatbox
@category{Package stats} @category{Statistical estimation}
@closecatbox

@end deffn






@node Functions and Variables for special distributions, , Functions and Variables for stats, Top
@section Functions and Variables for special distributions


@anchor{pdf_signed_rank}
@deffn {Function} pdf_signed_rank (@var{x}, @var{n})
Probability density function of the exact distribution of the
signed rank statistic. Argument @var{x} is a real
number and @var{n} a positive integer.

See also @mrefdot{test_signed_rank}

@opencatbox
@category{Package stats}
@closecatbox

@end deffn

@anchor{cdf_signed_rank}
@deffn {Function} cdf_signed_rank (@var{x}, @var{n})
Cumulative density function of the exact distribution of the
signed rank statistic. Argument @var{x} is a real
number and @var{n} a positive integer. 

See also @mrefdot{test_signed_rank}

@opencatbox
@category{Package stats}
@closecatbox

@end deffn

@anchor{pdf_rank_sum}
@deffn {Function} pdf_rank_sum (@var{x}, @var{n}, @var{m})
Probability density function of the exact distribution of the
rank sum statistic. Argument @var{x} is a real
number and @var{n} and @var{m} are both positive integers. 

See also @mrefdot{test_rank_sum}

@opencatbox
@category{Package stats}
@closecatbox

@end deffn

@anchor{cdf_rank_sum}
@deffn {Function} cdf_rank_sum (@var{x}, @var{n}, @var{m})
Cumulative density function of the exact distribution of the
rank sum statistic. Argument @var{x} is a real
number and @var{n} and @var{m} are both positive integers. 

See also @mrefdot{test_rank_sum}

@opencatbox
@category{Package stats}
@closecatbox

@end deffn

