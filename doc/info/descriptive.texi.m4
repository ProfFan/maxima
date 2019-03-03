@c -*- Mode: texinfo -*-
@menu
* Introduction to descriptive::
* Functions and Variables for data manipulation::
* Functions and Variables for descriptive statistics::
* Functions and Variables for statistical graphs::
@end menu

@node Introduction to descriptive, Functions and Variables for data manipulation, descriptive-pkg, descriptive-pkg
@section Introduction to descriptive

Package @code{descriptive} contains a set of functions for 
making descriptive statistical computations and graphing. 
Together with the source code there are three data sets in 
your Maxima tree: @code{pidigits.data}, @code{wind.data} and @code{biomed.data}.

Any statistics manual can be used as a reference to the functions in package @code{descriptive}.

For comments, bugs or suggestions, please contact me at @var{'riotorto AT yahoo DOT com'}.

Here is a simple example on how the descriptive functions in @code{descriptive} do they work, depending on the nature of their arguments, lists or matrices,

@c ===beg===
@c load ("descriptive")$
@c /* univariate sample */   mean ([a, b, c]);
@c matrix ([a, b], [c, d], [e, f]);
@c /* multivariate sample */ mean (%);
@c ===end===
@example
(%i1) load ("descriptive")$
@group
(%i2) /* univariate sample */   mean ([a, b, c]);
                            c + b + a
(%o2)                       ---------
                                3
@end group
@group
(%i3) matrix ([a, b], [c, d], [e, f]);
                            [ a  b ]
                            [      ]
(%o3)                       [ c  d ]
                            [      ]
                            [ e  f ]
@end group
@group
(%i4) /* multivariate sample */ mean (%);
                      e + c + a  f + d + b
(%o4)                [---------, ---------]
                          3          3
@end group
@end example

Note that in multivariate samples the mean is calculated for each column.

In case of several samples with possible different sizes, the Maxima function @code{map} can be used to get the desired results for each sample,

@c ===beg===
@c load ("descriptive")$
@c map (mean, [[a, b, c], [d, e]]);
@c ===end===
@example
(%i1) load ("descriptive")$
@group
(%i2) map (mean, [[a, b, c], [d, e]]);
                        c + b + a  e + d
(%o2)                  [---------, -----]
                            3        2
@end group
@end example

In this case, two samples of sizes 3 and 2 were stored into a list.

Univariate samples must be stored in lists like

@c ===beg===
@c s1 : [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5];
@c ===end===
@example
@group
(%i1) s1 : [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5];
(%o1)           [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
@end group
@end example

and multivariate samples in matrices as in

@c ===beg===
@c s2 : matrix ([13.17, 9.29], [14.71, 16.88], [18.50, 16.88],
@c              [10.58, 6.63], [13.33, 13.25], [13.21,  8.12]);
@c ===end===
@example
@group
(%i1) s2 : matrix ([13.17, 9.29], [14.71, 16.88], [18.50, 16.88],
             [10.58, 6.63], [13.33, 13.25], [13.21,  8.12]);
                        [ 13.17  9.29  ]
                        [              ]
                        [ 14.71  16.88 ]
                        [              ]
                        [ 18.5   16.88 ]
(%o1)                   [              ]
                        [ 10.58  6.63  ]
                        [              ]
                        [ 13.33  13.25 ]
                        [              ]
                        [ 13.21  8.12  ]
@end group
@end example

In this case, the number of columns equals the random variable dimension and the number of rows is the sample size.

Data can be introduced by hand, but big samples are usually stored in plain text files. For example, file @code{pidigits.data} contains the first 100 digits of number @code{%pi}:
@example
@group
      3
      1
      4
      1
      5
      9
      2
      6
      5
      3 ...
@end group
@end example

In order to load these digits in Maxima,

@c ===beg===
@c s1 : read_list (file_search ("pidigits.data"))$
@c length (s1);
@c ===end===
@example
(%i1) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i2) length (s1);
(%o2)                          100
@end group
@end example

On the other hand, file @code{wind.data} contains daily average wind speeds at 5 meteorological stations in the Republic of Ireland (This is part of a data set taken at 12 meteorological stations. The original file is freely downloadable from the StatLib Data Repository and its analysis is discused in Haslett, J., Raftery, A. E. (1989) @var{Space-time Modelling with Long-memory Dependence: Assessing Ireland's Wind Power Resource, with Discussion}. Applied Statistics 38, 1-50). This loads the data:

@c ===beg===
@c s2 : read_matrix (file_search ("wind.data"))$
@c length (s2);
@c s2 [%]; /* last record */
@c ===end===
@example
(%i1) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i2) length (s2);
(%o2)                          100
@end group
@group
(%i3) s2 [%]; /* last record */
(%o3)            [3.58, 6.0, 4.58, 7.62, 11.25]
@end group
@end example

Some samples contain non numeric data. As an example, file @code{biomed.data} (which is part of another bigger one downloaded from the StatLib Data Repository) contains four blood measures taken from two groups of patients, @code{A} and @code{B}, of different ages,

@c ===beg===
@c s3 : read_matrix (file_search ("biomed.data"))$
@c length (s3);
@c s3 [1]; /* first record */
@c ===end===
@example
(%i1) s3 : read_matrix (file_search ("biomed.data"))$
@group
(%i2) length (s3);
(%o2)                          100
@end group
@group
(%i3) s3 [1]; /* first record */
(%o3)            [A, 30, 167.0, 89.0, 25.6, 364]
@end group
@end example

The first individual belongs to group @code{A}, is 30 years old and his/her blood measures were 167.0, 89.0, 25.6 and 364.

One must take care when working with categorical data. In the next example, symbol @code{a} is assigned a value in some previous moment and then a sample with categorical value @code{a} is taken,

@c ===beg===
@c a : 1$
@c matrix ([a, 3], [b, 5]);
@c ===end===
@example
(%i1) a : 1$
@group
(%i2) matrix ([a, 3], [b, 5]);
                            [ 1  3 ]
(%o2)                       [      ]
                            [ b  5 ]
@end group
@end example

@opencatbox
@category{Descriptive statistics}
@category{Share packages}
@category{Package descriptive}
@closecatbox

@node Functions and Variables for data manipulation, Functions and Variables for descriptive statistics, Introduction to descriptive, descriptive-pkg
@section Functions and Variables for data manipulation



m4_setcat(Package descriptive)
@anchor{build_sample}
@c @deffn {Function} build_sample @
m4_deffn({Function}, build_sample, <<<>>>) @
@fname{build_sample} (@var{list}) @
@fname{build_sample} (@var{matrix})

Builds a sample from a table of absolute frequencies.
The input table can be a matrix or a list of lists, all of
them of equal size. The number of columns or the length of
the lists must be greater than 1. The last element of each
row or list is interpreted as the absolute frequency.
The output is always a sample in matrix form.

Examples:

Univariate frequency table.

@c ===beg===
@c load ("descriptive")$
@c sam1: build_sample([[6,1], [j,2], [2,1]]);
@c mean(sam1);
@c barsplot(sam1) $
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) sam1: build_sample([[6,1], [j,2], [2,1]]);
                       [ 6 ]
                       [   ]
                       [ j ]
(%o2)                  [   ]
                       [ j ]
                       [   ]
                       [ 2 ]
(%i3) mean(sam1);
                      2 j + 8
(%o3)                [-------]
                         4
(%i4) barsplot(sam1) $
@end example

Multivariate frequency table.

@c ===beg===
@c load ("descriptive")$
@c sam2: build_sample([[6,3,1], [5,6,2], [u,2,1],[6,8,2]]) ;
@c cov(sam2);
@c barsplot(sam2, grouping=stacked) $
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) sam2: build_sample([[6,3,1], [5,6,2], [u,2,1],[6,8,2]]) ;
                           [ 6  3 ]
                           [      ]
                           [ 5  6 ]
                           [      ]
                           [ 5  6 ]
(%o2)                      [      ]
                           [ u  2 ]
                           [      ]
                           [ 6  8 ]
                           [      ]
                           [ 6  8 ]
(%i3) cov(sam2);
       [   2                 2                            ]
       [  u  + 158   (u + 28)     2 u + 174   11 (u + 28) ]
       [  -------- - ---------    --------- - ----------- ]
(%o3)  [     6          36            6           12      ]
       [                                                  ]
       [ 2 u + 174   11 (u + 28)            21            ]
       [ --------- - -----------            --            ]
       [     6           12                 4             ]
(%i4) barsplot(sam2, grouping=stacked) $
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{continuous_freq}
@c @deffn {Function} continuous_freq @
m4_deffn({Function}, continuous_freq, <<<>>>) @
@fname{continuous_freq} (@var{data}) @
@fname{continuous_freq} (@var{data}, @var{m})

The first argument of @code{continuous_freq} must be a list
or 1-dimensional array (as created by @code{make_array}) of numbers.
Divides the range in intervals and counts how many values
are inside them. The second argument is optional and either
equals the number of classes we want, 10 by default, or
equals a list containing the class limits and the number of
classes we want, or a list containing only the limits.

If sample values are all equal, this function returns only
one class of amplitude 2.

Examples:

Optional argument indicates the number of classes we want.
The first list in the output contains the interval limits, and
the second the corresponding counts: there are 16 digits inside 
the interval @code{[0, 1.8]}, 24 digits in @code{(1.8, 3.6]}, and so on.

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c continuous_freq (s1, 5);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
(%i3) continuous_freq (s1, 5);
(%o3) [[0, 1.8, 3.6, 5.4, 7.2, 9.0], [16, 24, 18, 17, 25]]
@end example

Optional argument indicates we want 7 classes with limits
-2 and 12:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c continuous_freq (s1, [-2,12,7]);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
(%i3) continuous_freq (s1, [-2,12,7]);
(%o3) [[- 2, 0, 2, 4, 6, 8, 10, 12], [8, 20, 22, 17, 20, 13, 0]]
@end example

Optional argument indicates we want the default number of classes with limits
-2 and 12:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c continuous_freq (s1, [-2,12]);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
(%i3) continuous_freq (s1, [-2,12]);
                3  4  11  18     32  39  46  53
(%o3)  [[- 2, - -, -, --, --, 5, --, --, --, --, 12], 
                5  5  5   5      5   5   5   5
               [0, 8, 20, 12, 18, 9, 8, 25, 0, 0]]
@end example

