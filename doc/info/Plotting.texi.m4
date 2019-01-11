@c -*- Mode: texinfo -*-
@menu
* Introduction to Plotting::
* Plotting Formats::
* Functions and Variables for Plotting::
* Plotting Options::
* Gnuplot Options::
* Gnuplot_pipes Format Functions::
@end menu

@c -----------------------------------------------------------------------------
@node Introduction to Plotting, Plotting Formats, Plotting, Plotting
@section Introduction to Plotting
@c -----------------------------------------------------------------------------

Maxima uses an external plotting package to make the plots (see the
section on @mref{Plotting Formats}).  The plotting functions calculate a
set of points and pass them to the plotting package together with a set
of commands.  That information can be passed to the external program
either through a pipe or by calling the program with the name of a file
where the data has been saved.  The data file is given the name
@code{maxout_xxx.format}, where @code{xxx} is a number that is unique
to every concurrently-running instance of Maxima and @code{format} is
the name of the plotting format being used (@code{gnuplot},
@code{xmaxima}, @code{mgnuplot}, @code{gnuplot_pipes} or @code{geomview}).

There are to save the plot in a graphic format file. In those cases, the
file @code{maxout_xxx.format} created by Maxima includes commands that will
make the external plotting program save the result in a graphic
file. The default name for that graphic file is
@code{maxplot.extension}, where @code{extension} is the extension
normally used for the kind of graphic file selected.

The @code{maxout_xxx.format} and @code{maxplot.extension} files are created
in the directory specified by the system variable
@mrefdot{maxima_tempdir} That location can be changed by assigning to
that variable (or to the environment variable @env{MAXIMA_TEMPDIR}) a string
that represents a valid directory where Maxima can create new files. The
output of the Maxima plotting command will be a list with the names of
the file(s) created, including their complete path.

If the format used is either @code{gnuplot} or @code{xmaxima}, the
external programs @code{gnuplot} or @code{xmaxima} can be run, giving it
the file @code{maxout_xxx.format} as argument, in order to view again a plot
previously created in Maxima. Thus, when a Maxima plotting command
fails, the format can be set to @code{gnuplot} or @code{xmaxima} and the
plain-text file @code{maxout_xxx.gnuplot} (or @code{maxout_xxx.xmaxima}) can be
inspected to look for the source of the problem.

The additional package @ref{draw} provides functions similar to the ones
described in this section with some extra features. Note that some
plotting options have the same name in both plotting packages, but their
syntax and behavior is different. To view the documentation for a
graphic option @code{opt}, type @code{?? opt} in order to choose the
information for either of those two packages.

@opencatbox
@category{Plotting}
@closecatbox

@c -----------------------------------------------------------------------------
@node Plotting Formats, Functions and Variables for Plotting, Introduction to Plotting, Plotting
@section Plotting Formats
@c -----------------------------------------------------------------------------

Maxima can use either Gnuplot, Xmaxima or Geomview as graphics program. Gnuplot and Geomview are
external programs which must be installed separately, while Xmaxima
is distributed with Maxima. There are various different formats for
those programs, which can be selected with the option @mref{plot_format}
(see also the @mref{Plotting Options} section).

The plotting formats are the following:

@itemize @bullet
@item
@strong{gnuplot} (default on Windows)

Used to launch the external program gnuplot, which must be installed in
your system.  All plotting commands and data are saved into the file
@code{maxout_xxx.gnuplot}.

@item
@strong{gnuplot_pipes} (default on non-Windows platforms)

This format is not available in Windows platforms.
It is similar to the @code{gnuplot} format except that the commands are sent
to gnuplot through a pipe, while the data are saved into the file
@code{maxout_xxx.gnuplot_pipes}.  A single gnuplot process is kept open
and subsequent plot commands will be sent to the same process, replacing
previous plots, unless the gnuplot pipe is closed with the function
@mrefdot{gnuplot_close}  When this format is used, the function
@mref{gnuplot_replot} can be used to modify a plot that has already
displayed on the screen.

This format is only used to plot to the screen; whenever graphic files are
created, the format is silently switched to @code{gnuplot} and
the commands needed to create the graphic file are saved with the data
in file @code{maxout_xxx.gnuplot}.

@item
@strong{mgnuplot}

Mgnuplot is a Tk-based wrapper around gnuplot.  It is included in the
Maxima distribution.  Mgnuplot offers a rudimentary GUI for gnuplot,
but has fewer overall features than the plain gnuplot
interface.  Mgnuplot requires an external gnuplot installation and, in
Unix systems, the Tcl/Tk system.

@item
@strong{xmaxima}

Xmaxima is a Tcl/Tk graphical interface for Maxima that can also be used
to display plots created when Maxima is run from the console or from
other graphical interfaces.  To use this format, the xmaxima program,
which is distributed together with Maxima, must be installed.  If
Maxima is being run from the Xmaxima console, the data and commands are
passed to xmaxima through the same socket used for the communication
between Maxima and the Xmaxima console. When used from a terminal or
from graphical interfaces different from Xmaxima, the commands and data
are saved in the file @code{maxout_xxx.xmaxima} and xmaxima is run with the
name of that file as argument.

In previous versions this format used to be called @code{openmath}; that
old name still works as a synonym for @code{xmaxima}.

@item
@strong{geomview}

Geomview, a Motif based interactive 3D viewing program for Unix, can
also be used to display plots created by Maxima.  To use this format,
the geomview program must be installed.

@end itemize

@opencatbox
@category{Plotting}
@closecatbox

@c -----------------------------------------------------------------------------
@node Functions and Variables for Plotting, Plotting Options, Plotting Formats, Plotting
@section Functions and Variables for Plotting
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{contour_plot}
@deffn {Function} contour_plot (@var{expr}, @var{x_range}, @var{y_range}, @var{options}, @dots{})

It plots the contours (curves of equal value) of @var{expr}
over the region @var{x_range} by @var{y_range}.
Any additional arguments are treated the same as in @mrefdot{plot3d}

This function only works when the plot format is either @code{gnuplot}
or @code{gnuplot_pipes}.  The additional package
@mrefcomma{implicit_plot} which works in any graphic format, can also be
used to plot contours but a separate expression must be given for each
contour.


Examples:

@c ===beg===
@c contour_plot (x^2 + y^2, [x, -4, 4], [y, -4, 4])$
@c ===end===
@example
(%i1) contour_plot (x^2 + y^2, [x, -4, 4], [y, -4, 4])$
@end example
@ifnotinfo
@image{figures/plotting1,8cm}
@end ifnotinfo

You can add any options accepted by @code{plot3d}; for instance, the
option @mref{legend} with a value of false, to remove the
legend. By default, Gnuplot chooses and displays 3 contours. To increase the
number of contours, it is necessary to use a custom
@mrefcomma{gnuplot_preamble}  as in the next example:

@c ===beg===
@c contour_plot (u^3 + v^2, [u, -4, 4], [v, -4, 4], 
@c               [legend,false],
@c               [gnuplot_preamble, "set cntrparam levels 12"])$
@c ===end===
@example
@group
(%i1) contour_plot (u^3 + v^2, [u, -4, 4], [v, -4, 4],
              [legend,false],
              [gnuplot_preamble, "set cntrparam levels 12"])$
@end group
@end example
@ifnotinfo
@image{figures/plotting2,8cm}
@end ifnotinfo

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{geomview_command}
@defvr {System variable} geomview_command

This variable stores the name of the command used to run the geomview
program when the plot format is @code{geomview}. Its default value is
"geomview".  If the geomview program is not found unless you give
its complete path or if you want to try a different version of it,
you may change the value of this variable. For instance,

@c ===beg===
@c geomview_command: "/usr/local/bin/my_geomview"$
@c ===end===
@example
(%i1) geomview_command: "/usr/local/bin/my_geomview"$
@end example

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{get_plot_option}
@deffn {Function} get_plot_option (@var{keyword}, @var{index})

Returns the current default value of the option named @var{keyword},
which is a list. The optional argument @var{index} must be a positive
integer which can be used to extract only one element from the list
(element 1 is the name of the option).

See also @mrefcomma{set_plot_option} @mref{remove_plot_option} and the
section on Plotting Options.
@end deffn

@c -----------------------------------------------------------------------------
@anchor{gnuplot_command}
@defvr {System variable} gnuplot_command

This variable stores the name of the command used to run the gnuplot
program when the plot format is @code{gnuplot}. Its default value is
"gnuplot". If the gnuplot program is not found unless you give its
complete path or if you want to try a different version of it, you
may change the value of this variable. For instance,

@c ===beg===
@c gnuplot_command: "/usr/local/bin/my_gnuplot"$
@c ===end===
@example
(%i1) gnuplot_command: "/usr/local/bin/my_gnuplot"$
@end example

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_file_args}
@defvr {System variable} gnuplot_file_args

When a graphic file is going to be created using @code{gnuplot}, this
variable is used to specify the way the file name should be passed to
gnuplot. Its default value is "~s", which means that the name of the
file will be passed directly. The contents of this variable can be
changed in order to add options for the gnuplot program, adding those
options before the format directive "~s".

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_view_args}
@defvr {System variable} gnuplot_view_args

This variable is used to parse the argument that will be passed to the
gnuplot program when the plot format is @code{gnuplot}. Its default
value is "-persist ~s", where "~s" will be replaced with the name of the
file where the gnuplot commands have been written (usually
"maxout_xxx.gnuplot"). The option @code{-persist} tells gnuplot to exit
after the commands in the file have been executed, without closing the
window that displays the plot.

Those familiar with gnuplot, might want to change the value of this
variable. For example, by changing it to:

@c ===beg===
@c gnuplot_view_args: "~s -"$
@c ===end===
@example
(%i1) gnuplot_view_args: "~s -"$
@end example

gnuplot will not be closed after the commands in the file have been
executed; thus, the window with the plot will remain, as well as the
gnuplot interactive shell where other commands can be issued in order to
modify the plot.

In Windows versions of Gnuplot older than 4.6.3 the behavior of "~s -"
and "-persist ~s" were the opposite; namely, "-persist ~s" made the plot
window and the gnuplot interactive shell remain, while "~s -" closed the
gnuplot shell keeping the plot window. Therefore, when older gnuplot
versions are used in Windows, it might be necessary to adjust the value
of @code{gnuplot_view_args}.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{implicit_plot}
@deffn  {Function} implicit_plot @
@fname{implicit_plot} (@var{expr}, @var{x_range}, @var{y_range}) @
@fname{implicit_plot} ([@var{expr_1}, @dots{}, @var{expr_n}], @var{x_range}, @var{y_range})

Displays a plot of a function on the real plane, defined implicitly by
the expression @var{expr}. The domain in the plane is defined by
@var{x_range} and @var{y_range}. Several functions can be represented on
the same plot, giving a list [@var{expr_1}, @dots{}, @var{expr_n}] of
expressions that define them. This function uses the global format
options set up with the @mrefdot{set_plot_option} Additional options can
also be given as extra arguments for the @code{implicit_plot} command.

The method used by @code{implicit_plot} consists of tracking sign
changes on the domain given and it can fail for complicated expressions.

@code{load(implicit_plot)} loads this function.

Example:
@c ===beg===
@c load(implicit_plot)$
@c implicit_plot (x^2 = y^3 - 3*y + 1, [x, -4, 4], [y, -4, 4])$
@c ===end===
@example
(%i1) load(implicit_plot)$
(%i2) implicit_plot (x^2 = y^3 - 3*y + 1, [x, -4, 4], [y, -4, 4])$
@end example

@ifnotinfo
@image{figures/plotting3,8cm}
@end ifnotinfo

@opencatbox
@category{Plotting}
@category{Share packages}
@category{Package implicit_plot}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{julia}
@deffn {Function} julia (@var{x}, @var{y}, ...@var{options}...)

Creates a graphic representation of the Julia set for the complex number
(@var{x} + i @var{y}). The two mandatory parameters @var{x} and @var{y}
must be real. This program is part of the additional package
@code{dynamics}, but that package does not have to be loaded; the first
time julia is used, it will be loaded automatically.

Each pixel in the grid is given a color corresponding to the number of
iterations it takes the sequence that starts at that point to move out
of the convergence circle of radius 2 centered at the origin. The number
of pixels in the grid is controlled by the @mref{grid} plot option
(default 30 by 30). The maximum number of iterations is set with the
option @mrefdot{iterations} The program uses its own default palette:
magenta,violet, blue, cyan, green, yellow, orange, red, brown and black,
but it can be changed by adding an explicit @mref{palette} option in the
command.

The default domain used goes from -2 to 2 in both axes and can be
changed with the @code{x} and @code{y} options. By default, the two axes
are shown with the same scale, unless the option @mref{yx_ratio} is used
or the option @mref{same_xy} is disabled. Other general plot options are
also accepted.

The following example shows a region of the Julia set for the number
-0.55 + i0.6. The option @mref{color_bar_tics} is used to prevent
Gnuplot from adjusting the color box up to 40, in which case the points
corresponding the maximum 36 iterations would not be black.

@c ===beg===
@c julia (-0.55, 0.6, [iterations, 36], [x, -0.3, 0.2],
@c   [y, 0.3, 0.9], [grid, 400, 400], [color_bar_tics, 0, 6, 36])$
@c ===end===
@example
@group
(%i1) julia (-0.55, 0.6, [iterations, 36], [x, -0.3, 0.2],
      [y, 0.3, 0.9], [grid, 400, 400], [color_bar_tics, 0, 6, 36])$
@end group
@end example

@ifnotinfo
@image{figures/plotting4,8cm}
@end ifnotinfo


@opencatbox
@category{Package dynamics}
@category{Plotting}
@closecatbox

@end deffn


@c -----------------------------------------------------------------------------
@anchor{make_transform}
@deffn {Function} make_transform ([@var{var1}, @var{var2}, @var{var3}], @var{fx}, @var{fy}, @var{fz})

Returns a function suitable to be used in the option @mref{transform_xy}@w{}
of plot3d.  The three variables @var{var1}, @var{var2}, @var{var3} are
three dummy variable names, which represent the 3 variables given by the
plot3d command (first the two independent variables and then the
function that depends on those two variables).  The three functions
@var{fx}, @var{fy}, @var{fz} must depend only on those 3 variables, and
will give the corresponding x, y and z coordinates that should be
plotted.  There are two transformations defined by default:
@mref{polar_to_xy} and @mrefdot{spherical_to_xyz} See the documentation
for those two transformations.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{mandelbrot}
@deffn {Function} mandelbrot (@var{options})

Creates a graphic representation of the Mandelbrot set. This program is
part of the additional package @code{dynamics}, but that package does
not have to be loaded; the first time mandelbrot is used, the package
will be loaded automatically.

This program can be called without any arguments, in which case it will
use a default value of 9 iterations per point, a grid with dimensions
set by the @mref{grid} plot option (default 30 by 30) and a region
that extends from -2 to 2 in both axes. The options are all the same
that plot2d accepts, plus an option @mref{iterations} to change the
number of iterations.

Each pixel in the grid is given a color corresponding to the number of
iterations it takes the sequence starting at zero to move out
of the convergence circle of radius 2, centered at the origin. The
maximum number of iterations is set by the option @mrefdot{iterations}
The program uses its own default palette: magenta,violet, blue, cyan,
green, yellow, orange, red, brown and black, but it can be changed by
adding an explicit @mref{palette} option in the command. By default, the
two axes are shown with the same scale, unless the option @mref{yx_ratio}
is used or the option @mref{same_xy} is disabled.

Example:

@c ===beg===
@c mandelbrot ([iterations, 30], [x, -2, 1], [y, -1.2, 1.2],
            [grid,400,400])$
@c ===end===
@example
(%i1) mandelbrot ([iterations, 30], [x, -2, 1], [y, -1.2, 1.2],
            [grid,400,400])$
@end example

@ifnotinfo
@image{figures/plotting5,8cm}
@end ifnotinfo

@opencatbox
@category{Package dynamics}
@category{Plotting}
@closecatbox

@end deffn

@c -----------------------------------------------------------------------------
@anchor{polar_to_xy}
@deffn {System function} polar_to_xy