The first argument may be an array.

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c a1 : make_array (fixnum, length (s1)) $
@c fillarray (a1, s1);
@c continuous_freq (a1);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
(%i3) a1 : make_array (fixnum, length (s1)) $
(%i4) fillarray (a1, s1);
(%o4) @{Lisp Array: 
#(3 1 4 1 5 9 2 6 5 3 5 8 9 7 9 3 2 3 8 4 6 2 6 4 3 3 8 3 2 7 9 \
5 0 2 8 8 4 1 9 7 1 6 9 3 9 9 3 7 5 1 0 5 8 2 0 9 7 4 9 4 4 5 9
  2 3 0 7 8 1 6 4 0 6 2 8 6 2 0 8 9 9 8 6 2 8 0 3 4 8 2 5 3 4 2 \
1 1 7 0 6 7)@}
(%i5) continuous_freq (a1);
           9   9  27  18  9  27  63  36  81
(%o5) [[0, --, -, --, --, -, --, --, --, --, 9], 
           10  5  10  5   2  5   10  5   10
                             [8, 8, 12, 12, 10, 8, 9, 8, 12, 13]]
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{discrete_freq}
@c @deffn {Function} discrete_freq (@var{data})
m4_deffn({Function}, discrete_freq, <<<(@var{data})>>>)
Counts absolute frequencies in discrete samples, both numeric and categorical. Its unique argument is a list,
or 1-dimensional array (as created by @code{make_array}).

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c discrete_freq (s1);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) discrete_freq (s1);
(%o3) [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 
                             [8, 8, 12, 12, 10, 8, 9, 8, 12, 13]]
@end group
@end example

The first list gives the sample values and the second their absolute frequencies. Commands @code{? col} and @code{? transpose} should help you to understand the last input.

The argument may be an array.

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c a1 : make_array (fixnum, length (s1)) $
@c fillarray (a1, s1);
@c discrete_freq (a1);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
(%i3) a1 : make_array (fixnum, length (s1)) $
(%i4) fillarray (a1, s1);
(%o4) @{Lisp Array: 
#(3 1 4 1 5 9 2 6 5 3 5 8 9 7 9 3 2 3 8 4 6 2 6 4 3 3 8 3 2 7 9 \
5 0 2 8 8 4 1 9 7 1 6 9 3 9 9 3 7 5 1 0 5 8 2 0 9 7 4 9 4 4 5 9
  2 3 0 7 8 1 6 4 0 6 2 8 6 2 0 8 9 9 8 6 2 8 0 3 4 8 2 5 3 4 2 \
1 1 7 0 6 7)@}
(%i5) discrete_freq (a1);
(%o5) [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 
                             [8, 8, 12, 12, 10, 8, 9, 8, 12, 13]]
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()




@anchor{standardize}
@c @deffn {Function} standardize @
m4_deffn({Function}, standardize, <<<>>>) @
@fname{standardize} (@var{list}) @
@fname{standardize} (@var{matrix})

Subtracts to each element of the list the sample mean and divides
the result by the standard deviation. When the input is a matrix,
@code{standardize} subtracts to each row the multivariate mean, and then
divides each component by the corresponding standard deviation.

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()




@anchor{subsample}
@c @deffn {Function} subsample @
m4_deffn({Function}, subsample, <<<>>>) @
@fname{subsample} (@var{data_matrix}, @var{predicate_function}) @
@fname{subsample} (@var{data_matrix}, @var{predicate_function}, @var{col_num1}, @var{col_num2}, ...)

This is a sort of variant of the Maxima @code{submatrix} function.
The first argument is the data matrix, the second is a predicate function
and optional additional arguments are the numbers of the columns to be taken.
Its behaviour is better understood with examples.

These are multivariate records in which the wind speed
in the first meteorological station were greater than 18.
See that in the lambda expression the @var{i}-th component is
referred to as @code{v[i]}.
@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix (file_search ("wind.data"))$
@c subsample (s2, lambda([v], v[1] > 18));
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i3) subsample (s2, lambda([v], v[1] > 18));
              [ 19.38  15.37  15.12  23.09  25.25 ]
              [                                   ]
              [ 18.29  18.66  19.08  26.08  27.63 ]
(%o3)         [                                   ]
              [ 20.25  21.46  19.95  27.71  23.38 ]
              [                                   ]
              [ 18.79  18.96  14.46  26.38  21.84 ]
@end group
@end example

In the following example, we request only the first, second and fifth
components of those records with wind speeds greater or equal than 16
in station number 1 and less than 25 knots in station number 4. The sample
contains only data from stations 1, 2 and 5. In this case,
the predicate function is defined as an ordinary Maxima function.
@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix (file_search ("wind.data"))$
@c g(x):= x[1] >= 16 and x[4] < 25$
@c subsample (s2, g, 1, 2, 5);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
(%i3) g(x):= x[1] >= 16 and x[4] < 25$
@group
(%i4) subsample (s2, g, 1, 2, 5);
                     [ 19.38  15.37  25.25 ]
                     [                     ]
                     [ 17.33  14.67  19.58 ]
(%o4)                [                     ]
                     [ 16.92  13.21  21.21 ]
                     [                     ]
                     [ 17.25  18.46  23.87 ]
@end group
@end example

Here is an example with the categorical variables of @code{biomed.data}.
We want the records corresponding to those patients in group @code{B}
who are older than 38 years.
@c ===beg===
@c load ("descriptive")$
@c s3 : read_matrix (file_search ("biomed.data"))$
@c h(u):= u[1] = B and u[2] > 38 $
@c subsample (s3, h);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s3 : read_matrix (file_search ("biomed.data"))$
(%i3) h(u):= u[1] = B and u[2] > 38 $
@group
(%i4) subsample (s3, h);
                [ B  39  28.0  102.3  17.1  146 ]
                [                               ]
                [ B  39  21.0  92.4   10.3  197 ]
                [                               ]
                [ B  39  23.0  111.5  10.0  133 ]
                [                               ]
                [ B  39  26.0  92.6   12.3  196 ]
(%o4)           [                               ]
                [ B  39  25.0  98.7   10.0  174 ]
                [                               ]
                [ B  39  21.0  93.2   5.9   181 ]
                [                               ]
                [ B  39  18.0  95.0   11.3  66  ]
                [                               ]
                [ B  39  39.0  88.5   7.6   168 ]
@end group
@end example

Probably, the statistical analysis will involve only the blood measures,
@c ===beg===
@c load ("descriptive")$
@c s3 : read_matrix (file_search ("biomed.data"))$
@c subsample (s3, lambda([v], v[1] = B and v[2] > 38),
@c            3, 4, 5, 6);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s3 : read_matrix (file_search ("biomed.data"))$
@group
(%i3) subsample (s3, lambda([v], v[1] = B and v[2] > 38),
                 3, 4, 5, 6);
                   [ 28.0  102.3  17.1  146 ]
                   [                        ]
                   [ 21.0  92.4   10.3  197 ]
                   [                        ]
                   [ 23.0  111.5  10.0  133 ]
                   [                        ]
                   [ 26.0  92.6   12.3  196 ]
(%o3)              [                        ]
                   [ 25.0  98.7   10.0  174 ]
                   [                        ]
                   [ 21.0  93.2   5.9   181 ]
                   [                        ]
                   [ 18.0  95.0   11.3  66  ]
                   [                        ]
                   [ 39.0  88.5   7.6   168 ]
@end group
@end example

This is the multivariate mean of @code{s3},
@c ===beg===
@c load ("descriptive")$
@c s3 : read_matrix (file_search ("biomed.data"))$
@c mean (s3);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s3 : read_matrix (file_search ("biomed.data"))$
@group
(%i3) mean (s3);
       65 B + 35 A  317          6 NA + 8144.999999999999
(%o3) [-----------, ---, 87.178, ------------------------, 
           100      10                     100
                                                    3 NA + 19587
                                            18.123, ------------]
                                                        100
@end group
@end example

Here, the first component is meaningless, since @code{A} and @code{B} are categorical, the second component is the mean age of individuals in rational form, and the fourth and last values exhibit some strange behaviour. This is because symbol @code{NA} is used here to indicate @var{non available} data, and the two means are nonsense. A possible solution would be to take out from the matrix those rows with @code{NA} symbols, although this deserves some loss of information.
@c ===beg===
@c load ("descriptive")$
@c s3 : read_matrix (file_search ("biomed.data"))$
@c g(v):= v[4] # NA and v[6] # NA $
@c mean (subsample (s3, g, 3, 4, 5, 6));
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s3 : read_matrix (file_search ("biomed.data"))$
(%i3) g(v):= v[4] # NA and v[6] # NA $
@group
(%i4) mean (subsample (s3, g, 3, 4, 5, 6));
(%o4) [79.4923076923077, 86.2032967032967, 16.93186813186813, 
                                                            2514
                                                            ----]
                                                             13
@end group
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()





@anchor{transform_sample}
@c @deffn {Function} transform_sample (@var{matrix}, @var{varlist}, @var{exprlist})
m4_deffn({Function}, transform_sample, <<<(@var{matrix}, @var{varlist}, @var{exprlist})>>>)

Transforms the sample @var{matrix}, where each column is called according to
@var{varlist}, following expressions in @var{exprlist}.

Examples:

The second argument assigns names to the three columns. With these names,
a list of expressions define the transformation of the sample.

@example
(%i1) load ("descriptive")$
(%i2) data: matrix([3,2,7],[3,7,2],[8,2,4],[5,2,4]) $
@group
(%i3) transform_sample(data, [a,b,c], [c, a*b, log(a)]);
                               [ 7  6   log(3) ]
                               [               ]
                               [ 2  21  log(3) ]
(%o3)                          [               ]
                               [ 4  16  log(8) ]
                               [               ]
                               [ 4  10  log(5) ]
@end group
@end example

Add a constant column and remove the third variable.

@example
(%i1) load ("descriptive")$
(%i2) data: matrix([3,2,7],[3,7,2],[8,2,4],[5,2,4]) $
(%i3) transform_sample(data, [a,b,c], [makelist(1,k,length(data)),a,b]);
@group
                                  [ 1  3  2 ]
                                  [         ]
                                  [ 1  3  7 ]
(%o3)                             [         ]
                                  [ 1  8  2 ]
                                  [         ]
                                  [ 1  5  2 ]
@end group
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()







@node Functions and Variables for descriptive statistics, Functions and Variables for statistical graphs, Functions and Variables for data manipulation, descriptive-pkg
@section Functions and Variables for descriptive statistics



@anchor{mean}
@c @deffn {Function} mean @
m4_deffn({Function}, mean, <<<>>>) @
@fname{mean} (@var{list}) @
@fname{mean} (@var{matrix})

This is the sample mean, defined as
m4_mathjax(
<<<$${\bar{x}={1\over{n}}{\sum_{i=1}^{n}{x_{i}}}}$$>>>,
<<<@example
                       n
                     ====
             _   1   \
             x = -    >    x
                 n   /      i
                     ====
                     i = 1
@end example
>>>)

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c mean (s1);
@c %, numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c mean (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) mean (s1);
                               471
(%o3)                          ---
                               100
@end group
@group
(%i4) %, numer;
(%o4)                         4.71
@end group
(%i5) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i6) mean (s2);
(%o6)     [9.9485, 10.1607, 10.8685, 15.7166, 14.8441]
@end group
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{var}
@c @deffn {Function} var @
m4_deffn({Function}, var, <<<>>>) @
@fname{var} (@var{list}) @
@fname{var} (@var{matrix})

This is the sample variance, defined as
m4_mathjax(
<<<$${{1}\over{n}}{\sum_{i=1}^{n}{(x_{i}-\bar{x})^2}}$$>>>,
<<<@example
@group
                     n
                   ====
           2   1   \          _ 2
          s  = -    >    (x - x)
               n   /       i
                   ====
                   i = 1
@end group
@end example
>>>)

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c var (s1), numer;
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) var (s1), numer;
(%o3)                   8.425899999999999
@end group
@end example

See also function @mrefdot{var1}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{var1}
@c @deffn {Function} var1 @
m4_deffn({Function}, var1, <<<>>>) @
@fname{var1} (@var{list}) @
@fname{var1} (@var{matrix})

This is the sample variance, defined as
m4_mathjax(
<<<$${{1\over{n-1}}{\sum_{i=1}^{n}{(x_{i}-\bar{x})^2}}}$$>>>,
<<<@example
@group
                     n
                   ====
               1   \          _ 2
              ---   >    (x - x)
              n-1  /       i
                   ====
                   i = 1
@end group
@end example
>>>)

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c var1 (s1), numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c var1 (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) var1 (s1), numer;
(%o3)                    8.5110101010101
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) var1 (s2);
(%o5) [17.39586540404041, 15.13912778787879, 15.63204924242424, 
                            32.50152569696971, 24.66977392929294]
@end group
@end example

See also function @mrefdot{var}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{std}
@c @deffn {Function} std @
m4_deffn({Function}, std, <<<>>>) @
@fname{std} (@var{list}) @
@fname{std} (@var{matrix})

This is the square root of the function @code{var}, the variance with denominator @math{n}.

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c std (s1), numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c std (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) std (s1), numer;
(%o3)                   2.902740084816414
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) std (s2);
(%o5) [4.149928523480858, 3.871399812729241, 3.933920277534866, 
                            5.672434260526957, 4.941970881136392]
@end group
@end example

See also functions @mref{var} and @mrefdot{std1}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{std1}
@c @deffn {Function} std1 @
m4_deffn({Function}, std1, <<<>>>) @
@fname{std1} (@var{list}) @
@fname{std1} (@var{matrix})

This is the square root of the function @mrefcomma{var1} the variance with denominator @math{n-1}.

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c std1 (s1), numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c std1 (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) std1 (s1), numer;
(%o3)                   2.917363553109228
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) std1 (s2);
(%o5) [4.170835096721089, 3.89090320978032, 3.953738641137555, 
                            5.701010936401517, 4.966867617451963]
@end group
@end example

See also functions @mref{var1} and @mrefdot{std}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{noncentral_moment}
@c @deffn {Function} noncentral_moment @
m4_deffn({Function}, noncentral_moment, <<<>>>) @
@fname{noncentral_moment} (@var{list}, @var{k}) @
@fname{noncentral_moment} (@var{matrix}, @var{k})

The non central moment of order @math{k}, defined as
m4_mathjax(
<<<$${{1\over{n}}{\sum_{i=1}^{n}{x_{i}^k}}}$$>>>,
<<<@example
@group
                       n
                     ====
                 1   \      k
                 -    >    x
                 n   /      i
                     ====
                     i = 1
@end group
@end example
>>>)

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c noncentral_moment (s1, 1), numer; /* the mean */
@c s2 : read_matrix (file_search ("wind.data"))$
@c noncentral_moment (s2, 5);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) noncentral_moment (s1, 1), numer; /* the mean */
(%o3)                         4.71
@end group
@group
(%i5) s2 : read_matrix (file_search ("wind.data"))$
@end group
@group
(%i6) noncentral_moment (s2, 5);
(%o6) [319793.8724761505, 320532.1923892463,
      391249.5621381556, 2502278.205988911, 1691881.797742255]
@end group
@end example

See also function @mrefdot{central_moment}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{central_moment}
@c @deffn {Function} central_moment @
m4_deffn({Function}, central_moment, <<<>>>) @
@fname{central_moment} (@var{list}, @var{k}) @
@fname{central_moment} (@var{matrix}, @var{k})

The central moment of order @math{k}, defined as
m4_mathjax(
<<<$${{1\over{n}}{\sum_{i=1}^{n}{(x_{i}-\bar{x})^k}}}$$>>>,
<<<@example
@group
                    n
                  ====
              1   \          _ k
              -    >    (x - x)
              n   /       i
                  ====
                  i = 1
@end group
@end example
>>>)

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c central_moment (s1, 2), numer; /* the variance */
@c s2 : read_matrix (file_search ("wind.data"))$
@c central_moment (s2, 3);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) central_moment (s1, 2), numer; /* the variance */
(%o3)                   8.425899999999999
@end group
(%i5) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i6) central_moment (s2, 3);
(%o6) [11.29584771375004, 16.97988248298583, 5.626661952750102,
                             37.5986572057918, 25.85981904394192]
@end group
@end example

See also functions @mref{central_moment} and @mrefdot{mean}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{cv}
@c @deffn {Function} cv @
m4_deffn({Function}, cv, <<<>>>) @
@fname{cv} (@var{list}) @
@fname{cv} (@var{matrix})

The variation coefficient is the quotient between the sample standard deviation (@mref{std}) and the @mrefcomma{mean}

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c cv (s1), numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c cv (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) cv (s1), numer;
(%o3)                   .6193977819764815
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) cv (s2);
(%o5) [.4192426091090204, .3829365309260502, 0.363779605385983, 
                            .3627381836021478, .3346021393989506]
@end group
@end example

See also functions @mref{std} and @mrefdot{mean}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{smin}
@c @deffn {Function} smin @
m4_deffn({Function}, smin, <<<>>>) @
@fname{smin} (@var{list}) @
@fname{smin} (@var{matrix})

This is the minimum value of the sample @var{list}.
When the argument is a matrix, @mref{smin} returns
a list containing the minimum values of the columns,
which are associated to statistical variables.

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c smin (s1);
@c s2 : read_matrix (file_search ("wind.data"))$
@c smin (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) smin (s1);
(%o3)                           0
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) smin (s2);
(%o5)             [0.58, 0.5, 2.67, 5.25, 5.17]
@end group
@end example

See also function @mrefdot{smax}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{smax}
@c @deffn {Function} smax @
m4_deffn({Function}, smax, <<<>>>) @
@fname{smax} (@var{list}) @
@fname{smax} (@var{matrix})

This is the maximum value of the sample @var{list}.
When the argument is a matrix, @mref{smax} returns
a list containing the maximum values of the columns,
which are associated to statistical variables.

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c smax (s1);
@c s2 : read_matrix (file_search ("wind.data"))$
@c smax (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) smax (s1);
(%o3)                           9
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) smax (s2);
(%o5)          [20.25, 21.46, 20.04, 29.63, 27.63]
@end group
@end example

See also function @mrefdot{smin}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{range}
@c @deffn {Function} range @
m4_deffn({Function}, range, <<<>>>) @
@fname{range} (@var{list}) @
@fname{range} (@var{matrix})

The range is the difference between the extreme values.

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c range (s1);
@c s2 : read_matrix (file_search ("wind.data"))$
@c range (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) range (s1);
(%o3)                           9
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) range (s2);
(%o5)          [19.67, 20.96, 17.37, 24.38, 22.46]
@end group
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{quantile}
@c @deffn {Function} quantile @
m4_deffn({Function}, quantile, <<<>>>) @
@fname{quantile} (@var{list}, @var{p}) @
@fname{quantile} (@var{matrix}, @var{p})

This is the @var{p}-quantile, with @var{p} a number in @math{[0, 1]}, of the sample @var{list}.
Although there are several definitions for the sample quantile (Hyndman, R. J., Fan, Y. (1996) @var{Sample quantiles in statistical packages}. American Statistician, 50, 361-365), the one based on linear interpolation is implemented in package @ref{descriptive-pkg}

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c /* 1st and 3rd quartiles */ 
@c          [quantile (s1, 1/4), quantile (s1, 3/4)], numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c quantile (s2, 1/4);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) /* 1st and 3rd quartiles */
         [quantile (s1, 1/4), quantile (s1, 3/4)], numer;
(%o3)                      [2.0, 7.25]
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) quantile (s2, 1/4);
(%o5)    [7.2575, 7.477500000000001, 7.82, 11.28, 11.48]
@end group
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{median}
@c @deffn {Function} median @
m4_deffn({Function}, median, <<<>>>) @
@fname{median} (@var{list}) @
@fname{median} (@var{matrix})

Once the sample is ordered, if the sample size is odd the median is the central value, otherwise it is the mean of the two central values.

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c median (s1);
@c s2 : read_matrix (file_search ("wind.data"))$
@c median (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) median (s1);
                                9
(%o3)                           -
                                2
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) median (s2);
(%o5)         [10.06, 9.855, 10.73, 15.48, 14.105]
@end group
@end example

The median is the 1/2-quantile.

See also function @mrefdot{quantile}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{qrange}
@c @deffn {Function} qrange @
m4_deffn({Function}, qrange, <<<>>>) @
@fname{qrange} (@var{list}) @
@fname{qrange} (@var{matrix})

The interquartilic range is the difference between the third and first quartiles, @code{quantile(@var{list},3/4) - quantile(@var{list},1/4)},

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c qrange (s1);
@c s2 : read_matrix (file_search ("wind.data"))$
@c qrange (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) qrange (s1);
                               21
(%o3)                          --
                               4
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) qrange (s2);
(%o5) [5.385, 5.572499999999998, 6.022500000000001, 
                            8.729999999999999, 6.649999999999999]
@end group
@end example