It can be given as value for the @mref{transform_xy} option of
plot3d.  Its effect will be to interpret the two independent variables in
plot3d as the distance from the z axis and the azimuthal angle (polar
coordinates), and transform them into x and y coordinates.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{plot2d}
@deffn  {Function} plot2d @
@fname{plot2d} (@var{plot}, @var{x_range}, @dots{}, @var{options}, @dots{}) @
@fname{plot2d} ([@var{plot_1}, @dots{}, @var{plot_n}], @dots{}, @var{options}, @dots{}) @
@fname{plot2d} ([@var{plot_1}, @dots{}, @var{plot_n}], @var{x_range}, @dots{}, @var{options}, @dots{})

Where @var{plot}, @var{plot_1}, @dots{}, @var{plot_n} can be either
expressions, function names or a list with
the any of the forms: @code{[discrete, [@var{x1}, ..., @var{xn}],
[@var{y1}, ..., @var{yn}]]}, @code{[discrete, [[@var{x1}, @var{y1}],
..., [@var{xn}, ..., @var{yn}]]]} or @code{[parametric, @var{x_expr},
@var{y_expr}, @var{t_range}]}.

Displays a plot of one or more expressions as a function of one
variable or parameter.

@code{plot2d} displays one or several plots in two dimensions.  When
expressions or function name are used to define the plots,
they should all depend on only one variable @var{var} and the use of
@var{x_range} will be mandatory, to provide the name of the variable and
its minimum and maximum values; the syntax for @var{x_range} is:
@code{[@var{variable}, @var{min}, @var{max}]}.

A plot can also be defined in the discrete or parametric forms.  The
discrete form is used to plot a set of points with given coordinates.  A
discrete plot is defined by a list starting with the keyword
@var{discrete}, followed by one or two lists of values.  If two lists are
given, they must have the same length; the first list will be
interpreted as the x coordinates of the points to be plotted and the
second list as the y coordinates.  If only one list is given after the
@var{discrete} keyword, each element on the list could also be a list
with two values that correspond to the x and y coordinates of a point,
or it could be a sequence of numerical values which will be plotted
at consecutive integer values (1,2,3,...) on the x axis.

A parametric plot is defined by a list starting with the keyword
@var{parametric}, followed by two expressions or function names and a
range for the parameter.  The range for the parameter must be a list with
the name of the parameter followed by its minimum and maximum values:
@code{[@var{param}, @var{min}, @var{max}]}.  The plot will show the path
traced out by the point with coordinates given by the two expressions or
functions, as @var{param} increases from @var{min} to @var{max}.

A range for the vertical axis is an optional argument with the form:
@code{[y, @var{min}, @var{max}]} (the keyword @var{y} is always used for
the vertical axis).  If that option is used, the plot will show that
exact vertical range, independently of the values reached by the plot.
If the vertical range is not specified, it will be set up according to
the minimum and maximum values of the second coordinate of the plot
points.

All other options should also be lists, starting with a keyword and
followed by one or more values.  See @mrefdot{plot_options}

If there are several plots to be plotted, a legend will be
written to identity each of the expressions.  The labels that should be
used in that legend can be given with the option @mrefdot{legend}  If that
option is not used, Maxima will create labels from the expressions or
function names.

@c PUT EXAMPLES FOR PRECEDING SIMPLE FORMS OF plot2d HERE
@strong{Examples:}

Plot of a common function:

@c ===beg===
@c plot2d (sin(x), [x, -%pi, %pi])$
@c ===end===
@example
(%i1) plot2d (sin(x), [x, -%pi, %pi])$
@end example

@ifnotinfo
@image{figures/plotting6,8cm}
@end ifnotinfo

If the function grows too fast, it might be necessary to limit the
values in the vertical axis using the @mref{y} option:

@c ===beg===
@c plot2d (sec(x), [x, -2, 2], [y, -20, 20])$
@c ===end===
@example
(%i1) plot2d (sec(x), [x, -2, 2], [y, -20, 20])$
@end example

@ifnotinfo
@image{figures/plotting7,8cm}
@end ifnotinfo

When the plot box is disabled, no labels are created for the axes. In
that case, instead of using @mref{xlabel} and @mref{ylabel} to set the
names of the axes, it is better to use option @mrefcomma{label} which
allows more flexibility. Option @mref{yx_ratio} is used to change the
default rectangular shape of the plot; in this example the plot will
fill a square.

@c ===beg===
@c plot2d ( x^2 - 1, [x, -3, 3], [box, false], grid2d,
@c      [yx_ratio, 1], [axes, solid], [xtics, -2, 4, 2],
@c      [ytics, 2, 2, 6], [label, ["x", 2.9, -0.3],
@c      ["x^2-1", 0.1, 8]], [title, "A parabola"])$
@c ===end===
@example
(%i1) plot2d ( x^2 - 1, [x, -3, 3], [box, false], grid2d,
      [yx_ratio, 1], [axes, solid], [xtics, -2, 4, 2],
      [ytics, 2, 2, 6], [label, ["x", 2.9, -0.3],
      ["x^2-1", 0.1, 8]], [title, "A parabola"])$
@end example

@ifnotinfo
@image{figures/plotting8,8cm}
@end ifnotinfo

A plot with a logarithmic scale in the vertical axis:

@c ===beg===
@c plot2d (exp(3*s), [s, -2, 2], logy)$
@c ===end===
@example
(%i1) plot2d (exp(3*s), [s, -2, 2], logy)$
@end example

@ifnotinfo
@image{figures/plotting9,8cm}
@end ifnotinfo

Plotting functions by name:

@c ===beg===
@c F(x) := x^2 $
@c :lisp (defun |$g| (x) (m* x x x))
@c H(x) := if x < 0 then x^4 - 1 else 1 - x^5 $
@c plot2d ([F, G, H], [u, -1, 1], [y, -1.5, 1.5])$
@c ===end===
@example
(%i1) F(x) := x^2 $
@group
(%i2) :lisp (defun |$g| (x) (m* x x x))
$g
@end group
(%i2) H(x) := if x < 0 then x^4 - 1 else 1 - x^5 $
(%i3) plot2d ([F, G, H], [u, -1, 1], [y, -1.5, 1.5])$
@end example

@ifnotinfo
@image{figures/plotting10,8cm}
@end ifnotinfo

A plot of the butterfly curve, defined parametrically:

@c ===beg===
@c r: (exp(cos(t))-2*cos(4*t)-sin(t/12)^5)$
@c plot2d([parametric, r*sin(t), r*cos(t), [t, -8*%pi, 8*%pi]])$
@c ===end===
@example
(%i1) r: (exp(cos(t))-2*cos(4*t)-sin(t/12)^5)$
(%i2) plot2d([parametric, r*sin(t), r*cos(t), [t, -8*%pi, 8*%pi]])$
@end example

@ifnotinfo
@image{figures/plotting11,8cm}
@end ifnotinfo

Plot of a circle, using its parametric representation, together with the
function -|x|. The circle will only look like a circle if the scale in the
two axes is the same, which is done with the option @mrefdot{same_xy}

@c ===beg===
@c plot2d([[parametric, cos(t), sin(t), [t,0,2*%pi]], -abs(x)],
@c          [x, -sqrt(2), sqrt(2)], same_xy)$
@c ===end===
@example
@group
(%i1) plot2d([[parametric, cos(t), sin(t), [t,0,2*%pi]], -abs(x)],
         [x, -sqrt(2), sqrt(2)], same_xy)$
@end group
@end example

@ifnotinfo
@image{figures/plotting12,8cm}
@end ifnotinfo

A plot of 200 random numbers between 0 and 9:

@c ===beg===
@c plot2d ([discrete, makelist ( random(10), 200)])$
@c ===end===
@example
@group
(%i1) plot2d ([discrete, makelist ( random(10), 200)])$
@end group
@end example

@ifnotinfo
@image{figures/plotting13,8cm}
@end ifnotinfo

A plot of a discrete set of points, defining x and y coordinates separately:

@c ===beg===
@c plot2d ([discrete, makelist(i*%pi, i, 1, 5),
@c                            [0.6, 0.9, 0.2, 1.3, 1]])$
@c ===end===
@example
(%i1) plot2d ([discrete, makelist(i*%pi, i, 1, 5),
                            [0.6, 0.9, 0.2, 1.3, 1]])$
@end example

@ifnotinfo
@image{figures/plotting14,8cm}
@end ifnotinfo

In the next example a table with three columns is saved in a file
``data.txt'' which is then read and the second and third column are
plotted on the two axes:

@c ===beg===
@c with_stdout ("data.txt", for x:0 thru 10 do
@c                              print (x, x^2, x^3))$
@c data: read_matrix ("data.txt")$
@c plot2d ([discrete, transpose(data)[2], transpose(data)[3]],
@c   [style,points], [point_type,diamond], [color,red])$
@c ===end===
@example
@group
(%i1) with_stdout ("data.txt", for x:0 thru 10 do
                             print (x, x^2, x^3))$
@end group
(%i2) data: read_matrix ("data.txt")$
@group
(%i3) plot2d ([discrete, transpose(data)[2], transpose(data)[3]],
  [style,points], [point_type,diamond], [color,red])$
@end group
@end example

@ifnotinfo
@image{figures/plotting15,8cm}
@end ifnotinfo

A plot of discrete data points together with a continuous function:

@c ===beg===
@c xy: [[10, .6], [20, .9], [30, 1.1], [40, 1.3], [50, 1.4]]$
@c plot2d([[discrete, xy], 2*%pi*sqrt(l/980)], [l,0,50],
@c         [style, points, lines], [color, red, blue],
@c         [point_type, asterisk],
@c         [legend, "experiment", "theory"],
@c         [xlabel, "pendulum's length (cm)"],
@c         [ylabel, "period (s)"])$
@c ===end===
@example
(%i1) xy: [[10, .6], [20, .9], [30, 1.1], [40, 1.3], [50, 1.4]]$
@group
(%i2) plot2d([[discrete, xy], 2*%pi*sqrt(l/980)], [l,0,50],
        [style, points, lines], [color, red, blue],
        [point_type, asterisk],
        [legend, "experiment", "theory"],
        [xlabel, "pendulum's length (cm)"],
        [ylabel, "period (s)"])$
@end group
@end example

@ifnotinfo
@image{figures/plotting16,8cm}
@end ifnotinfo

See also the section about Plotting Options.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{plot3d}
@deffn {Function} plot3d @
@fname{plot3d} (@var{expr}, @var{x_range}, @var{y_range}, @dots{}, @var{options}, @dots{}) @
@fname{plot3d} ([@var{expr_1}, @dots{}, @var{expr_n}], @var{x_range}, @var{y_range}, @dots{}, @var{options}, @dots{})

Displays a plot of one or more surfaces defined as functions of two
variables or in parametric form.

The functions to be plotted may be specified as expressions or function names.
The mouse can be used to rotate the plot looking at the surface from different
sides.

@strong{Examples:}

Plot of a function of two variables:

@c ===beg===
@c plot3d (u^2 - v^2, [u, -2, 2], [v, -3, 3], [grid, 100, 100],
@c         [mesh_lines_color,false])$
@c ===end===
@example
@group
(%i1) plot3d (u^2 - v^2, [u, -2, 2], [v, -3, 3], [grid, 100, 100],
        [mesh_lines_color,false])$
@end group
@end example

@ifnotinfo
@image{figures/plotting17,8cm}
@end ifnotinfo

Use of the @mref{z} option to limit a function that goes to infinity
 (in this case the function is minus infinity on the x and y axes); this also
shows how to plot with only lines and no shading:

@c ===beg===
@c plot3d ( log ( x^2*y^2 ), [x, -2, 2], [y, -2, 2], [z, -8, 4],
@c          [palette, false], [color, magenta])$
@c ===end===
@example
@group
(%i1) plot3d ( log ( x^2*y^2 ), [x, -2, 2], [y, -2, 2], [z, -8, 4],
         [palette, false], [color, magenta])$
@end group
@end example

@ifnotinfo
@image{figures/plotting18,8cm}
@end ifnotinfo

The infinite values of z can also be avoided by choosing a grid that
does not fall on any points where the function is undefined, as in the
next example, which also shows how to change the palette and how to
include a color bar that relates colors to values of the z variable:

@c ===beg===
@c plot3d (log (x^2*y^2), [x, -2, 2], [y, -2, 2],[grid, 29, 29],
@c       [palette, [gradient, red, orange, yellow, green]],
@c       color_bar, [xtics, 1], [ytics, 1], [ztics, 4],
@c       [color_bar_tics, 4])$
@c ===end===
@example
@group
(%i1) plot3d (log (x^2*y^2), [x, -2, 2], [y, -2, 2],[grid, 29, 29],
       [palette, [gradient, red, orange, yellow, green]],
       color_bar, [xtics, 1], [ytics, 1], [ztics, 4],
       [color_bar_tics, 4])$
@end group
@end example

@ifnotinfo
@image{figures/plotting19,8cm}
@end ifnotinfo

Two surfaces in the same plot. Ranges specific to one of the surfaces can
be given by placing each expression and its ranges in a separate list;
global ranges for the complete plot are also given after the functions
definitions.

@c ===beg===
@c plot3d ([[-3*x - y, [x, -2, 2], [y, -2, 2]],
@c    4*sin(3*(x^2 + y^2))/(x^2 + y^2), [x, -3, 3], [y, -3, 3]],
@c    [x, -4, 4], [y, -4, 4])$
@c ===end===
@example
@group
(%i1) plot3d ([[-3*x - y, [x, -2, 2], [y, -2, 2]],
   4*sin(3*(x^2 + y^2))/(x^2 + y^2), [x, -3, 3], [y, -3, 3]],
   [x, -4, 4], [y, -4, 4])$
@end group
@end example

@ifnotinfo
@image{figures/plotting20,8cm}
@end ifnotinfo

Plot of a Klein bottle, defined parametrically:

@c ===beg===
@c expr_1: 5*cos(x)*(cos(x/2)*cos(y)+sin(x/2)*sin(2*y)+3)-10$
@c expr_2: -5*sin(x)*(cos(x/2)*cos(y)+sin(x/2)*sin(2*y)+3)$
@c expr_3: 5*(-sin(x/2)*cos(y)+cos(x/2)*sin(2*y))$
@c plot3d ([expr_1, expr_2, expr_3], [x, -%pi, %pi],
@c         [y, -%pi, %pi], [grid, 50, 50])$
@c ===end===
@example
(%i1) expr_1: 5*cos(x)*(cos(x/2)*cos(y)+sin(x/2)*sin(2*y)+3)-10$
(%i2) expr_2: -5*sin(x)*(cos(x/2)*cos(y)+sin(x/2)*sin(2*y)+3)$
(%i3) expr_3: 5*(-sin(x/2)*cos(y)+cos(x/2)*sin(2*y))$
@group
(%i4) plot3d ([expr_1, expr_2, expr_3], [x, -%pi, %pi],
        [y, -%pi, %pi], [grid, 50, 50])$
@end group
@end example

@ifnotinfo
@image{figures/plotting21,8cm}
@end ifnotinfo

Plot of a ``spherical harmonic'' function, using the predefined
transformation, @code{spherical_to_xyz} to transform from spherical
coordinates to rectangular coordinates. See the documentation for
@mrefdot{spherical_to_xyz}

@c ===beg===
@c plot3d (sin(2*theta)*cos(phi), [theta, 0, %pi],
@c         [phi, 0, 2*%pi],
@c         [transform_xy, spherical_to_xyz], [grid,30,60],
@c    [legend,false])$
@c ===end===
@example
@group
(%i1) plot3d (sin(2*theta)*cos(phi), [theta, 0, %pi],
        [phi, 0, 2*%pi],
        [transform_xy, spherical_to_xyz], [grid,30,60],
   [legend,false])$
@end group
@end example

@ifnotinfo
@image{figures/plotting22,8cm}
@end ifnotinfo

Use of the pre-defined function @code{polar_to_xy} to transform from
cylindrical to rectangular coordinates.  See the documentation for
@mrefdot{polar_to_xy}

@c ===beg===
@c plot3d (r^.33*cos(th/3), [r,0,1], [th,0,6*%pi], [box, false],
@c    [grid, 12, 80], [transform_xy, polar_to_xy], [legend, false])$
@c ===end===
@example
@group
(%i1) plot3d (r^.33*cos(th/3), [r,0,1], [th,0,6*%pi], [box, false],
   [grid, 12, 80], [transform_xy, polar_to_xy], [legend, false])$