See also function @mrefdot{quantile}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{mean_deviation}
@c @deffn {Function} mean_deviation @
m4_deffn({Function}, mean_deviation, <<<>>>) @
@fname{mean_deviation} (@var{list}) @
@fname{mean_deviation} (@var{matrix})

The mean deviation, defined as
m4_mathjax(
<<<$${{1\over{n}}{\sum_{i=1}^{n}{|x_{i}-\bar{x}|}}}$$>>>,
<<<@example
@group
                     n
                   ====
               1   \          _
               -    >    |x - x|
               n   /       i
                   ====
                   i = 1
@end group
@end example
>>>)

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c mean_deviation (s1);
@c s2 : read_matrix (file_search ("wind.data"))$
@c mean_deviation (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) mean_deviation (s1);
                               51
(%o3)                          --
                               20
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) mean_deviation (s2);
(%o5) [3.287959999999999, 3.075342, 3.23907, 4.715664000000001, 
                                               4.028546000000002]
@end group
@end example

See also function @mrefdot{mean}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{median_deviation}
@c @deffn {Function} median_deviation @
m4_deffn({Function}, median_deviation, <<<>>>) @
@fname{median_deviation} (@var{list}) @
@fname{median_deviation} (@var{matrix})

The median deviation, defined as
m4_mathjax(
<<<$${{1\over{n}}{\sum_{i=1}^{n}{|x_{i}-med|}}}$$>>>,
<<<@example
@group
                 n
               ====
           1   \
           -    >    |x - med|
           n   /       i
               ====
               i = 1
@end group
@end example
>>>)
where @code{med} is the median of @var{list}.

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c median_deviation (s1);
@c s2 : read_matrix (file_search ("wind.data"))$
@c median_deviation (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) median_deviation (s1);
                                5
(%o3)                           -
                                2
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) median_deviation (s2);
(%o5)           [2.75, 2.755, 3.08, 4.315, 3.31]
@end group
@end example

See also function @mrefdot{mean}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{harmonic_mean}
@c @deffn {Function} harmonic_mean @
m4_deffn({Function}, harmonic_mean, <<<>>>) @
@fname{harmonic_mean} (@var{list}) @
@fname{harmonic_mean} (@var{matrix})

The harmonic mean, defined as
m4_mathjax(
<<<$${{n}\over{\sum_{i=1}^{n}{{{1}\over{x_{i}}}}}}$$>>>,
<<<@example
@group
                  n
               --------
                n
               ====
               \     1
                >    --
               /     x
               ====   i
               i = 1
@end group
@end example
>>>)

Example:

@c ===beg===
@c load ("descriptive")$
@c y : [5, 7, 2, 5, 9, 5, 6, 4, 9, 2, 4, 2, 5]$
@c harmonic_mean (y), numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c harmonic_mean (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) y : [5, 7, 2, 5, 9, 5, 6, 4, 9, 2, 4, 2, 5]$
@group
(%i3) harmonic_mean (y), numer;
(%o3)                   3.901858027632205
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) harmonic_mean (s2);
(%o5) [6.948015590052786, 7.391967752360356, 9.055658197151745, 
                            13.44199028193692, 13.01439145898509]
@end group
@end example

See also functions @mref{mean} and @mrefdot{geometric_mean}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox

@c @end deffn
m4_end_deffn()



@anchor{geometric_mean}
@c @deffn {Function} geometric_mean @
m4_deffn({Function}, geometric_mean, <<<>>>) @
@fname{geometric_mean} (@var{list}) @
@fname{geometric_mean} (@var{matrix})

The geometric mean, defined as
m4_mathjax(
<<<$$\left(\prod_{i=1}^{n}{x_{i}}\right)^{{{1}\over{n}}}$$>>>,
<<<@example
@group
                 /  n      \ 1/n
                 | /===\   |
                 |  ! !    |
                 |  ! !  x |
                 |  ! !   i|
                 | i = 1   |
                 \         /
@end group
@end example
>>>)

Example:

@c ===beg===
@c load ("descriptive")$
@c y : [5, 7, 2, 5, 9, 5, 6, 4, 9, 2, 4, 2, 5]$
@c geometric_mean (y), numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c geometric_mean (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) y : [5, 7, 2, 5, 9, 5, 6, 4, 9, 2, 4, 2, 5]$
@group
(%i3) geometric_mean (y), numer;
(%o3)                   4.454845412337012
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) geometric_mean (s2);
(%o5) [8.82476274347979, 9.22652604739361, 10.0442675714889, 
                            14.61274126349021, 13.96184163444275]
@end group
@end example

See also functions @mref{mean} and @mrefdot{harmonic_mean}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{kurtosis}
@c @deffn {Function} kurtosis @
m4_deffn({Function}, kurtosis, <<<>>>) @
@fname{kurtosis} (@var{list}) @
@fname{kurtosis} (@var{matrix})

The kurtosis coefficient, defined as
m4_mathjax(
<<<$${{1\over{n s^4}}{\sum_{i=1}^{n}{(x_{i}-\bar{x})^4}}-3}$$>>>,
<<<@example
@group
                    n
                  ====
            1     \          _ 4
           ----    >    (x - x)  - 3
              4   /       i
           n s    ====
                  i = 1
@end group
@end example
>>>)

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c kurtosis (s1), numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c kurtosis (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) kurtosis (s1), numer;
(%o3)                  - 1.273247946514421
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) kurtosis (s2);
(%o5) [- .2715445622195385, 0.119998784429451, 
     - .4275233490482861, - .6405361979019522, - .4952382132352935]
@end group
@end example

See also functions @mrefcomma{mean} @mref{var} and @mrefdot{skewness}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{skewness}
@c @deffn {Function} skewness @
m4_deffn({Function}, skewness, <<<>>>) @
@fname{skewness} (@var{list}) @
@fname{skewness} (@var{matrix})

The skewness coefficient, defined as
m4_mathjax(
<<<$${{1\over{n s^3}}{\sum_{i=1}^{n}{(x_{i}-\bar{x})^3}}}$$>>>,
<<<@example
@group
                    n
                  ====
            1     \          _ 3
           ----    >    (x - x)
              3   /       i
           n s    ====
                  i = 1
@end group
@end example
>>>)

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c skewness (s1), numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c skewness (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) skewness (s1), numer;
(%o3)                  .009196180476450424
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) skewness (s2);
(%o5) [.1580509020000978, .2926379232061854, .09242174416107717, 
                            .2059984348148687, .2142520248890831]
@end group
@end example

See also functions @mrefcomma{mean}, @mref{var} and @mrefdot{kurtosis}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{pearson_skewness}
@c @deffn {Function} pearson_skewness @
m4_deffn({Function}, pearson_skewness, <<<>>>) @
@fname{pearson_skewness} (@var{list}) @
@fname{pearson_skewness} (@var{matrix})

Pearson's skewness coefficient, defined as 
m4_mathjax(
<<<$${{3\,\left(\bar{x}-med\right)}\over{s}}$$>>>,
<<<@example
@group
                _
             3 (x - med)
             -----------
                  s
@end group
@end example
>>>)
where @var{med} is the median of @var{list}.

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c pearson_skewness (s1), numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c pearson_skewness (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) pearson_skewness (s1), numer;
(%o3)                   .2159484029093895
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) pearson_skewness (s2);
(%o5) [- .08019976629211892, .2357036272952649, 
         .1050904062491204, .1245042340592368, .4464181795804519]
@end group
@end example

See also functions @mrefcomma{mean} @mref{var} and @mrefdot{median}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{quartile_skewness}
@c @deffn {Function} quartile_skewness @
m4_deffn({Function}, quartile_skewness, <<<>>>) @
@fname{quartile_skewness} (@var{list}) @
@fname{quartile_skewness} (@var{matrix})

The quartile skewness coefficient, defined as 
m4_mathjax(
<<<$${{c_{{{3}\over{4}}}-2\,c_{{{1}\over{2}}}+c_{{{1}\over{4}}}}\over{c
 _{{{3}\over{4}}}-c_{{{1}\over{4}}}}}$$>>>,
<<<@example
@group
               c    - 2 c    + c
                3/4      1/2    1/4
               --------------------
                   c    - c
                    3/4    1/4
@end group
@end example
>>>)
where @math{c_p} is the @var{p}-quantile of sample @var{list}.

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c quartile_skewness (s1), numer;
@c s2 : read_matrix (file_search ("wind.data"))$
@c quartile_skewness (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
@group
(%i3) quartile_skewness (s1), numer;
(%o3)                  .04761904761904762
@end group
(%i4) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i5) quartile_skewness (s2);
(%o5) [- 0.0408542246982353, .1467025572005382, 
       0.0336239103362392, .03780068728522298, .2105263157894735]
@end group
@end example

See also function @mrefdot{quantile}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{km}
@c @deffn {Function} km @
m4_deffn({Function}, km, <<<>>>) @
@fname{km} (@var{list}, @var{option} ...) @
@fname{km} (@var{matrix}, @var{option} ...)

Kaplan Meier estimator of the survival, or reliability, function @math{S(x)=1-F(x)}.

Data can be introduced as a list of pairs, or as a two column matrix. The first
component is the observed time, and the second component a censoring index 
(1 = non censored, 0 = right censored).

The optional argument is the name of the variable in the returned expression,
which is @var{x} by default.

Examples:

Sample as a list of pairs.

@c ===beg===
@c load ("descriptive")$
@c S: km([[2,1], [3,1], [5,0], [8,1]]);
@c load ("draw")$
@c draw2d(
@c   line_width = 3, grid = true,
@c   explicit(S, x, -0.1, 10))$
@c ===end===
@example
(%i1) load ("descriptive")$
@group
(%i2) S: km([[2,1], [3,1], [5,0], [8,1]]);
                       charfun((3 <= x) and (x < 8))
(%o2) charfun(x < 0) + -----------------------------
                                     2
                3 charfun((2 <= x) and (x < 3))
              + ------------------------------- 
                               4
              + charfun((0 <= x) and (x < 2))
@end group
(%i3) load ("draw")$
@group
(%i4) draw2d(
        line_width = 3, grid = true,
        explicit(S, x, -0.1, 10))$
@end group
@end example

Estimate survival probabilities.

@c ===beg===
@c load ("descriptive")$
@c S(t):= ''(km([[2,1], [3,1], [5,0], [8,1]], t)) $
@c S(6);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) S(t):= ''(km([[2,1], [3,1], [5,0], [8,1]], t)) $
@group
(%i3) S(6);
                            1
(%o3)                       -
                            2