@end group
@end example

@ifnotinfo
@image{figures/plotting23,8cm}
@end ifnotinfo

Plot of a sphere using the transformation from spherical to rectangular
coordinates. Option @mref{same_xyz} is used to get the three axes
scaled in the same proportion. When transformations are used, it is not
convenient to eliminate the mesh lines, because Gnuplot will not show the
surface correctly.

@c ===beg===
@c plot3d ( 5, [theta, 0, %pi], [phi, 0, 2*%pi], same_xyz,
@c   [transform_xy, spherical_to_xyz], [mesh_lines_color,blue],
@c   [palette,[gradient,"#1b1b4e", "#8c8cf8"]], [legend, false])$
@c ===end===
@example
@group
(%i1) plot3d ( 5, [theta, 0, %pi], [phi, 0, 2*%pi], same_xyz,
  [transform_xy, spherical_to_xyz], [mesh_lines_color,blue],
  [palette,[gradient,"#1b1b4e", "#8c8cf8"]], [legend, false])$
@end group
@end example

@ifnotinfo
@image{figures/plotting24,8cm}
@end ifnotinfo

Definition of a function of two-variables using a matrix.  Notice the
single quote in the definition of the function, to prevent @code{plot3d}
from failing when it realizes that the matrix will require integer
indices.