@end group
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{cdf_empirical}
@c @deffn {Function} cdf_empirical @
m4_deffn({Function}, cdf_empirical, <<<>>>) @
@fname{cdf_empirical} (@var{list}, @var{option} ...) @
@fname{cdf_empirical} (@var{matrix}, @var{option} ...)

Empirical distribution function @math{F(x)}.

Data can be introduced as a list of numbers, or as a one column matrix.

The optional argument is the name of the variable in the returned expression,
which is @var{x} by default.

Example:

Empirical distribution function.

@c ===beg===
@c load ("descriptive")$
@c F(x):= ''(cdf_empirical([1,3,3,5,7,7,7,8,9]));
@c F(6);
@c load(draw)$
@c draw2d(
@c    line_width = 3,
@c    grid       = true,
@c    explicit(F(z), z, -2, 12)) $
@c ===end===
@example
(%i1) load ("descriptive")$
@group
(%i2) F(x):= ''(cdf_empirical([1,3,3,5,7,7,7,8,9]));
(%o2) F(x) := (charfun(x >= 9) + charfun(x >= 8)
               + 3 charfun(x >= 7) + charfun(x >= 5)
               + 2 charfun(x >= 3) + charfun(x >= 1))/9
@end group
@group
(%i3) F(6);
                           4
(%o3)                      -
                           9