@c ===beg===
@c M: matrix([1,2,3,4], [1,2,3,2], [1,2,3,4], [1,2,3,3])$
@c f(x, y) := float('M [round(x), round(y)])$
@c plot3d (f(x,y), [x,1,4],[y,1,4],[grid,3,3],[legend,false])$
@c ===end===
@example
(%i1) M: matrix([1,2,3,4], [1,2,3,2], [1,2,3,4], [1,2,3,3])$
(%i2) f(x, y) := float('M [round(x), round(y)])$
@group
(%i3) plot3d (f(x,y), [x,1,4],[y,1,4],[grid,3,3],[legend,false])$
@end group
@end example

@ifnotinfo
@image{figures/plotting25,8cm}
@end ifnotinfo

By setting the elevation equal to zero, a surface can be seen as a map
in which each color represents a different level.

@c ===beg===
@c plot3d (cos (-x^2 + y^3/4), [x,-4,4], [y,-4,4], [zlabel,""],
@c        [mesh_lines_color,false], [elevation,0], [azimuth,0],
@c        color_bar, [grid,80,80], [ztics,false], [color_bar_tics,1])$
@c ===end===
@example
@group
(%i1) plot3d (cos (-x^2 + y^3/4), [x,-4,4], [y,-4,4], [zlabel,""],
       [mesh_lines_color,false], [elevation,0], [azimuth,0],
       color_bar, [grid,80,80], [ztics,false], [color_bar_tics,1])$
@end group
@end example

@ifnotinfo
@image{figures/plotting26,8cm}
@end ifnotinfo

See also the section about Plotting Options.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{plot_options}
@defvr {System variable} plot_options

This option is being kept for compatibility with older versions, but its
use is deprecated. To set global plotting options, see their current
values or remove options, use @mrefcomma{set_plot_option}
@mref{get_plot_option} and @mrefdot{remove_plot_option}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{remove_plot_option}
@deffn {Function} remove_plot_option (@var{name})

Removes the default value of an option. The name of the option must be given.

See also @mrefcomma{set_plot_option} @mref{get_plot_option} and the section
on Plotting Options.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn
@c -----------------------------------------------------------------------------
@anchor{set_plot_option}
@deffn {Function} set_plot_option (@var{option})

Accepts any of the options listed in the section Plotting Options, and
saves them for use in plotting commands. The values of the options set
in each plotting command will have precedence, but if those options are
not given, the default values set with this function will be used.

@code{set_plot_option} evaluates its argument and returns the complete
list of options (after modifying the option given). If called without
any arguments, it will simply show the list of current default options.

See also @mrefcomma{remove_plot_option} @mref{get_plot_option} and the section
on Plotting Options.

Example:

Modification of the @mref{grid} values.

@c ===beg===
@c set_plot_option ([grid, 30, 40]);
@c ===end===
@example
(%i1) set_plot_option ([grid, 30, 40]);
(%o1) [[plot_format, gnuplot_pipes], [grid, 30, 40], 
[run_viewer, true], [axes, true], [nticks, 29], [adapt_depth, 5], 
[color, blue, red, green, magenta, black, cyan], 
[point_type, bullet, box, triangle, plus, times, asterisk], 
[palette, [gradient, green, cyan, blue, violet], 
[gradient, magenta, violet, blue, cyan, green, yellow, orange, 
red, brown, black]], [gnuplot_preamble, ], [gnuplot_term, default]]
@end example

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{spherical_to_xyz}
@deffn {System function} spherical_to_xyz

It can be given as value for the @mref{transform_xy} option of
@mrefdot{plot3d} Its effect will be to interpret the two independent
variables and the function in @code{plot3d} as the spherical coordinates
of a point (first, the angle with the z axis, then the angle of the xy
projection with the x axis and finally the distance from the origin) and
transform them into x, y and z coordinates.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@node Plotting Options, Gnuplot Options, Functions and Variables for Plotting, Plotting
@section Plotting Options
@c -----------------------------------------------------------------------------

All options consist of a list starting with one of the keywords in this
section, followed by one or more values. Some of the options may have
different effects in different plotting commands as it will be pointed
out in the following list. The options that accept among their possible
values true or false, can also be set to true by simply writing their
names. For instance, typing logx as an option is equivalent to writing
[logx, true].


@c -----------------------------------------------------------------------------
@anchor{adapt_depth}
@defvr {Plot option} adapt_depth [adapt_depth, @var{integer}]
Default value: @code{5}

The maximum number of splittings used by the adaptive plotting routine.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{axes}
@defvr {Plot option} axes [axes, @var{symbol}] 
Default value: @code{true}

Where @var{symbol} can be either @code{true}, @code{false}, @code{x},
@code{y} or @code{solid}. If @code{false}, no axes are shown; if equal
to @code{x} or @code{y} only the x or y axis will be shown; if it is
equal to @code{true}, both axes will be shown and @code{solid} will show
the two axes with a solid line, rather than the default broken
line. This option does not have any effect in the 3 dimensional plots.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{azimuth}
@defvr {Plot option} azimuth [azimuth, @var{number}]
Default value: @code{30}

A plot3d plot can be thought of as starting with the x and y axis in the
horizontal and vertical axis, as in plot2d, and the z axis coming out of
the screen.  The z axis is then rotated around the x axis through an
angle equal to @mref{elevation} and then the new xy plane is rotated
around the new z axis through an angle @mrefdot{azimuth} This option sets
the value for the azimuth, in degrees.

See also @mrefdot{elevation}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{option_box}
@defvr {Plot option} box [box, @var{symbol}]
Default value: @code{true}

If set to @code{true}, a bounding box will be drawn for the plot; if set
to @code{false}, no box will be drawn.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{color}
@defvr {Plot option} color [color, @var{color_1}, @dots{}, @var{color_n}]

In 2d plots it defines the color (or colors) for the various curves.  In
@mrefcomma{plot3d} it defines the colors used for the mesh lines of the
surfaces, when no palette is being used.

If there are more curves or surfaces than colors, the colors will be
repeated in sequence. The valid colors are @code{red}, @code{green},
@code{blue}, @code{magenta}, @code{cyan}, @code{yellow}, @code{orange},
@code{violet}, @code{brown}, @code{gray}, @code{black}, @code{white}, or
a string starting with the character # and followed by six hexadecimal
digits: two for the red component, two for green component and two for
the blue component. If the name of a given color is unknown color, black
will be used instead.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{color_bar}
@defvr {Plot option} color_bar [color_bar, @var{symbol}]
Default value: @code{false} in plot3d, @code{true} in mandelbrot and julia

Where @var{symbol} can be either @code{true} or @code{false}.  If
@code{true}, whenever @mrefcomma{plot3d} @mref{mandelbrot} or
@mref{julia} use a palette to represent different values, a box will be
shown on the right, showing the corresponding between colors and values.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{color_bar_tics}
@defvr {Plot option} color_bar_tics [color_bar_tics, @var{x1}, @var{x2}, @var{x3}]

Defines the values at which a mark and a number will be placed in the
color bar. The first number is the initial value, the second the
increments and the third is the last value where a mark is placed. The
second and third numbers can be omitted. When only one number is given,
it will be used as the increment from an initial value that will be
chosen automatically.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{elevation}
@defvr {Plot option} elevation [elevation, @var{number}]
Default value: @code{60}

A plot3d plot can be thought of as starting with the x and y axis in the
horizontal and vertical axis, as in plot2d, and the z axis coming out of
the screen.  The z axis is then rotated around the x axis through an
angle equal to @mref{elevation} and then the new xy plane is rotated
around the new z axis through an angle @mrefdot{azimuth} This option sets
the value for the azimuth, in degrees.

See also @mrefdot{azimuth}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{grid}
@defvr {Plot option} grid [grid, @var{integer}, @var{integer}]
Default value: @code{30}, @code{30}

Sets the number of grid points to use in the x- and y-directions for
three-dimensional plotting or for the @mref{julia} and @mref{mandelbrot}
programs.

For a way to actually draw a grid See @mrefdot{grid2d}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{grid2d}
@defvr {Plot option} grid2d [grid, @var{value}]
Default value: @code{false}

Shows a grid of lines on the xy plane. The points where the grid lines
are placed are the same points where tics are marked in the x and y
axes, which can be controlled with the @mref{xtics} and @mref{ytics}
options.

See also @mrefdot{grid}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{iterations}
@defvr {Plot option} iterations [grid, @var{value}]
Default value: @code{9}

Number of iterations made by the programs mandelbrot and julia.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{label}
@defvr  {Plot option} label [label, [@var{string}, @var{x}, @var{y}], @dots{}]

Writes one or several labels in the points with @var{x}, @var{y}
coordinates indicated after each label.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{legend}
@defvr {Plot option} legend @
@fname{legend} [legend, @var{string_1}, @dots{}, @var{string_n}] @
@fname{legend} [legend, @var{false}]

It specifies the labels for the plots when various plots are shown.  If
there are more plots than the number of labels given, they will be
repeated.  If given the value @code{false}, no legends will be shown.  By
default, the names of the expressions or functions will be used, or the
words discrete1, discrete2, @dots{}, for discrete sets of points.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{logx}
@defvr {Plot option} logx [logx, @var{value}]

Makes the horizontal axes to be scaled logarithmically. It can be either
true or false.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{logy}
@defvr {Plot option} logy [logy, @var{value}]

Makes the vertical axes to be scaled logarithmically. It can be either
true or false.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{mesh_lines_color}
@defvr {Plot option} mesh_lines_color [mesh_lines_color, @var{color}]
Default value: @code{black}

It sets the color used by plot3d to draw the mesh lines, when a palette is
being used.  It accepts the same colors as for the option @mref{color}@w{}
(see the list of allowed colors in @mref{color}).  It can also be given a
value @code{false} to eliminate completely the mesh lines.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{nticks}
@defvr {Plot option} nticks [nticks, @var{integer}]
Default value: @code{29}

When plotting functions with @mrefcomma{plot2d} it is gives the initial
number of points used by the adaptive plotting routine for plotting
functions.  When plotting parametric functions with @mrefcomma{plot3d}
it sets the number of points that will be shown for the plot.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{palette}
@defvr  {Plot option} palette @
@fname{palette} [palette, [@var{palette_1}], @dots{}, [@var{palette_n}]] @
@fname{palette} [palette, @var{false}]

It can consist of one palette or a list of several palettes.  Each
palette is a list with a keyword followed by values. If the keyword is
gradient, it should be followed by a list of valid colors.

If the keyword is hue, saturation or value, it must be followed by 4
numbers. The first three numbers, which must be between 0 and 1, define
the hue, saturation and value of a basic color to be assigned to the
minimum value of z. The keyword specifies which of the three attributes
(hue, saturation or value) will be increased according to the values of
z.  The last number indicates the increase corresponding to the maximum
value of z.  That last number can be bigger than 1 or negative; the
corresponding values of the modified attribute will be rounded modulo 1.

Gnuplot only uses the first palette in the list; xmaxima will use the
palettes in the list sequentially, when several surfaces are plotted
together; if the number of palettes is exhausted, they will be repeated
sequentially.

The color of the mesh lines will be given by the option
@mrefdot{mesh_lines_color}  If @code{palette} is given the value
@code{false}, the surfaces will not be shaded but represented with a
mesh of curves only.  In that case, the colors of the lines will be
determined by the option @mrefdot{color}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{plot_format}
@defvr {Plot option} plot_format [plot_format, @var{format}]
Default value: @code{gnuplot}, in Windows systems, or @code{gnuplot_pipes} in
other systems.

Where @var{format} is one of the following: gnuplot, xmaxima, mgnuplot,
gnuplot_pipes or geomview.

It sets the format to be used for plotting.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{plot_real_part}
@defvr {Plot option} plot_realpart [plot_realpart, @var{symbol}]
Default value: @code{false}

If set to @code{true}, the functions to be plotted will be considered
as complex functions whose real value should be plotted; this is
equivalent to plotting @code{realpart(@var{function})}.  If set to
@code{false}, nothing will be plotted when the function does not give a
real value.  For instance, when @code{x} is negative, @code{log(x)} gives
a complex value, with real value equal to @code{log(abs(x))}; if
@code{plot_realpart} were @code{true}, @code{log(-5)} would be plotted
as @code{log(5)}, while nothing would be plotted if
@code{plot_realpart} were @code{false}.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{point_type}
@defvr {Plot option} point_type [point_type, @var{type_1}, @dots{}, @var{type_n}]

In gnuplot, each set of points to be plotted with the style ``points''
or ``linespoints'' will be represented with objects taken from this
list, in sequential order.  If there are more sets of points than objects
in this list, they will be repeated sequentially.
The possible objects that can be used are: @code{bullet}, @code{circle},
@code{plus}, @code{times}, @code{asterisk}, @code{box}, @code{square},
@code{triangle}, @code{delta}, @code{wedge}, @code{nabla}, @code{diamond},
@code{lozenge}.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{pdf_file}
@defvr {Plot option} pdf_file [pdf_file, @var{file_name}]

Saves the plot into a PDF file with name equal to @var{file_name},
rather than showing it in the screen.  By default, the file will be
created in the directory defined by the variable
@mrefcomma{maxima_tempdir} unless @var{file_name} contains the character
``/'', in which case it will be assumed to contain the complete path where
the file should be created. The value of @mref{maxima_tempdir} can be changed
to save the file in a different directory. When the option
@mref{gnuplot_pdf_term_command} is also given, it will be used to set up
Gnuplot's PDF terminal; otherwise, Gnuplot's pdfcairo terminal
will be used with solid colored lines of width 3, plot
size of 17.2 cm by 12.9 cm and font of 18 points.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{png_file}
@defvr {Plot option} png_file [png_file, @var{file_name}]

Saves the plot into a PNG graphics file with name equal to @var{file_name},
rather than showing it in the screen. By default, the file will be
created in the directory defined by the variable
@mrefcomma{maxima_tempdir} unless @var{file_name} contains the character
``/'', in which case it will be assumed to contain the complete path where
the file should be created. The value of @mref{maxima_tempdir} can be changed
to save the file in a different directory. When the option
@mref{gnuplot_png_term_command} is also given, it will be used to set up
Gnuplot's PNG terminal; otherwise, Gnuplot's pngcairo terminal
will be used, with a font of size 12. 

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{ps_file}
@defvr {Plot option} ps_file [ps_file, @var{file_name}]

Saves the plot into a Postscript file with name equal to @var{file_name},
rather than showing it in the screen.  By default, the file will be
created in the directory defined by the variable
@mrefcomma{maxima_tempdir} unless @var{file_name} contains the character
``/'', in which case it will be assumed to contain the complete path where
the file should be created. The value of @mref{maxima_tempdir} can be changed
to save the file in a different directory. When the option
@mref{gnuplot_ps_term_command} is also given, it will be used to set up
Gnuplot's Postscript terminal; otherwise, Gnuplot's postscript terminal
will be used with the EPS option, solid colored lines of width 2, plot
size of 16.4 cm by 12.3 cm and font of 24 points.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{run_viewer}
@defvr {Plot option} run_viewer [run_viewer, @var{symbol}]

This option is only used when the plot format is @code{gnuplot} and the
terminal is @code{default} or when the Gnuplot terminal is set to
@code{dumb} (see @mref{gnuplot_term}) and can have a true or false
value.

If the terminal is @code{default}, a file @code{maxout_xxx.gnuplot} (or
other name specified with @mref{gnuplot_out_file}) is created with the
gnuplot commands necessary to generate the plot. Option @code{run_viewer}
controls whether or not Gnuplot will be launched to execute those
commands and show the plot.

If the terminal is @code{default}, gnuplot is run to execute the
commands in @code{maxout_xxx.gnuplot}, producing another file
@code{maxplot.txt} (or other name specified with
@mref{gnuplot_out_file}). Option @code{run_viewer} controls whether or
not that file, with an ASCII representation of the plot, will be shown
in the Maxima or Xmaxima console.

The default value for this option is true, making the plots to be shown
in either the console or a separate graphics window.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{same_xy}
@defvr {Plot option} same_xy [same_xy , @var{value}]

It can be either true or false. If true, the scales used in the x and y
axes will be the same, in either 2d or 3d plots. See also @mrefdot{yx_ratio}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{same_xyz}
@defvr {Plot option} same_xyz [same_xyz , @var{value}]

It can be either true or false. If true, the scales used in the 3 axes of
a 3d plot will be the same.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{style}
@defvr  {Plot option} style @
@fname{style} [style, @var{type_1}, @dots{}, @var{type_n}] @
@fname{style} [style, [@var{style_1}], @dots{}, [@var{style_n}]]

The styles that will be used for the various functions or sets of data
in a 2d plot.  The word @var{style} must be followed by one or more
styles.  If there are more functions and data sets than the styles
given, the styles will be repeated.  Each style can be either
@var{lines} for line segments, @var{points} for isolated points,
@var{linespoints} for segments and points, or @var{dots} for small
isolated dots.  Gnuplot accepts also an @var{impulses} style.

Each of the styles can be enclosed inside a list with some additional
parameters.  @var{lines} accepts one or two numbers: the width of the
line and an integer that identifies a color.  The default color codes
are: 1: blue, 2: red, 3: magenta, 4: orange, 5: brown, 6: lime and 7:
aqua.  If you use Gnuplot with a terminal different than X11,
those colors might be different; for example, if you use the option
[@var{gnuplot_term}, @var{ps}], color index 4 will correspond to black,
instead of orange.

@var{points} accepts one two or three parameters; the first parameter
is the radius of the points, the second parameter is an integer that
selects the color, using the same code used for @var{lines} and the
third parameter is currently used only by Gnuplot and it corresponds
to several objects instead of points.  The default types of
objects are: 1: filled circles, 2: open circles, 3: plus signs, 4: x,
5: *, 6: filled squares, 7: open squares, 8: filled triangles, 9: open
triangles, 10: filled inverted triangles, 11: open inverted triangles,
12: filled lozenges and 13: open lozenges.

@var{linespoints} accepts up to four parameters: line width, points
radius, color and type of object to replace the points.

See also @mref{color} and @mrefdot{point_type}
 
@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{svg_file}
@defvr {Plot option} svg_file [svg_file, @var{file_name}]

Saves the plot into an SVG file with name equal to @var{file_name},
rather than showing it in the screen.  By default, the file will be
created in the directory defined by the variable
@mrefcomma{maxima_tempdir} unless @var{file_name} contains the character
``/'', in which case it will be assumed to contain the complete path where
the file should be created. The value of @mref{maxima_tempdir} can be changed
to save the file in a different directory. When the option
@mref{gnuplot_svg_term_command} is also given, it will be used to set up
Gnuplot's SVG terminal; otherwise, Gnuplot's svg terminal
will be used with font of 14 points.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{t}
@defvr {Plot option} t [t, @var{min}, @var{max}]

Default range for parametric plots.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{title}
@defvr {Plot option} title [title, @var{text}]

Defines a title that will be written at the top of the plot.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{transform_xy}
@defvr {Plot option} transform_xy [transform_xy, @var{symbol}]

Where @var{symbol} is either @code{false} or the result obtained by
using the function @code{transform_xy}.  If different from @code{false},
it will be used to transform the 3 coordinates in plot3d.

See @mrefcomma{make_transform} @mref{polar_to_xy} and
@mrefdot{spherical_to_xyz}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{x}
@defvr {Plot option} x [x, @var{min}, @var{max}]

When used as the first option in a @mref{plot2d} command (or any of the
first two in @mref{plot3d}), it indicates that the first independent variable
is x and it sets its range.  It can also be used again after the first
option (or after the second option in plot3d) to define the effective
horizontal domain that will be shown in the plot.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{xlabel}
@defvr {Plot option} xlabel [xlabel, @var{string}]

Specifies the @var{string} that will label the first axis; if this option is
not used, that label will be the name of the independent variable, when plotting
functions with @mref{plot2d} or @mrefcomma{implicit_plot} or the name of the
first variable, when plotting surfaces with @mref{plot3d} or contours with
@mrefcomma{contour_plot} or the first expression in the case of a parametric
plot.  It can not be used with @mrefdot{set_plot_option}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{xtics}
@defvr {Plot option} xtics [xtics, @var{x1}, @var{x2}, @var{x3}]

Defines the values at which a mark and a number will be placed in the x
axis. The first number is the initial value, the second the increments
and the third is the last value where a mark is placed. The second and
third numbers can be omitted. When only one number is given, it will be
used as the increment from an initial value that will be chosen
automatically.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{xy_scale}
@defvr {Plot option} xy_scale [xy_scale, @var{sx}, @var{sy}]

In a 2d plot, it defines the ratio of the total size of the Window to
the size that will be used for the plot. The two numbers given as
arguments are the scale factors for the x and y axes.

This option does not change the size of the graphic window or the placement
of the graph in the window. If you want to change the aspect ratio of the
plot, it is better to use option @mrefdot{yx_ratio} For instance,
@code{[yx_ratio, 10]} instead of @code{[xy_scale, 0.1, 1]}.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{y}
@defvr {Plot option} y [y, @var{min}, @var{max}]

When used as one of the first two options in @mrefcomma{plot3d} it indicates
that one of the independent variables is y and it sets its range.  Otherwise,
it defines the effective domain of the second variable that will be
shown in the plot.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{ylabel}
@defvr {Plot option} ylabel [ylabel, @var{string}]

Specifies the @var{string} that will label the second axis; if this
option is not used, that label will be ``y'', when plotting functions
with @mref{plot2d} or @mrefcomma{implicit_plot} or the name of the second
variable, when plotting surfaces with @mref{plot3d} or contours with
@mrefcomma{contour_plot} or the second expression in the case of a parametric
plot.  It can not be used with @mrefdot{set_plot_option}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{ytics}
@defvr {Plot option} ytics [ytics, @var{y1}, @var{y2}, @var{y3}]

Defines the values at which a mark and a number will be placed in the y
axis. The first number is the initial value, the second the increments
and the third is the last value where a mark is placed. The second and
third numbers can be omitted. When only one number is given, it will be
used as the increment from an initial value that will be chosen
automatically

@opencatbox
@category{Plotting}
@closecatbox
@end defvr
@c -----------------------------------------------------------------------------
@anchor{yx_ratio}
@defvr {Plot option} yx_ratio [yx_ratio, @var{r}]

In a 2d plot, the ratio between the vertical and the horizontal sides of
the rectangle used to make the plot. See also @mrefdot{same_xy}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{z}
@defvr {Plot option} z [z, @var{min}, @var{max}]

Used in @mref{plot3d} to set the effective range of values of z that will be
shown in the plot.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{zlabel}
@defvr {Plot option} zlabel [zlabel, @var{string}]

Specifies the @var{string} that will label the third axis, when using
@mrefdot{plot3d}  If this option is not used, that label will be ``z'', when
plotting surfaces, or the third expression in the case of a parametric
plot.  It can not be used with @mref{set_plot_option} and it will be
ignored by @mref{plot2d} and @mrefdot{implicit_plot}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{zmin}
@defvr {Plot option} zmin [zmin, @var{z}]

In 3d plots, the value of z that will be at the bottom of the plot box.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@node Gnuplot Options, Gnuplot_pipes Format Functions, Plotting Options, Plotting
@section Gnuplot Options
@c -----------------------------------------------------------------------------

There are several plot options specific to gnuplot.  All of them consist
of a keyword (the name of the option), followed by a string that should
be a valid gnuplot command, to be passed directly to gnuplot.  In most
cases, there exist a corresponding plotting option that will produce a
similar result and whose use is more recommended than the gnuplot
specific option.

@c -----------------------------------------------------------------------------
@anchor{gnuplot_term}
@defvr {Plot option} gnuplot_term [gnuplot_term, @var{terminal_name}]

Sets the output terminal type for gnuplot. The argument @var{terminal_name}
can be a string or one of the following 3 special symbols
@itemize @bullet
@item
@strong{default} (default value)

Gnuplot output is displayed in a separate graphical window and the
gnuplot terminal used will be specified by the value of the option
@mrefdot{gnuplot_default_term_command}

@item
@strong{dumb}

Gnuplot output is saved to a file @code{maxout_xxx.gnuplot} using "ASCII
art" approximation to graphics. If the option @mref{gnuplot_out_file} is
set to @var{filename}, the plot will be saved there, instead of the
default @code{maxout_xxx.gnuplot}. The settings for the ``dumb'' terminal of
Gnuplot are given by the value of option
@mrefdot{gnuplot_dumb_term_command} If option @mref{run_viewer} is set
to true and the plot_format is @code{gnuplot} that ASCII representation
will also be shown in the Maxima or Xmaxima console.

@item
@strong{ps}

Gnuplot generates commands in the PostScript page description language.
If the option @mref{gnuplot_out_file} is set to @var{filename}, gnuplot
writes the PostScript commands to @var{filename}.  Otherwise, it is
saved as @code{maxplot.ps} file. The settings for this terminal are given by the value of the option @mrefdot{gnuplot_dumb_term_command}

@item
A string representing any valid gnuplot term specification

Gnuplot can generate output in many other graphical formats such as png,
jpeg, svg etc. To use those formats, option @code{gnuplot_term} can be
set to any supported gnuplot term name (which must be a symbol) or even a
full gnuplot term specification with any valid options (which must be a string).  For
example @code{[gnuplot_term, png]} creates output in PNG (Portable
Network Graphics) format while @code{[gnuplot_term, "png size
1000,1000"]} creates PNG of 1000 x 1000 pixels size.  If the option
@mref{gnuplot_out_file} is set to @var{filename}, gnuplot writes the
output to @var{filename}.  Otherwise, it is saved as
@code{maxplot.@var{term}} file, where @var{term} is gnuplot terminal
name.
@end itemize

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_out_file}
@defvr {Plot option} gnuplot_out_file [gnuplot_out_file, @var{file_name}]

It can be used to replace the default name for the file that contains
the commands that will interpreted by gnuplot, when the terminal is set
to @code{default}, or to replace the default name of the graphic file
that gnuplot creates, when the terminal is different from
@code{default}. If it contains one or more slashes, ``/'', the name of
the file will be left as it is; otherwise, it will be appended to the
path of the temporary directory. The complete name of the files created
by the plotting commands is always sent as output of those commands so
they can be seen if the command is ended by semi-colon.

When used in conjunction with the @mref{gnuplot_term} option, it can be
used to save the plot in a file, in one of the graphic formats supported
by Gnuplot. To create PNG, PDF, Postscript or SVG, it is easier to use
options @mrefcomma{png_file} @mrefcomma{pdf_file} @mrefcomma{ps_file}
or @mrefdot{svg_file}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_pm3d}
@defvr {Plot option} gnuplot_pm3d [gnuplot_pm3d, @var{value}]

With a value of @code{false}, it can be used to disable the use of PM3D
mode, which is enabled by default.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_preamble}
@defvr {Plot option} gnuplot_preamble [gnuplot_preamble, @var{string}]

This option inserts gnuplot commands before any other commands sent to
Gnuplot. Any valid gnuplot commands may be used. Multiple commands should
be separated with a semi-colon. See also @mrefdot{gnuplot_postamble}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_postamble}
@defvr {Plot option} gnuplot_postamble [gnuplot_postamble, @var{string}]

This option inserts gnuplot commands after other commands sent to
Gnuplot and right before the plot command is sent. Any valid gnuplot
commands may be used. Multiple commands should be separated with a
semi-colon. See also @mrefdot{gnuplot_preamble}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_default_term_command}
@defvr {Plot option} gnuplot_default_term_command
[gnuplot_default_term_command, @var{command}]

The gnuplot command to set the terminal type for the default
terminal. It this option is not set, the command used will be: @code{"set term wxt size 640,480 font \",12\"; set term pop"}.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_dumb_term_command}
@defvr {Plot option} gnuplot_dumb_term_command
[gnuplot_dumb_term_command, @var{command}]

The gnuplot command to set the terminal type for the dumb terminal.  It
this option is not set, the command used will be: @code{"set term dumb
79 22"}, which makes the text output 79 characters by 22 characters.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_pdf_term_command}
@defvr {Plot option} gnuplot_pdf_term_command [gnuplot_pdf_term_command, @var{command}]

The gnuplot command to set the terminal type for the PDF
terminal.  If this option is not set, the command used will be: @code{"set term pdfcairo color solid lw 3 size 17.2 cm, 12.9 cm font \",18\""}. See the gnuplot documentation for more information.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_png_term_command}
@defvr {Plot option} gnuplot_png_term_command [gnuplot_png_term_command, @var{command}]