@end group
(%i4) load(draw)$
(%i5) draw2d(
        line_width = 3,
        grid       = true,
        explicit(F(z), z, -2, 12)) $
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{cov}
@c @deffn {Function} cov (@var{matrix})
m4_deffn({Function}, cov, <<<(@var{matrix})>>>)
The covariance matrix of the multivariate sample, defined as
m4_mathjax(
<<<$${S={1\over{n}}{\sum_{j=1}^{n}{\left(X_{j}-\bar{X}\right)\,\left(X_{j}-\bar{X}\right)'}}}$$>>>,
<<<@example
@group
              n
             ====
          1  \           _        _
      S = -   >    (X  - X) (X  - X)'
          n  /       j        j
             ====
             j = 1
@end group
@end example
>>>)
where @math{X_j} is the @math{j}-th row of the sample matrix.

Example:

@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix (file_search ("wind.data"))$
@c fpprintprec : 7$  /* change precision for pretty output */
@c cov (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
(%i3) fpprintprec : 7$  /* change precision for pretty output */
@group
(%i4) cov (s2);
      [ 17.22191  13.61811  14.37217  19.39624  15.42162 ]
      [                                                  ]
      [ 13.61811  14.98774  13.30448  15.15834  14.9711  ]
      [                                                  ]
(%o4) [ 14.37217  13.30448  15.47573  17.32544  16.18171 ]
      [                                                  ]
      [ 19.39624  15.15834  17.32544  32.17651  20.44685 ]
      [                                                  ]
      [ 15.42162  14.9711   16.18171  20.44685  24.42308 ]
@end group
@end example

See also function @mrefdot{cov1}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{cov1}
@c @deffn {Function} cov1 (@var{matrix})
m4_deffn({Function}, cov1, <<<(@var{matrix})>>>)
The covariance matrix of the multivariate sample, defined as
m4_mathjax(
<<<$${{1\over{n-1}}{\sum_{j=1}^{n}{\left(X_{j}-\bar{X}\right)\,\left(X_{j}-\bar{X}\right)'}}}$$>>>,
<<<@example
@group
              n
             ====
         1   \           _        _
   S  = ---   >    (X  - X) (X  - X)'
    1   n-1  /       j        j
             ====
             j = 1
@end group
@end example
>>>)
where @math{X_j} is the @math{j}-th row of the sample matrix.

Example:

@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix (file_search ("wind.data"))$
@c fpprintprec : 7$ /* change precision for pretty output */
@c cov1 (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
(%i3) fpprintprec : 7$ /* change precision for pretty output */
@group
(%i4) cov1 (s2);
      [ 17.39587  13.75567  14.51734  19.59216  15.5774  ]
      [                                                  ]
      [ 13.75567  15.13913  13.43887  15.31145  15.12232 ]
      [                                                  ]
(%o4) [ 14.51734  13.43887  15.63205  17.50044  16.34516 ]
      [                                                  ]
      [ 19.59216  15.31145  17.50044  32.50153  20.65338 ]
      [                                                  ]
      [ 15.5774   15.12232  16.34516  20.65338  24.66977 ]
@end group
@end example

See also function @mrefdot{cov}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{global_variances}
@c @deffn {Function} global_variances @
m4_deffn({Function}, global_variances, <<<>>>) @
@fname{global_variances} (@var{matrix}) @
@fname{global_variances} (@var{matrix}, @var{options} ...)

Function @code{global_variances} returns a list of global variance measures:

@itemize @bullet
@item
@var{total variance}: @code{trace(S_1)},
@item
@var{mean variance}: @code{trace(S_1)/p},
@item
@var{generalized variance}: @code{determinant(S_1)},
@item
@var{generalized standard deviation}: @code{sqrt(determinant(S_1))},
@item
@var{efective variance} @code{determinant(S_1)^(1/p)}, (defined in: Pe@~na, D. (2002) @var{An@'alisis de datos multivariantes}; McGraw-Hill, Madrid.)
@item
@var{efective standard deviation}: @code{determinant(S_1)^(1/(2*p))}.
@end itemize
where @var{p} is the dimension of the multivariate random variable and @math{S_1} the covariance matrix returned by @code{cov1}.

Option:

@itemize @bullet
@item
@code{'data}, default @code{'true}, indicates whether the input matrix contains the sample data,
in which case the covariance matrix @code{cov1} must be calculated, or not, and then the covariance
matrix (symmetric) must be given, instead of the data.
@end itemize

Example:

@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix (file_search ("wind.data"))$
@c global_variances (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i3) global_variances (s2);
(%o3) [105.338342060606, 21.06766841212119, 12874.34690469686, 
         113.4651792608501, 6.636590811800795, 2.576158149609762]
@end group
@end example

Calculate the @code{global_variances} from the covariance matrix.

@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix (file_search ("wind.data"))$
@c s : cov1 (s2)$
@c global_variances (s, data=false);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
(%i3) s : cov1 (s2)$
@group
(%i4) global_variances (s, data=false);
(%o4) [105.338342060606, 21.06766841212119, 12874.34690469686, 
         113.4651792608501, 6.636590811800795, 2.576158149609762]
@end group
@end example

See also @mref{cov} and @mrefdot{cov1}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{cor}
@c @deffn {Function} cor @
m4_deffn({Function}, cor, <<<>>>) @
@fname{cor} (@var{matrix}) @
@fname{cor} (@var{matrix}, @var{logical_value})

The correlation matrix of the multivariate sample.

Option:

@itemize @bullet
@item
@code{'data}, default @code{'true}, indicates whether the input matrix contains the sample data,
in which case the covariance matrix @code{cov1} must be calculated, or not, and then the covariance
matrix (symmetric) must be given, instead of the data.
@end itemize

Example:

@c ===beg===
@c load ("descriptive")$
@c fpprintprec : 7 $
@c s2 : read_matrix (file_search ("wind.data"))$
@c cor (s2);
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) fpprintprec : 7 $
(%i3) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i4) cor (s2);
      [   1.0     .8476339  .8803515  .8239624  .7519506 ]
      [                                                  ]
      [ .8476339    1.0     .8735834  .6902622  0.782502 ]
      [                                                  ]
(%o4) [ .8803515  .8735834    1.0     .7764065  .8323358 ]
      [                                                  ]
      [ .8239624  .6902622  .7764065    1.0     .7293848 ]
      [                                                  ]
      [ .7519506  0.782502  .8323358  .7293848    1.0    ]
@end group
@end example

Calculate de correlation matrix from the covariance matrix.

@c ===beg===
@c load ("descriptive")$
@c fpprintprec : 7 $
@c s2 : read_matrix (file_search ("wind.data"))$
@c s : cov1 (s2)$
@c cor (s, data=false); /* this is faster */
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) fpprintprec : 7 $
(%i3) s2 : read_matrix (file_search ("wind.data"))$
(%i4) s : cov1 (s2)$
@group
(%i5) cor (s, data=false); /* this is faster */
      [   1.0     .8476339  .8803515  .8239624  .7519506 ]
      [                                                  ]
      [ .8476339    1.0     .8735834  .6902622  0.782502 ]
      [                                                  ]
(%o5) [ .8803515  .8735834    1.0     .7764065  .8323358 ]
      [                                                  ]
      [ .8239624  .6902622  .7764065    1.0     .7293848 ]
      [                                                  ]
      [ .7519506  0.782502  .8323358  .7293848    1.0    ]
@end group
@end example

See also @mref{cov} and @mrefdot{cov1}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@anchor{list_correlations}
@c @deffn {Function} list_correlations @
m4_deffn({Function}, list_correlations, <<<>>>) @
@fname{list_correlations} (@var{matrix}) @
@fname{list_correlations} (@var{matrix}, @var{options} ...)

Function @code{list_correlations} returns a list of correlation measures:

@itemize @bullet

@item
@var{precision matrix}: the inverse of the covariance matrix @math{S_1},
m4_mathjax(
<<<$${S_{1}^{-1}}={\left(s^{ij}\right)_{i,j=1,2,\ldots, p}}$$>>>,
<<<@example
@group
       -1     ij
      S   = (s  )             
       1         i,j = 1,2,...,p
@end group
@end example
>>>)

@item
@var{multiple correlation vector}:  @math{(R_1^2, R_2^2, ..., R_p^2)}, with 
m4_mathjax(
<<<$${R_{i}^{2}}={1-{{1}\over{s^{ii}s_{ii}}}}$$>>>,
<<<@example
@group
       2          1
      R  = 1 - -------
       i        ii
               s   s
                    ii
@end group
@end example
>>>)
being an indicator of the goodness of fit of the linear multivariate regression model on @math{X_i} when the rest of variables are used as regressors.

@item
@var{partial correlation matrix}: with element @math{(i, j)} being
m4_mathjax(
<<<$${r_{ij.rest}}={-{{s^{ij}}\over \sqrt{s^{ii}s^{jj}}}}$$>>>,
<<<@example
@group
                         ij
                        s
      r        = - ------------
       ij.rest     / ii  jj\ 1/2
                   |s   s  |
                   \       /
@end group
@end example
>>>)

@end itemize

Option:

@itemize @bullet
@item
@code{'data}, default @code{'true}, indicates whether the input matrix contains the sample data,
in which case the covariance matrix @code{cov1} must be calculated, or not, and then the covariance
matrix (symmetric) must be given, instead of the data.
@end itemize

Example:

@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix (file_search ("wind.data"))$
@c z : list_correlations (s2)$
@c fpprintprec : 5$ /* for pretty output */
@c z[1];  /* precision matrix */
@c z[2];  /* multiple correlation vector */
@c z[3];  /* partial correlation matrix */
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
(%i3) z : list_correlations (s2)$
(%i4) fpprintprec : 5$ /* for pretty output */
@group
(%i5) z[1];  /* precision matrix */
      [  .38486   - .13856   - .15626   - .10239    .031179  ]
      [                                                      ]
      [ - .13856   .34107    - .15233    .038447   - .052842 ]
      [                                                      ]
(%o5) [ - .15626  - .15233    .47296    - .024816  - .10054  ]
      [                                                      ]
      [ - .10239   .038447   - .024816   .10937    - .034033 ]
      [                                                      ]
      [ .031179   - .052842  - .10054   - .034033   .14834   ]
@end group
@group
(%i6) z[2];  /* multiple correlation vector */
(%o6)      [.85063, .80634, .86474, .71867, .72675]
@end group
@group
(%i7) z[3];  /* partial correlation matrix */
      [  - 1.0     .38244   .36627   .49908   - .13049 ]
      [                                                ]
      [  .38244    - 1.0    .37927  - .19907   .23492  ]
      [                                                ]
(%o7) [  .36627    .37927   - 1.0    .10911    .37956  ]
      [                                                ]
      [  .49908   - .19907  .10911   - 1.0     .26719  ]
      [                                                ]
      [ - .13049   .23492   .37956   .26719    - 1.0   ]
@end group
@end example

See also @mref{cov} and @mrefdot{cov1}

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()




@anchor{principal_components}
@c @deffn {Function} principal_components @
m4_deffn({Function}, principal_components, <<<>>>) @
@fname{principal_components} (@var{matrix}) @
@fname{principal_components} (@var{matrix}, @var{options} ...)

Calculates the principal componentes of a multivariate sample. Principal components are
used in multivariate statistical analysis to reduce the dimensionality of the sample.

Option:

@itemize @bullet
@item
@code{'data}, default @code{'true}, indicates whether the input matrix contains the sample data,
in which case the covariance matrix @mref{cov1} must be calculated, or not, and then the covariance
matrix (symmetric) must be given, instead of the data.
@end itemize

The output of function @code{principal_components} is a list with the following results:

@itemize @bullet
@item
variances of the principal components,
@item
percentage of total variance explained by each principal component,
@item
rotation matrix.
@end itemize

Examples:

In this sample, the first component explains 83.13 per cent of total 
variance.

@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
(%i3) fpprintprec:4 $
(%i4) res: principal_components(s2);
0 errors, 0 warnings
(%o4) [[87.57, 8.753, 5.515, 1.889, 1.613], 
[83.13, 8.31, 5.235, 1.793, 1.531], 
@group
[ .4149  .03379   - .4757  - 0.581   - .5126 ]
[                                            ]
[ 0.369  - .3657  - .4298   .7237    - .1469 ]
[                                            ]
[ .3959  - .2178  - .2181  - .2749    .8201  ]]
[                                            ]
[ .5548   .7744    .1857    .2319    .06498  ]
[                                            ]
[ .4765  - .4669   0.712   - .09605  - .1969 ]
@end group
(%i5) /* accumulated percentages  */
    block([ap: copy(res[2])],
      for k:2 thru length(ap) do ap[k]: ap[k]+ap[k-1],
      ap);
(%o5)                 [83.13, 91.44, 96.68, 98.47, 100.0]
(%i6) /* sample dimension */
      p: length(first(res));
(%o6)                                  5
(%i7) /* plot percentages to select number of
         principal components for further work */
     draw2d(
        fill_density = 0.2,
        apply(bars, makelist([k, res[2][k], 1/2], k, p)),
        points_joined = true,
        point_type    = filled_circle,
        point_size    = 3,
        points(makelist([k, res[2][k]], k, p)),
        xlabel = "Variances",
        ylabel = "Percentages",
        xtics  = setify(makelist([concat("PC",k),k], k, p))) $
@end example

In case de covariance matrix is known, it can be passed to the function,
but option @code{data=false} must be used.

@example
(%i1) load ("descriptive")$
(%i2) S: matrix([1,-2,0],[-2,5,0],[0,0,2]);
                                [  1   - 2  0 ]
                                [             ]
(%o2)                           [ - 2   5   0 ]
                                [             ]
                                [  0    0   2 ]
(%i3) fpprintprec:4 $
(%i4) /* the argumment is a covariance matrix */
      res: principal_components(S, data=false);
0 errors, 0 warnings
                                                  [ - .3827  0.0  .9239 ]
                                                  [                     ]
(%o4) [[5.828, 2.0, .1716], [72.86, 25.0, 2.145], [  .9239   0.0  .3827 ]]
                                                  [                     ]
                                                  [   0.0    1.0   0.0  ]
(%i5) /* transformation to get the principal components
         from original records */
      matrix([a1,b2,c3],[a2,b2,c2]).last(res);
             [ .9239 b2 - .3827 a1  1.0 c3  .3827 b2 + .9239 a1 ]
(%o5)        [                                                  ]
             [ .9239 b2 - .3827 a2  1.0 c2  .3827 b2 + .9239 a2 ]
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @closecatbox
@c @end deffn
m4_end_deffn()



@node Functions and Variables for statistical graphs,  , Functions and Variables for descriptive statistics, descriptive-pkg
@section Functions and Variables for statistical graphs



m4_setcat(Package descriptive, Plotting)
@anchor{barsplot}
@c @deffn {Function} barsplot (@var{data1}, @var{data2}, @dots{}, @var{option_1}, @var{option_2}, @dots{})
m4_deffn({Function}, barsplot, <<<(@var{data1}, @var{data2}, @dots{}, @var{option_1}, @var{option_2}, @dots{})>>>)

Plots bars diagrams for discrete statistical variables,
both for one or multiple samples.

@var{data} can be a list of outcomes representing one sample, or a 
matrix of @var{m} rows and @var{n} columns, representing @var{n} samples of size 
@var{m} each.

Available options are:

@itemize @bullet

@item
@var{box_width} (default, @code{3/4}): relative width of rectangles. This 
value must be in the range @code{[0,1]}.

@item
@var{grouping} (default, @code{clustered}): indicates how multiple samples are
shown. Valid values are: @code{clustered} and @code{stacked}.

@item
@var{groups_gap} (default, @code{1}): a positive integer number representing 
the gap between two consecutive groups of bars.

@item
@var{bars_colors} (default, @code{[]}): a list of colors for multiple samples.
When there are more samples than specified colors, the extra necessary colors 
are chosen at random. See @code{color} to learn more about them.

@item
@var{frequency} (default, @code{absolute}): indicates the scale of the
ordinates. Possible values are:  @code{absolute}, @code{relative}, 
and @code{percent}.

@item
@var{ordering} (default, @code{orderlessp}): possible values are @code{orderlessp} or @code{ordergreatp},
indicating how statistical outcomes should be ordered on the @var{x}-axis.

@item
@var{sample_keys} (default, @code{[]}): a list with the strings to be used in the legend.
When the list length is other than 0 or the number of samples, an error message is returned.

@item
@var{start_at} (default, @code{0}): indicates where the plot begins to be plotted on the
x axis.

@item
All global @code{draw} options, except @code{xtics}, which is 
internally assigned by @code{barsplot}.
If you want to set your own values for this option or want to build
complex scenes, make use of @code{barsplot_description}. See example below.

@item
The following local @ref{draw-pkg} options: @mrefcomma{key} @mrefcomma{color_draw}
@mrefcomma{fill_color} @mref{fill_density} and @mrefdot{line_width}
See also
@mrefdot{barsplot}

@end itemize

There is also a function @code{wxbarsplot} for creating embedded
histograms in interfaces wxMaxima and iMaxima.  @code{barsplot} in a
multiplot context.

Examples:

Univariate sample in matrix form. Absolute frequencies.

@c ===beg===
@c load ("descriptive")$
@c m : read_matrix (file_search ("biomed.data"))$
@c barsplot(
@c   col(m,2),
@c   title        = "Ages",
@c   xlabel       = "years",
@c   box_width    = 1/2,
@c   fill_density = 3/4)$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) m : read_matrix (file_search ("biomed.data"))$
@group
(%i3) barsplot(
        col(m,2),
        title        = "Ages",
        xlabel       = "years",
        box_width    = 1/2,
        fill_density = 3/4)$
@end group
@end example

Two samples of different sizes, with
relative frequencies and user declared colors.

@c ===beg===
@c load ("descriptive")$
@c l1:makelist(random(10),k,1,50)$
@c l2:makelist(random(10),k,1,100)$
@c barsplot(
@c    l1,l2,
@c    box_width = 1,
@c    fill_density = 1,
@c    bars_colors = [black, grey],
@c    frequency = relative,
@c    sample_keys = ["A", "B"])$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) l1:makelist(random(10),k,1,50)$
(%i3) l2:makelist(random(10),k,1,100)$
@group
(%i4) barsplot(
        l1,l2,
        box_width    = 1,
        fill_density = 1,
        bars_colors  = [black, grey],
        frequency = relative,
        sample_keys = ["A", "B"])$
@end group
@end example

Four non numeric samples of equal size.

@c ===beg===
@c load ("descriptive")$
@c barsplot(
@c   makelist([Yes, No, Maybe][random(3)+1],k,1,50),
@c   makelist([Yes, No, Maybe][random(3)+1],k,1,50),
@c   makelist([Yes, No, Maybe][random(3)+1],k,1,50),
@c   makelist([Yes, No, Maybe][random(3)+1],k,1,50),
@c   title      = "Asking for something to four groups",
@c   ylabel     = "# of individuals",
@c   groups_gap = 3,
@c   fill_density = 0.5,
@c   ordering = ordergreatp)$
@c ===end===
@example
(%i1) load ("descriptive")$
@group
(%i2) barsplot(
        makelist([Yes, No, Maybe][random(3)+1],k,1,50),
        makelist([Yes, No, Maybe][random(3)+1],k,1,50),
        makelist([Yes, No, Maybe][random(3)+1],k,1,50),
        makelist([Yes, No, Maybe][random(3)+1],k,1,50),
        title  = "Asking for something to four groups",
        ylabel = "# of individuals",
        groups_gap   = 3,
        fill_density = 0.5,
        ordering     = ordergreatp)$
@end group
@end example

Stacked bars.

@c ===beg===
@c load ("descriptive")$
@c barsplot(
@c   makelist([Yes, No, Maybe][random(3)+1],k,1,50),
@c   makelist([Yes, No, Maybe][random(3)+1],k,1,50),
@c   makelist([Yes, No, Maybe][random(3)+1],k,1,50),
@c   makelist([Yes, No, Maybe][random(3)+1],k,1,50),
@c   title      = "Asking for something to four groups",
@c   ylabel     = "# of individuals",
@c   grouping   = stacked,
@c   fill_density = 0.5,
@c   ordering = ordergreatp)$
@c ===end===
@example
(%i1) load ("descriptive")$
@group
(%i2) barsplot(
        makelist([Yes, No, Maybe][random(3)+1],k,1,50),
        makelist([Yes, No, Maybe][random(3)+1],k,1,50),
        makelist([Yes, No, Maybe][random(3)+1],k,1,50),
        makelist([Yes, No, Maybe][random(3)+1],k,1,50),
        title  = "Asking for something to four groups",
        ylabel = "# of individuals",
        grouping     = stacked,
        fill_density = 0.5,
        ordering     = ordergreatp)$
@end group
@end example

For bars diagrams related options, see @mref{barsplot} of package @ref{draw-pkg}
See also functions @mref{histogram} and @mrefdot{piechart}

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{barsplot_description}
@c @deffn {Function} barsplot_description (@dots{})
m4_deffn({Function}, barsplot_description, <<<(@dots{})>>>)

Function @code{barsplot_description} creates a graphic object
suitable for creating complex scenes, together with other
graphic objects.

Example: @code{barsplot} in a multiplot context.

@example
(%i1) load ("descriptive")$
(%i2) l1:makelist(random(10),k,1,50)$
(%i3) l2:makelist(random(10),k,1,100)$
(%i4) bp1 : 
        barsplot_description(
         l1,
         box_width = 1,
         fill_density = 0.5,
         bars_colors = [blue],
         frequency = relative)$
(%i5) bp2 : 
        barsplot_description(
         l2,
         box_width = 1,
         fill_density = 0.5,
         bars_colors = [red],
         frequency = relative)$
(%i6) draw(gr2d(bp1), gr2d(bp2))$
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{boxplot}
@c @deffn {Function} boxplot (@var{data}) @
m4_deffn({Function}, boxplot, <<<(@var{data}) @>>>)
@fname{boxplot} (@var{data}, @var{option_1}, @var{option_2}, @dots{})

This function plots box-and-whisker diagrams. Argument @var{data} can be a list,
which is not of great interest, since these diagrams are mainly used for
comparing different samples, or a matrix, so it is possible to compare
two or more components of a multivariate statistical variable. 
But it is also allowed @var{data} to be a list of samples with 
possible different sample sizes, in fact this is the only function 
in package @code{descriptive} that admits this type of data structure.

The box is plotted from the first quartile to the third, with an horizontal
segment situated at the second quartile or median. By default, lower and 
upper whiskers are plotted at the minimum and maximum values,
respectively. Option @var{range} can be used to indicate that values greater
than @code{quantile(x,3/4)+range*(quantile(x,3/4)-quantile(x,1/4))} or 
less than @code{quantile(x,1/4)-range*(quantile(x,3/4)-quantile(x,1/4))}
must be considered as outliers, in which case they are plotted as
isolated points, and the whiskers are located at the extremes of the rest of
the sample.

Available options are:

@itemize @bullet

@item
@var{box_width} (default, @code{3/4}): relative width of boxes.
This  value must be in the range @code{[0,1]}.

@item
@var{box_orientation} (default, @code{vertical}): possible values: @code{vertical}
and @code{horizontal}.

@item
@var{range} (default, @code{inf}): positive coefficient of the interquartilic range
to set outliers boundaries.

@item
@var{outliers_size} (default, @code{1}): circle size for isolated outliers.

@item
All @code{draw} options, except @code{points_joined}, @code{point_size}, @code{point_type},
@code{xtics}, @code{ytics}, @code{xrange}, and @code{yrange}, which are
internally assigned by @code{boxplot}.
If you want to set your own values for this options or want to build
complex scenes, make use of @code{boxplot_description}.

@item
The following local @code{draw} options: @code{key}, @code{color}, 
and @code{line_width}.

@end itemize

There is also a function @code{wxboxplot} for creating embedded
histograms in interfaces wxMaxima and iMaxima.

Examples:

Box-and-whisker diagram from a multivariate sample.

@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix(file_search("wind.data"))$
@c boxplot(s2,
@c   box_width  = 0.2,
@c   title      = "Windspeed in knots",
@c   xlabel     = "Stations",
@c   color      = red,
@c   line_width = 2)$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix(file_search("wind.data"))$
@group
(%i3) boxplot(s2,
        box_width  = 0.2,
        title      = "Windspeed in knots",
        xlabel     = "Stations",
        color      = red,
        line_width = 2)$
@end group
@end example

Box-and-whisker diagram from three samples of different sizes.

@c ===beg===
@c load ("descriptive")$
@c A :
@c  [[6, 4, 6, 2, 4, 8, 6, 4, 6, 4, 3, 2],
@c   [8, 10, 7, 9, 12, 8, 10],
@c   [16, 13, 17, 12, 11, 18, 13, 18, 14, 12]]$
@c boxplot (A, box_orientation = horizontal)$
@c ===end===
@example
(%i1) load ("descriptive")$
@group
(%i2) A :
       [[6, 4, 6, 2, 4, 8, 6, 4, 6, 4, 3, 2],
        [8, 10, 7, 9, 12, 8, 10],
        [16, 13, 17, 12, 11, 18, 13, 18, 14, 12]]$
@end group
(%i3) boxplot (A, box_orientation = horizontal)$
@end example

Option @var{range} can be used to handle outliers.

@c ===beg===
@c  load ("descriptive")$
@c  B: [[7, 15, 5, 8, 6, 5, 7, 3, 1],
@c      [10, 8, 12, 8, 11, 9, 20],
@c      [23, 17, 19, 7, 22, 19]] $
@c  boxplot (B, range=1)$
@c  boxplot (B, range=1.5, box_orientation = horizontal)$
@c  draw2d(
@c     boxplot_description(
@c        B,
@c        range            = 1.5,
@c        line_width       = 3,
@c        outliers_size    = 2,
@c        color            = red,
@c        background_color = light_gray),
@c     xtics = {["Low",1],["Medium",2],["High",3]}) $
@c ===end===

@example
(%i1) load ("descriptive")$
(%i2) B: [[7, 15, 5, 8, 6, 5, 7, 3, 1],
          [10, 8, 12, 8, 11, 9, 20],
          [23, 17, 19, 7, 22, 19]] $
@group
(%i3) boxplot (B, range=1)$
(%i4) boxplot (B, range=1.5, box_orientation = horizontal)$
@end group
@group
(%i5) draw2d(
        boxplot_description(
          B,
          range            = 1.5,
          line_width       = 3,
          outliers_size    = 2,
          color            = red,
          background_color = light_gray),
        xtics = @{["Low",1],["Medium",2],["High",3]@}) $
@end group
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{boxplot_description}
@c @deffn {Function} boxplot_description (@dots{})
m4_deffn({Function}, boxplot_description, <<<(@dots{})>>>)

Function @code{boxplot_description} creates a graphic object
suitable for creating complex scenes, together with other
graphic objects. 

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{histogram}
@c @deffn {Function} histogram @
m4_deffn({Function}, histogram, <<<>>>) @
@fname{histogram} (@var{list}) @
@fname{histogram} (@var{list}, @var{option_1}, @var{option_2}, @dots{}) @
@fname{histogram} (@var{one_column_matrix}) @
@fname{histogram} (@var{one_column_matrix}, @var{option_1}, @var{option_2}, @dots{}) @
@fname{histogram} (@var{one_row_matrix}) @
@fname{histogram} (@var{one_row_matrix}, @var{option_1}, @var{option_2}, @dots{})

This function plots an histogram from a continuous sample.
Sample data must be stored in a list of numbers or a one dimensional matrix.

Available options are:

@itemize @bullet

@item
@var{nclasses} (default, @code{10}): number of classes of the histogram, or
a list indicating the limits of the classes and the number of them, or
only the limits. This option also accepts bounds for varying bin widths, or
a symbol with the name of one of the three optimal algorithms available for
the number of classes: @code{'fd} (Freedman, D. and Diaconis, P. (1981) On the 
histogram as a density estimator: L_2 theory. Zeitschrift fuer 
Wahrscheinlichkeitstheorie und verwandte Gebiete 57, 453-476.), @code{'scott}
(Scott, D. W. (1979) On optimal and data-based histograms. Biometrika 66, 
605-610.), and @code{'sturges} (Sturges, H. A. (1926) The choice of a class
interval. Journal of the American Statistical Association 21, 65-66).

@item
@var{frequency} (default, @code{absolute}): indicates the scale of the
ordinates. Possible values are:  @code{absolute}, @code{relative},  @code{percent},
and @code{density}. With @code{density}, the histogram area has a total area of one.

@item
@var{htics} (default, @code{auto}): format of the histogram tics. Possible
values are: @code{auto}, @code{endpoints}, @code{intervals}, or a list
of labels. 

@item
All global @code{draw} options, except @code{xrange}, @code{yrange}, 
and @code{xtics}, which are internally assigned by @code{histogram}.
If you want to set your own values for these options, make use of 
@code{histogram_description}. See examples bellow.

@item
The following local @ref{draw-pkg} options: @mrefcomma{key} @mrefcomma{color}
@mrefcomma{fill_color} @mref{fill_density} and @mrefdot{line_width} See also
@mrefdot{barsplot}

@end itemize

There is also a function @code{wxhistogram} for creating embedded
histograms in interfaces wxMaxima and iMaxima.

Examples:

A simple with eight classes:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c histogram (
@c      s1,
@c      nclasses     = 8,
@c      title        = "pi digits",
@c      xlabel       = "digits",
@c      ylabel       = "Absolute frequency",
@c      fill_color   = grey,
@c      fill_density = 0.6)$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
(%i3) histogram (
           s1,
           nclasses     = 8,
           title        = "pi digits",
           xlabel       = "digits",
           ylabel       = "Absolute frequency",
           fill_color   = grey,
           fill_density = 0.6)$
@end example

Setting the limits of the histogram to -2 and 12, with 3 classes.
Also, we introduce predefined tics:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c histogram (
@c      s1,
@c      nclasses     = [-2,12,3],
@c      htics        = ["A", "B", "C"],
@c      terminal     = png,
@c      fill_color   = "#23afa0",
@c      fill_density = 0.6)$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
(%i3) histogram (
           s1,
           nclasses     = [-2,12,3],
           htics        = ["A", "B", "C"],
           terminal     = png,
           fill_color   = "#23afa0",
           fill_density = 0.6)$
@end example

Bounds for varying bin widths.

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c histogram (s1, nclasses = {0,3,6,7,11})$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
(%i3) histogram (s1, nclasses = @{0,3,6,7,11@})$
@end example

Freedmann - Diakonis robust method for optimal search of the number of classes.

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c histogram histogram(s1, nclasses=fd) $
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
(%i3) histogram(s1, nclasses=fd) $
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{histogram_description}
@c @deffn {Function} histogram_description (@dots{})
m4_deffn({Function}, histogram_description, <<<(@dots{})>>>)

Function @code{histogram_description} creates a graphic object
suitable for creating complex scenes, together with other
graphic objects. We make use of @code{histogram_description} for setting 
the @code{xrange} and adding an explicit curve into the scene:

@example
(%i1) load ("descriptive")$
(%i2) ( load("distrib"),
        m: 14, s: 2,
        s2: random_normal(m, s, 1000) ) $
(%i3) draw2d(
        grid   = true,
        xrange = [5, 25],
        histogram_description(
          s2,
          nclasses     = 9,
          frequency    = density,
          fill_density = 0.5),
        explicit(pdf_normal(x,m,s), x, m - 3*s, m + 3* s))$
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{piechart}
@c @deffn {Function} piechart @
m4_deffn({Function}, piechart, <<<>>>) @
@fname{piechart} (@var{list}) @
@fname{piechart} (@var{list}, @var{option_1}, @var{option_2}, @dots{}) @
@fname{piechart} (@var{one_column_matrix}) @
@fname{piechart} (@var{one_column_matrix}, @var{option_1}, @var{option_2}, @dots{}) @
@fname{piechart} (@var{one_row_matrix}) @
@fname{piechart} (@var{one_row_matrix}, @var{option_1}, @var{option_2}, @dots{})

Similar to @code{barsplot}, but plots sectors instead of rectangles.

Available options are:

@itemize @bullet

@item
@var{sector_colors} (default, @code{[]}): a list of colors for sectors.
When there are more sectors than specified colors, the extra necessary colors 
are chosen at random. See @code{color} to learn more about them.

@item
@var{pie_center} (default, @code{[0,0]}): diagram's center.

@item
@var{pie_radius} (default, @code{1}): diagram's radius.

@item
All global @code{draw} options, except @code{key}, which is 
internally assigned by @code{piechart}.
If you want to set your own values for this option or want to build
complex scenes, make use of @code{piechart_description}.

@item
The following local @code{draw} options: @code{key}, @code{color}, 
@code{fill_density} and @code{line_width}. See also
@code{ellipse}

@end itemize

There is also a function @code{wxpiechart} for 
creating embedded histograms in interfaces wxMaxima and iMaxima.

Example:

@c ===beg===
@c load ("descriptive")$
@c s1 : read_list (file_search ("pidigits.data"))$
@c piechart(
@c   s1,
@c   xrange = [-1.1, 1.3],
@c   yrange = [-1.1, 1.1],
@c   title  = "Digit frequencies in pi")$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s1 : read_list (file_search ("pidigits.data"))$
(%i3) piechart(
        s1,
        xrange  = [-1.1, 1.3],
        yrange  = [-1.1, 1.1],
        title   = "Digit frequencies in pi")$
@end example

See also function @mrefdot{barsplot}

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{piechart_description}
@c @deffn {Function} piechart_description (@dots{})
m4_deffn({Function}, piechart_description, <<<(@dots{})>>>)

Function @code{piechart_description} creates a graphic object
suitable for creating complex scenes, together with other
graphic objects.

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{scatterplot}
@c @deffn {Function} scatterplot @
m4_deffn({Function}, scatterplot, <<<>>>) @
@fname{scatterplot} (@var{list}) @
@fname{scatterplot} (@var{list}, @var{option_1}, @var{option_2}, @dots{}) @
@fname{scatterplot} (@var{matrix}) @
@fname{scatterplot} (@var{matrix}, @var{option_1}, @var{option_2}, @dots{})

Plots scatter diagrams both for univariate (@var{list}) and multivariate 
(@var{matrix}) samples.

Available options are the same admitted by @code{histogram}.

There is also a function @code{wxscatterplot} for 
creating embedded histograms in interfaces wxMaxima and iMaxima.

Examples:

Univariate scatter diagram from a simulated Gaussian sample. 

@c ===beg===
@c load ("descriptive")$
@c load ("distrib")$
@c scatterplot(
@c   random_normal(0,1,200),
@c   xaxis      = true,
@c   point_size = 2,
@c   dimensions = [600,150])$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) load ("distrib")$
@group
(%i3) scatterplot(
        random_normal(0,1,200),
        xaxis      = true,
        point_size = 2,
        dimensions = [600,150])$
@end group
@end example

Two dimensional scatter plot.

@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix (file_search ("wind.data"))$
@c scatterplot(
@c  submatrix(s2, 1,2,3),
@c  title      = "Data from stations #4 and #5",
@c  point_type = diamant,
@c  point_size = 2,
@c  color      = blue)$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i3) scatterplot(
       submatrix(s2, 1,2,3),
       title      = "Data from stations #4 and #5",
       point_type = diamant,
       point_size = 2,
       color      = blue)$
@end group
@end example

Three dimensional scatter plot.

@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix (file_search ("wind.data"))$
@c scatterplot(submatrix (s2, 1,2), nclasses=4)$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
(%i3) scatterplot(submatrix (s2, 1,2), nclasses=4)$
@end example

Five dimensional scatter plot, with five classes histograms.

@c ===beg===
@c load ("descriptive")$
@c s2 : read_matrix (file_search ("wind.data"))$
@c scatterplot(
@c   s2,
@c   nclasses     = 5,
@c   frequency    = relative,
@c   fill_color   = blue,
@c   fill_density = 0.3,
@c   xtics        = 5)$
@c ===end===
@example
(%i1) load ("descriptive")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
@group
(%i3) scatterplot(
        s2,
        nclasses     = 5,
        frequency    = relative,
        fill_color   = blue,
        fill_density = 0.3,
        xtics        = 5)$
@end group
@end example

For plotting isolated or line-joined points in two and three dimensions,
see @code{points}. See also @mrefdot{histogram}

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{scatterplot_description}
@c @deffn {Function} scatterplot_description (@dots{})
m4_deffn({Function}, scatterplot_description, <<<(@dots{})>>>)

Function @code{scatterplot_description} creates a graphic object
suitable for creating complex scenes, together with other
graphic objects.

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{starplot}
@c @deffn {Function} starplot (@var{data1}, @var{data2}, @dots{}, @var{option_1}, @var{option_2}, @dots{})
m4_deffn({Function}, starplot, <<<(@var{data1}, @var{data2}, @dots{}, @var{option_1}, @var{option_2}, @dots{})>>>)

Plots star diagrams for discrete statistical variables,
both for one or multiple samples.

@var{data} can be a list of outcomes representing one sample, or a 
matrix of @var{m} rows and @var{n} columns, representing @var{n} samples of size 
@var{m} each.

Available options are:

@itemize @bullet

@item
@var{stars_colors} (default, @code{[]}): a list of colors for multiple samples.
When there are more samples than specified colors, the extra necessary colors 
are chosen at random. See @code{color} to learn more about them.

@item
@var{frequency} (default, @code{absolute}): indicates the scale of the
radii. Possible values are:  @code{absolute} and @code{relative}.

@item
@var{ordering} (default, @code{orderlessp}): possible values are @code{orderlessp} or @code{ordergreatp},
indicating how statistical outcomes should be ordered.

@item
@var{sample_keys} (default, @code{[]}): a list with the strings to be used in the legend.
When the list length is other than 0 or the number of samples, an error message is returned.


@item
@var{star_center} (default, @code{[0,0]}): diagram's center.

@item
@var{star_radius} (default, @code{1}): diagram's radius.

@item
All global @code{draw} options, except @code{points_joined}, @code{point_type}, 
and @code{key}, which are internally assigned by @code{starplot}.
If you want to set your own values for this options or want to build
complex scenes, make use of @code{starplot_description}.

@item
The following local @code{draw} option: @code{line_width}.

@end itemize

There is also a function @code{wxstarplot} for 
creating embedded histograms in interfaces wxMaxima and iMaxima.

Example:

Plot based on absolute frequencies.
Location and radius defined by the user. 

@example
(%i1) load ("descriptive")$
(%i2) l1: makelist(random(10),k,1,50)$
(%i3) l2: makelist(random(10),k,1,200)$
@group
(%i4) starplot(
        l1, l2,
        stars_colors = [blue,red],
        sample_keys = ["1st sample", "2nd sample"],
        star_center = [1,2],
        star_radius = 4,
        proportional_axes = xy,
        line_width = 2 ) $ 
@end group
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{starplot_description}
@c @deffn {Function} starplot_description (@dots{})
m4_deffn({Function}, starplot_description, <<<(@dots{})>>>)

Function @code{starplot_description} creates a graphic object
suitable for creating complex scenes, together with other
graphic objects. 

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@anchor{stemplot}
@c @deffn {Function} stemplot @
m4_deffn({Function}, stemplot, <<<>>>) @
@fname{stemplot} (@var{data}) @
@fname{stemplot} (@var{data}, @var{option})

Plots stem and leaf diagrams.

Unique available option is:

@itemize @bullet

@item
@var{leaf_unit} (default, @code{1}): indicates the unit of the leaves; must be a
power of 10.

@end itemize

Example:

@example
(%i1) load ("descriptive")$
(%i2) load(distrib)$
@group
(%i3) stemplot(
        random_normal(15, 6, 100),
        leaf_unit = 0.1);
-5|4
 0|37
 1|7
 3|6
 4|4
 5|4
 6|57
 7|0149
 8|3
 9|1334588
10|07888
11|01144467789
12|12566889
13|24778
14|047
15|223458
16|4
17|11557
18|000247
19|4467799
20|00
21|1
22|2335
23|01457
24|12356
25|455
27|79
key: 6|3 =  6.3
(%o3)                  done
@end group
@end example

@c @opencatbox
@c @category{Package descriptive}
@c @category{Plotting}
@c @closecatbox
@c @end deffn
m4_end_deffn()