The gnuplot command to set the terminal type for the PNG terminal.  If
this option is not set, the command used will be:
@code{"set term pngcairo font \",12\""}. See the gnuplot documentation
for more information.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_ps_term_command}
@defvr {Plot option} gnuplot_ps_term_command [gnuplot_ps_term_command, @var{command}]

The gnuplot command to set the terminal type for the PostScript
terminal.  If this option is not set, the command used will be: @code{"set term postscript eps color solid lw 2 size 16.4 cm, 12.3 cm font \",24\""}. See the gnuplot documentation for @code{set term postscript} for
more information.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_svg_term_command}
@defvr {Plot option} gnuplot_svg_term_command [gnuplot_svg_term_command, @var{command}]

The gnuplot command to set the terminal type for the SVG
terminal.  If this option is not set, the command used will be:
@code{"set term svg font \",14\""}. See the gnuplot documentation for
more information.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_curve_titles}
@defvr {Plot option} gnuplot_curve_titles

This is an obsolete option that has been replaced @mref{legend} described
above.

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{gnuplot_curve_styles}
@defvr {Plot option} gnuplot_curve_styles

This is an obsolete option that has been replaced by @mrefdot{style}

@opencatbox
@category{Plotting}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@node Gnuplot_pipes Format Functions,  , Gnuplot Options, Plotting
@section Gnuplot_pipes Format Functions
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{gnuplot_start}
@deffn {Function} gnuplot_start ()

Opens the pipe to gnuplot used for plotting with the @code{gnuplot_pipes}
format.  Is not necessary to manually open the pipe before plotting.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{gnuplot_close}
@deffn {Function} gnuplot_close ()

Closes the pipe to gnuplot which is used with the @code{gnuplot_pipes} format.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{gnuplot_restart}
@deffn {Function} gnuplot_restart ()

Closes the pipe to gnuplot which is used with the @code{gnuplot_pipes}
format and opens a new pipe.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{gnuplot_replot}
@deffn  {Function} gnuplot_replot @
@fname{gnuplot_replot} () @
@fname{gnuplot_replot} (@var{s})

Updates the gnuplot window.  If @code{gnuplot_replot} is called with a
gnuplot command in a string @var{s}, then @code{s} is sent to gnuplot
before reploting the window.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{gnuplot_reset}
@deffn {Function} gnuplot_reset ()

Resets the state of gnuplot used with the @code{gnuplot_pipes} format.  To
update the gnuplot window call @mref{gnuplot_replot} after @code{gnuplot_reset}.

@opencatbox
@category{Plotting}
@closecatbox
@end deffn

