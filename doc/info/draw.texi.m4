@c -*- Mode: texinfo -*-
@menu
* Introduction to draw::
* Functions and Variables for draw::
* Functions and Variables for pictures::
* Functions and Variables for worldmap::
@end menu



@node Introduction to draw, Functions and Variables for draw, draw-pkg, draw-pkg
@section Introduction to draw


@code{draw} is a Maxima-Gnuplot and a Maxima-vtk interface.

There are three main functions to be used at Maxima level: 
@itemize @bullet
@item @mrefcomma{draw2d} draws a single 2D scene.
@item @mrefcomma{draw3d} draws a single 3D scene.
@item @mrefcomma{draw} can be filled with multiple @mref{gr2d} and @mref{gr3d}
      commands that each creates a draw scene all sharing the same window.
@end itemize      
Each scene can contain any number of objects and @code{key=value} pairs
with options for the scene or the following objects.

A selection of useful objects a scene can be made up from are:
@itemize @bullet
@item @mref{explicit} plots a function.
@item @mref{implicit} plots all points an equation is true at.
@item @mref{points} plots points that are connected by lines if the option
      @mref{points_joined} was set to @code{true} in a previous line of the
      current scene.
@item @mref{parametric} allows to specify separate expressions that calculate
      the x, y (and in 3d plots also for the z) variable.
@end itemize

A short description of all draw commands and options including example plots
(in the html and pdf version of this manual) can be found in the section
@xref{Functions and Variables for draw}. A online version of the html manual can be
found at @url{maxima.sourceforge.net/docs/manual/maxima_singlepage.html#draw}. 
More elaborated examples of this package can be found at the following locations:

@url{http://tecnostats.net/Maxima/gnuplot} @*
@url{http://tecnostats.net/Maxima/vtk} 

Example:

@example
(%i1) draw2d(
          title="Two simple plots",
          xlabel="x",ylabel="y",grid=true,

          color=red,key="A sinus",
          explicit(sin(x),x,1,10),
          color=blue,line_type=dots,key="A cosinus",
          explicit(cos(x),x,1,10)
)$
@end example
@figure{draw_intro}

You need Gnuplot 4.2 or newer to run draw; If you are using wxMaxima as a
front end @code{wxdraw}, @code{wxdraw2d} and @code{wxdraw3d} are drop-in
replacements for draw that do the same as @mrefcomma{draw} @mref{draw2d} and
@mref{draw3d} but embed the resulting plot in the worksheet.

@opencatbox
@category{Plotting}
@category{Share packages}
@category{Package draw}
@closecatbox


@node Functions and Variables for draw, Functions and Variables for pictures, Introduction to draw, draw-pkg
@section Functions and Variables for draw




@subsection Scenes


@anchor{gr2d}
@deffn {Scene constructor} gr2d (@var{argument_1}, ...)

Function @code{gr2d} builds an object describing a 2D scene. Arguments are
@i{graphic options}, @i{graphic objects}, or lists containing both graphic options and objects.
This scene is interpreted sequentially: @i{graphic options} affect those @i{graphic objects}
placed on its right. Some @i{graphic options} affect the global appearance of the scene.

This is the list of @i{graphic objects} available for scenes in two dimensions:
@mrefcomma{bars} @mrefcomma{ellipse} @mrefcomma{explicit} @mrefcomma{image} @mrefcomma{implicit} @mrefcomma{label}
@mrefcomma{parametric} @mrefcomma{points} @mrefcomma{polar} @mrefcomma{polygon} @mrefcomma{quadrilateral}
@mrefcomma{rectangle} @mrefcomma{triangle} @mref{vector} and @code{geomap}
(this one defined in package @code{worldmap}).

See also @mref{draw}
and @mrefdot{draw2d}

@c ===beg===
@c draw(
@c     gr2d(
@c         key="sin (x)",grid=[2,2],
@c         explicit(
@c             sin(x),
@c             x,0,2*%pi
@c         )
@c     ),
@c     gr2d(
@c         key="cos (x)",grid=[2,2],
@c         explicit(
@c             cos(x),
@c             x,0,2*%pi
@c         )
@c     )
@c  );
@c ===end===
@example
(%i1) draw(
    gr2d(
        key="sin (x)",grid=[2,2],
        explicit(
            sin(x),
            x,0,2*%pi
        )
    ),
    gr2d(
        key="cos (x)",grid=[2,2],
        explicit(
            cos(x),
            x,0,2*%pi
        )
    )
 );
(%o1)           [gr2d(explicit), gr2d(explicit)]
@end example
@figure{draw_scene}


@opencatbox
@category{Package draw}
@closecatbox

@end deffn


@anchor{gr3d}
@deffn {Scene constructor} gr3d (@var{argument_1}, ...)

Function @code{gr3d} builds an object describing a 3d scene. Arguments are
@i{graphic options}, @i{graphic objects}, or lists containing both graphic options
and objects. This scene is interpreted sequentially: @i{graphic options} affect those 
@i{graphic objects} placed on its right. Some @i{graphic options} affect the global
appearance of the scene.

This is the list of @i{graphic objects} available for scenes in three
dimensions:@*
@mrefcomma{cylindrical} @mrefcomma{elevation_grid} @mrefcomma{explicit} @mrefcomma{implicit}
@mrefcomma{label} @mrefcomma{mesh} @mrefcomma{parametric}@*
@mrefcomma{parametric_surface} @mrefcomma{points} @mrefcomma{quadrilateral}
@mrefcomma{spherical} @mrefcomma{triangle} @mrefcomma{tube}@*
@mrefcomma{vector} and @mref{geomap} (this one defined in package @code{worldmap}).

See also @mref{draw} and @mrefdot{draw3d}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@subsection Functions



@anchor{draw}
@deffn {Function} draw (<arg_1>, ...)

Plots a series of scenes; its arguments are @code{gr2d} and/or @code{gr3d} 
objects, together with some options, or lists of scenes and options.
By default, the scenes are put together
in one column.

Besides scenes the function @code{draw} accepts the following global options:
@mrefcomma{terminal} @mrefcomma{columns} @mrefcomma{dimensions} @mref{file_name}
and @mrefdot{delay}

Functions @mref{draw2d} and @mref{draw3d} short cuts that can be used 
when only one scene is required, in two or three dimensions, respectively.

See also @mref{gr2d} and @mrefdot{gr3d}

Examples:

@example
(%i1) scene1: gr2d(title="Ellipse",
                   nticks=300,
                   parametric(2*cos(t),5*sin(t),t,0,2*%pi))$
(%i2) scene2: gr2d(title="Triangle",
                   polygon([4,5,7],[6,4,2]))$
(%i3) draw(scene1, scene2, columns = 2)$
@end example
@figure{draw_intro2}

@example
(%i1) scene1: gr2d(title="A sinus",
        grid=true,
        explicit(sin(t),t,0,2*%pi))$
(%i2) scene2: gr2d(title="A cosinus",
        grid=true,
        explicit(cos(t),t,0,2*%pi))$
(%i3) draw(scene1, scene2)$
@end example
@figure{draw_intro3}

The following two draw sentences are equivalent:
@example
(%i1) draw(gr3d(explicit(x^2+y^2,x,-1,1,y,-1,1)));
(%o1)                          [gr3d(explicit)]
(%i2) draw3d(explicit(x^2+y^2,x,-1,1,y,-1,1));
(%o2)                          [gr3d(explicit)]
@end example

Creating an animated gif file:
@example
(%i1) draw(
        delay     = 100,
        file_name = "zzz",
        terminal  = 'animated_gif,
        gr2d(explicit(x^2,x,-1,1)),
        gr2d(explicit(x^3,x,-1,1)),
        gr2d(explicit(x^4,x,-1,1)));
End of animation sequence
(%o1)          [gr2d(explicit), gr2d(explicit), gr2d(explicit)]
@end example
@figure{draw_equiv}
See also @mrefcomma{gr2d} @mrefcomma{gr3d} @mref{draw2d} and @mrefdot{draw3d}

@opencatbox
@category{Package draw}
@category{File output}
@closecatbox
@end deffn





@anchor{draw2d}
@deffn {Function} draw2d (@var{argument_1}, ...)

This function is a shortcut for
@code{draw(gr2d(@var{options}, ..., @var{graphic_object}, ...))}.

It can be used to plot a unique scene in 2d, as can be seen in most examples below.

See also @mref{draw} and @mrefdot{gr2d}

@opencatbox
@category{Package draw}
@category{File output}
@closecatbox
@end deffn






@anchor{draw3d}
@deffn {Function} draw3d (@var{argument_1}, ...)

This function is a shortcut for
@code{draw(gr3d(@var{options}, ..., @var{graphic_object}, ...))}.

It can be used to plot a unique scene in 3d, as can be seen in many examples below.

See also @mref{draw} and @mrefdot{gr3d}

@opencatbox
@category{Package draw}
@category{File output}
@closecatbox
@end deffn



@anchor{draw_file}
@deffn {Function} draw_file (@var{graphic option}, ..., @var{graphic object}, ...)

Saves the current plot into a file. Accepted graphics options are:
@code{terminal}, @code{dimensions} and @code{file_name}. 

Example:

@example
(%i1) /* screen plot */
      draw(gr3d(explicit(x^2+y^2,x,-1,1,y,-1,1)))$
(%i2) /* same plot in eps format */
      draw_file(terminal  = eps,
                dimensions = [5,5]) $
@end example

@opencatbox
@category{Package draw}
@category{File output}
@closecatbox
@end deffn



@anchor{multiplot_mode}
@deffn {Function} multiplot_mode (@var{term})

This function enables Maxima to work in one-window multiplot mode with terminal
@var{term}; accepted arguments for this function are @code{screen}, 
@code{wxt}, @code{aquaterm}, @code{windows} and @code{none}.

When multiplot mode is enabled, each call to @code{draw} sends a new plot to the
same window, without erasing the previous ones. To disable the multiplot mode,
write @code{multiplot_mode(none)}.

When multiplot mode is enabled, global option @code{terminal} is blocked and you
have to disable this working mode before changing to another terminal.

On Windows this feature requires Gnuplot 5.0 or newer.
Note, that just plotting multiple expressions into the same plot doesn't require
multiplot: It can be done by just issuing multiple @mref{explicit} or similar
commands in a row.

Example:

@example
(%i1) set_draw_defaults(
         xrange = [-1,1],
         yrange = [-1,1],
         grid   = true,
         title  = "Step by step plot" )$
(%i2) multiplot_mode(screen)$
(%i3) draw2d(color=blue,  explicit(x^2,x,-1,1))$
(%i4) draw2d(color=red,   explicit(x^3,x,-1,1))$
(%i5) draw2d(color=brown, explicit(x^4,x,-1,1))$
(%i6) multiplot_mode(none)$
@end example
@figure{draw_multiplot}

@opencatbox
@category{Package draw}
@category{File output}
@closecatbox
@end deffn





@anchor{set_draw_defaults}
@deffn {Function} set_draw_defaults (@var{graphic option}, ..., @var{graphic object}, ...)

Sets user graphics options. This function is useful for plotting a sequence
of graphics with common graphics options. Calling this function without
arguments removes user defaults.

Example:

@example
(%i1) set_draw_defaults(
         xrange = [-10,10],
         yrange = [-2, 2],
         color  = blue,
         grid   = true)$
(%i2) /* plot with user defaults */
      draw2d(explicit(((1+x)**2/(1+x*x))-1,x,-10,10))$
(%i3) set_draw_defaults()$
(%i4) /* plot with standard defaults */
      draw2d(explicit(((1+x)**2/(1+x*x))-1,x,-10,10))$
@end example

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@subsection Graphics options


@anchor{adapt_depth_draw}
@defvr {Graphic option} adapt_depth
Default value: 10

@code{adapt_depth} is the maximum number of splittings used by the adaptive plotting routine.

This option is relevant only for 2d @code{explicit} functions.

See also @code{nticks}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr


@anchor{allocation}
@defvr {Graphic option} allocation
Default value: @code{false}

With option @code{allocation} it is possible to place a scene in the
output window at will; this is of interest in multiplots. When @code{false},
the scene is placed automatically, depending on the value assigned to option
@code{columns}. In any other case, @code{allocation} must be set to a list of
two pairs of numbers; the first corresponds to the position of the lower left
corner of the scene, and the second pair gives the width and height of the plot.
All quantities must be given in relative coordinates, between 0 and 1.

Examples:

In site graphics.

@example
(%i1) draw(
        gr2d(
          explicit(x^2,x,-1,1)),
        gr2d(
          allocation = [[1/4, 1/4],[1/2, 1/2]],
          explicit(x^3,x,-1,1),
          grid = true) ) $
@end example
@figure{draw_allocation}

Multiplot with selected dimensions.

@example
(%i1) draw(
        terminal = wxt,
        gr2d(
          grid=[5,5],
          allocation = [[0, 0],[1, 1/4]],
          explicit(x^2,x,-1,1)),
        gr3d(
          allocation = [[0, 1/4],[1, 3/4]],
          explicit(x^2+y^2,x,-1,1,y,-1,1) ))$
@end example
@figure{draw_allocation2}

See also option @mrefdot{columns}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr


@anchor{axis_3d}
@defvr {Graphic option} axis_3d
Default value: @code{true}

If @code{axis_3d} is @code{true}, the @var{x}, @var{y} and @var{z} axis are shown in 3d scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(axis_3d = false,
             explicit(sin(x^2+y^2),x,-2,2,y,-2,2) )$
@end example
@figure{draw_axis3d}

See also @mrefcomma{axis_bottom}  @mrefcomma{axis_left} @mrefcomma{axis_top} and @mref{axis_right} for axis in 2d.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{axis_bottom}
@defvr {Graphic option} axis_bottom
Default value: @code{true}

If @code{axis_bottom} is @code{true}, the bottom axis is shown in 2d scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(axis_bottom = false,
             explicit(x^3,x,-1,1))$
@end example
@figure{draw_axis_bottom}

See also @mrefcomma{axis_left}  @mrefcomma{axis_top} @mref{axis_right} and @mrefdot{axis_3d}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{axis_left}
@defvr {Graphic option} axis_left
Default value: @code{true}

If @code{axis_left} is @code{true}, the left axis is shown in 2d scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(axis_left = false,
             explicit(x^3,x,-1,1))$
@end example

See also @mrefcomma{axis_bottom}  @mrefcomma{axis_top} @mref{axis_right} and @mrefdot{axis_3d}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{axis_right}
@defvr {Graphic option} axis_right
Default value: @code{true}

If @code{axis_right} is @code{true}, the right axis is shown in 2d scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(axis_right = false,
             explicit(x^3,x,-1,1))$
@end example

See also @mrefcomma{axis_bottom}  @mrefcomma{axis_left} @mref{axis_top} and @mrefdot{axis_3d}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{axis_top}
@defvr {Graphic option} axis_top
Default value: @code{true}

If @code{axis_top} is @code{true}, the top axis is shown in 2d scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(axis_top = false,
             explicit(x^3,x,-1,1))$
@end example

See also @mrefcomma{axis_bottom}   @mrefcomma{axis_left}  @mrefcomma{axis_right}  and @mrefdot{axis_3d}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{background_color}
@defvr {Graphic option} background_color
Default value: @code{white}

Sets the background color for terminals. Default background color is white.

Since this is a global graphics option, its position in the scene description
does not matter.

This option das not work with terminals @code{epslatex} and @code{epslatex_standalone}.

See also @code{color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{border}
@defvr {Graphic option} border
Default value: @code{true}

If @code{border} is @code{true}, borders of polygons are painted
according to @code{line_type} and @code{line_width}.

This option affects the following graphic objects:
@itemize @bullet

@item
@code{gr2d}: @mrefcomma{polygon} @mref{rectangle} and @mrefdot{ellipse}
@end itemize

Example:

@example
(%i1) draw2d(color       = brown,
             line_width  = 8,
             polygon([[3,2],[7,2],[5,5]]),
             border      = false,
             fill_color  = blue,
             polygon([[5,2],[9,2],[7,5]]) )$
@end example
@figure{draw_border}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{capping}
@defvr {Graphic option} capping
Default value: @code{[false, false]}

A list with two possible elements, @code{true} and @code{false},
indicating whether the extremes of a graphic object @code{tube} remain closed
or open. By default, both extremes are left open.

Setting @code{capping = false} is equivalent to @code{capping = [false, false]},
and @code{capping = true} is equivalent to @code{capping = [true, true]}.

Example:

@example
(%i1) draw3d(
        capping = [false, true],
        tube(0, 0, a, 1,
             a, 0, 8) )$
@end example
@figure{draw_tube_extremes}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{cbrange}
@defvr {Graphic option} cbrange
Default value: @code{auto}

If @code{cbrange} is @code{auto}, the range for the values which are
colored when @code{enhanced3d} is not @code{false} is computed
automatically. Values outside of the color range use color of the
nearest extreme.

When @code{enhanced3d} or @code{colorbox} is @code{false}, option @code{cbrange} has
no effect.

If the user wants a specific interval for the colored values, it must
be given as a Maxima list, as in @code{cbrange=[-2, 3]}.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d (
        enhanced3d     = true,
        color          = green,
        cbrange = [-3,10],
        explicit(x^2+y^2, x,-2,2,y,-2,2)) $
@end example
@figure{draw_cbrange}

See also @mrefcomma{enhanced3d}  @mref{colorbox} and @mrefdot{cbtics}

@opencatbox
@category{Package draw}
@closecatbox
@end defvr



@anchor{cbtics}
@defvr {Graphic option} cbtics
Default value: @code{auto}

This graphic option controls the way tic marks are drawn on the colorbox
when option @code{enhanced3d} is not @code{false}.

When @code{enhanced3d} or @code{colorbox} is @code{false}, option @code{cbtics} has
no effect.

See @code{xtics} for a complete description.

Example :

@example
(%i1) draw3d (
        enhanced3d = true,
        color      = green,
        cbtics  = @{["High",10],["Medium",05],["Low",0]@},
        cbrange = [0, 10],
        explicit(x^2+y^2, x,-2,2,y,-2,2)) $
@end example
@figure{draw_cbtics}

See also @mrefcomma{enhanced3d}  @mref{colorbox} and @mrefdot{cbrange}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr

@anchor{color_draw}
@defvr {Graphic option} color
Default value: @code{blue}

@code{color} specifies the color for plotting lines, points, borders of
polygons and labels.

Colors can be given as names or in hexadecimal @i{rgb} code. If a gnuplot
version >= 5.0 is used and the terminal that is in use supports this
@i{rgba} colors with transparency information are also supported.

Available color names are:
@verbatim
white            black            gray0            grey0 
gray10           grey10           gray20           grey20     
gray30           grey30           gray40           grey40     
gray50           grey50           gray60           grey60     
gray70           grey70           gray80           grey80
gray90           grey90           gray100          grey100 
gray             grey             light_gray       light_grey 
dark_gray        dark_grey        red              light_red 
dark_red         yellow           light_yellow     dark_yellow
green            light_green      dark_green       spring_green
forest_green     sea_green        blue             light_blue 
dark_blue        midnight_blue    navy             medium_blue 
royalblue        skyblue          cyan             light_cyan 
dark_cyan        magenta          light_magenta    dark_magenta
turquoise        light_turquoise  dark_turquoise   pink 
light_pink       dark_pink        coral            light_coral 
orange_red       salmon           light_salmon     dark_salmon 
aquamarine       khaki            dark_khaki       goldenrod 
light_goldenrod  dark_goldenrod   gold             beige 
brown            orange           dark_orange      violet 
dark_violet      plum             purple
@end verbatim

Cromatic componentes in hexadecimal code are introduced in the form @code{"#rrggbb"}.

Example:

@example
(%i1) draw2d(explicit(x^2,x,-1,1), /* default is black */
             color = red,
             explicit(0.5 + x^2,x,-1,1),
             color = blue,
             explicit(1 + x^2,x,-1,1),
             color = light_blue,
             explicit(1.5 + x^2,x,-1,1),
             color = "#23ab0f",
             label(["This is a label",0,1.2])  )$
@end example
@figure{draw_color}
@example
(%i1) draw2d(
             line_width=50,
             color="#FF0000",
             explicit(sin(x),x,0,10),
             color="#0000FF80",
             explicit(cos(x),x,0,10)
      );
@end example
@figure{draw_color2}

@example
(%i1) H(p,p_0):=%i/(2*%pi*(p-p_0));
      draw2d(
          proportional_axes=xy,
          ip_grid=[150,150],
          grid=true,
          makelist(
              [
                  color=printf(false,"#~2,'0x~2,'0x~2,'0x",i*10,0,0),
                  key_pos=top_left,
                  key = if mod(i,5)=0 then sconcat("H=",i,"A/M") else "",
                  implicit(
                      cabs(H(x+%i*y,-1-%i)+H(x+%i*y,1+%i)-H(x+%i*y,1-%i)-H(x+%i*y,-1+%i))=i/10,
                      x,-3,3,
                      y,-3,3
                  )
              ],
              i,1,25
          )
      )$
@end example
@figure{draw_color3}


See also @mrefdot{fill_color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{colorbox}
@defvr {Graphic option} colorbox
Default value: @code{true}

If @code{colorbox} is @code{true}, a color scale without label is drawn together with 
@code{image} 2D objects, or coloured 3d objects. If @code{colorbox} is @code{false}, no 
color scale is shown. If @code{colorbox} is a string, a color scale with label is drawn.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

Color scale and images.

@example
(%i1) im: apply('matrix,
                 makelist(makelist(random(200),i,1,30),i,1,30))$
(%i2) draw(
          gr2d(image(im,0,0,30,30)),
          gr2d(colorbox = false, image(im,0,0,30,30))
      )$
@end example
@figure{draw_colorbox}
Color scale and 3D coloured object.

@example
(%i1) draw3d(
        colorbox   = "Magnitude",
        enhanced3d = true,
        explicit(x^2+y^2,x,-1,1,y,-1,1))$
@end example
@figure{draw_colorbox2}

See also @mrefdot{palette_draw}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{columns}
@defvr {Graphic option} columns
Default value: 1

@code{columns} is the number of columns in multiple plots.

Since this is a global graphics option, its position in the scene description
does not matter. It can be also used as an argument of function @code{draw}.

Example:

@example
(%i1) scene1: gr2d(title="Ellipse",
                   nticks=30,
                   parametric(2*cos(t),5*sin(t),t,0,2*%pi))$
(%i2) scene2: gr2d(title="Triangle",
                   polygon([4,5,7],[6,4,2]))$
(%i3) draw(scene1, scene2, columns = 2)$
@end example
@figure{draw_columns}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{contour}
@defvr {Graphic option} contour
Default value: @code{none}

Option @code{contour} enables the user to select where to plot contour lines.
Possible values are:

@itemize @bullet

@item
@code{none}:
no contour lines are plotted.

@item
@code{base}:
contour lines are projected on the xy plane.

@item
@code{surface}:
contour lines are plotted on the surface.

@item
@code{both}:
two contour lines are plotted: on the xy plane and on the surface.

@item
@code{map}:
contour lines are projected on the xy plane, and the view point is
set just in the vertical.

@end itemize

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(explicit(20*exp(-x^2-y^2)-10,x,0,2,y,-3,3),
             contour_levels = 15,
             contour        = both,
             surface_hide   = true) $
@end example
@figure{draw_contour}

@example
(%i1) draw3d(explicit(20*exp(-x^2-y^2)-10,x,0,2,y,-3,3),
             contour_levels = 15,
             contour        = map
      ) $
@end example
@figure{draw_contour2}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{contour_levels}
@defvr {Graphic option} contour_levels
Default value: 5

This graphic option controls the way contours are drawn. 
@code{contour_levels} can be set to a positive integer number, a list of three
numbers or an arbitrary set of numbers:

@itemize @bullet
@item
When option @code{contour_levels} is bounded to positive integer @var{n},
@var{n} contour lines will be drawn at equal intervals. By default, five
equally spaced contours are plotted.

@item
When option @code{contour_levels} is bounded to a list of length three of the
form @code{[lowest,s,highest]}, contour lines are plotted from @code{lowest} 
to @code{highest} in steps of @code{s}.

@item
When option @code{contour_levels} is bounded to a set of numbers of the
form @code{@{n1, n2, ...@}}, contour lines are plotted at values @code{n1},
@code{n2}, ...
@end itemize

Since this is a global graphics option, its position in the scene description
does not matter.

Examples:

Ten equally spaced contour lines. The actual number of
levels can be adjusted to give simple labels.
@example
(%i1) draw3d(color = green,
             explicit(20*exp(-x^2-y^2)-10,x,0,2,y,-3,3),
             contour_levels = 10,
             contour        = both,
             surface_hide   = true) $
@end example


From -8 to 8 in steps of 4.
@example
(%i1) draw3d(color = green,
             explicit(20*exp(-x^2-y^2)-10,x,0,2,y,-3,3),
             contour_levels = [-8,4,8],
             contour        = both,
             surface_hide   = true) $
@end example

Isolines at levels -7, -6, 0.8 and 5.
@example
(%i1) draw3d(color = green,
             explicit(20*exp(-x^2-y^2)-10,x,0,2,y,-3,3),
             contour_levels = @{-7, -6, 0.8, 5@},
             contour        = both,
             surface_hide   = true) $
@end example

See also @mrefdot{contour}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{data_file_name}
@defvr {Graphic option} data_file_name
Default value: @code{"data.gnuplot"}

This is the name of the file with the numeric data needed
by Gnuplot to build the requested plot.

Since this is a global graphics option, its position in the scene description
does not matter. It can be also used as an argument of function @code{draw}.

See example in @code{gnuplot_file_name}.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{delay}
@defvr {Graphic option} delay
Default value: 5

This is the delay in 1/100 seconds of frames in animated gif files.

Since this is a global graphics option, its position in the scene description
does not matter. It can be also used as an argument of function @code{draw}.

Example:

@example
(%i1) draw(
        delay     = 100,
        file_name = "zzz",
        terminal  = 'animated_gif,
        gr2d(explicit(x^2,x,-1,1)),
        gr2d(explicit(x^3,x,-1,1)),
        gr2d(explicit(x^4,x,-1,1)));
End of animation sequence
(%o2)          [gr2d(explicit), gr2d(explicit), gr2d(explicit)]
@end example

Option @code{delay} is only active in animated gif's; it is ignored in
any other case.

See also @mrefcomma{terminal} and @code{dimensions}.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{dimensions_draw}
@defvr {Graphic option} dimensions
Default value: @code{[600,500]}

Dimensions of the output terminal. Its value is a list formed by
the width and the height. The meaning of the two numbers depends on
the terminal you are working with.

With terminals @code{gif}, @code{animated_gif}, @code{png}, @code{jpg},
@code{svg}, @code{screen}, @code{wxt}, and @code{aquaterm},
the integers represent the number of points in each direction. If they
are not intergers, they are rounded.

With terminals @code{eps}, @code{eps_color}, @code{pdf}, and 
@code{pdfcairo}, both numbers represent hundredths of cm, which
means that, by default, pictures in these formats are 6 cm in
width and 5 cm in height.

Since this is a global graphics option, its position in the scene description
does not matter. It can be also used as an argument of function @code{draw}.

Examples:

Option @code{dimensions} applied to file output
and to wxt canvas.

@example
(%i1) draw2d(
        dimensions = [300,300],
        terminal   = 'png,
        explicit(x^4,x,-1,1)) $
(%i2) draw2d(
        dimensions = [300,300],
        terminal   = 'wxt,
        explicit(x^4,x,-1,1)) $
@end example

Option @code{dimensions} applied to eps output.
We want an eps file with A4 portrait dimensions.

@example
(%i1) A4portrait: 100*[21, 29.7]$
(%i2) draw3d(
        dimensions = A4portrait,
        terminal   = 'eps,
        explicit(x^2-y^2,x,-2,2,y,-2,2)) $
@end example

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{draw_realpart}
@defvr {Graphic option} draw_realpart
Default value: @code{true}

When @code{true}, functions to be drawn are considered as complex functions whose
real part value should be plotted; when @code{false}, nothing will be plotted when
the function does not give a real value. 

This option affects objects @mref{explicit} and @mref{parametric} in 2D and 3D, and
@mrefdot{parametric_surface}

Example:
@example
(%i1) draw2d(
        draw_realpart = false,
        explicit(sqrt(x^2  - 4*x) - x, x, -1, 5),
        color         = red,
        draw_realpart = true,
        parametric(x,sqrt(x^2  - 4*x) - x + 1, x, -1, 5) );
@end example

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{enhanced3d}
@defvr {Graphic option} enhanced3d
Default value: @code{none}

If @code{enhanced3d} is @code{none}, surfaces are not colored in 3D plots.
In order to get a colored surface, a list must be assigned to option
@mrefcomma{enhanced3d} where the first element is an expression and the rest
are the names of the variables or parameters used in that expression. A list such 
@code{[f(x,y,z), x, y, z]} means that point @code{[x,y,z]} of the surface 
is assigned number @code{f(x,y,z)}, which will be colored according to 
the actual @code{palette}. For those 3D graphic objects defined in terms of
parameters, it is possible to define the color number in terms of
the parameters, as in @code{[f(u), u]}, as in objects @mref{parametric} and 
@mrefcomma{tube} or @code{[f(u,v), u, v]}, as in object @code{parametric_surface}.
While all 3D objects admit the model based on absolute coordinates,
@code{[f(x,y,z), x, y, z]}, only two of them, namely @code{explicit}
and @mrefcomma{elevation_grid} accept also models defined on the @code{[x,y]} coordinates,
@code{[f(x,y), x, y]}. 3D graphic object @code{implicit} accepts only the
@code{[f(x,y,z), x, y, z]} model. Object @code{points} accepts also the
@code{[f(x,y,z), x, y, z]} model, but when points have a chronological nature,
model @code{[f(k), k]} is also valid, being @code{k} an ordering parameter.

When @code{enhanced3d} is assigned something different to @code{none}, options
@code{color} and @code{surface_hide} are ignored.

The names of the variables defined in the lists may be different to those
used in the definitions of the graphic objects.

In order to maintain back compatibility, @code{enhanced3d = false} is equivalent
to @code{enhanced3d = none}, and @code{enhanced3d = true} is equivalent to 
@code{enhanced3d = [z, x, y, z]}.  If an expression is given to @mrefcomma{enhanced3d}
its variables must be the same used in the surface definition. This is not
necessary when using lists.

See option @code{palette} to learn how palettes are specified.

Examples:

@code{explicit} object with coloring defined by the @code{[f(x,y,z), x, y, z]} model.

@example
(%i1) draw3d(
         enhanced3d = [x-z/10,x,y,z],
         palette    = gray,
         explicit(20*exp(-x^2-y^2)-10,x,-3,3,y,-3,3))$
@end example
@figure{draw_enhanced3d}

@code{explicit} object with coloring defined by the @code{[f(x,y), x, y]} model.
The names of the variables defined in the lists may be different to those
used in the definitions of the graphic objects; in this case, @code{r} corresponds
to @code{x}, and @code{s} to @code{y}.

@example
(%i1) draw3d(
         enhanced3d = [sin(r*s),r,s],
         explicit(20*exp(-x^2-y^2)-10,x,-3,3,y,-3,3))$
@end example
@figure{draw_enhanced3d2}

@code{parametric} object with coloring defined by the @code{[f(x,y,z), x, y, z]} model.

@example
(%i1) draw3d(
         nticks = 100,
         line_width = 2,
         enhanced3d = [if y>= 0 then 1 else 0, x, y, z],
         parametric(sin(u)^2,cos(u),u,u,0,4*%pi)) $
@end example
@figure{draw_enhanced3d3}

@code{parametric} object with coloring defined by the @code{[f(u), u]} model.
In this case, @code{(u-1)^2} is a shortcut for @code{[(u-1)^2,u]}.

@example
(%i1) draw3d(
         nticks = 60,
         line_width = 3,
         enhanced3d = (u-1)^2,
         parametric(cos(5*u)^2,sin(7*u),u-2,u,0,2))$
@end example
@figure{draw_enhanced3d4}

@code{elevation_grid} object with coloring defined by the @code{[f(x,y), x, y]} model.

@example
(%i1) m: apply(
           matrix,
           makelist(makelist(cos(i^2/80-k/30),k,1,30),i,1,20)) $
(%i2) draw3d(
         enhanced3d = [cos(x*y*10),x,y],
         elevation_grid(m,-1,-1,2,2),
         xlabel = "x",
         ylabel = "y");
@end example
@figure{draw_enhanced3d5}

@code{tube} object with coloring defined by the @code{[f(x,y,z), x, y, z]} model.

@example
(%i1) draw3d(
         enhanced3d = [cos(x-y),x,y,z],
         palette = gray,
         xu_grid = 50,
         tube(cos(a), a, 0, 1, a, 0, 4*%pi) )$
@end example
@figure{draw_enhanced3d6}

@code{tube} object with coloring defined by the @code{[f(u), u]} model.
Here, @code{enhanced3d = -a} would be the shortcut for @code{enhanced3d = [-foo,foo]}.

@example
(%i1) draw3d(
         capping = [true, false],
         palette = [26,15,-2],
         enhanced3d = [-foo, foo],
         tube(a, a, a^2, 1, a, -2, 2) )$
@end example
@figure{draw_enhanced3d7}

@code{implicit} and @code{points} objects with coloring defined by the @code{[f(x,y,z), x, y, z]} model.

@example
(%i1) draw3d(
         enhanced3d = [x-y,x,y,z],
         implicit((x^2+y^2+z^2-1)*(x^2+(y-1.5)^2+z^2-0.5)=0.015,
                  x,-1,1,y,-1.2,2.3,z,-1,1)) $
(%i2) m: makelist([random(1.0),random(1.0),random(1.0)],k,1,2000)$
@end example
@figure{draw_enhanced3d9}
@example
(%i3) draw3d(
         point_type = filled_circle,
         point_size = 2,
         enhanced3d = [u+v-w,u,v,w],
         points(m) ) $
@end example
@figure{draw_enhanced3d10}

When points have a chronological nature, model @code{[f(k), k]} is also valid,
being @code{k} an ordering parameter.

@example
(%i1) m:makelist([random(1.0), random(1.0), random(1.0)],k,1,5)$
(%i2) draw3d(
         enhanced3d = [sin(j), j],
         point_size = 3,
         point_type = filled_circle,
         points_joined = true,
         points(m)) $
@end example
@figure{draw_enhanced3d11}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{error_type}
@defvr {Graphic option} error_type
Default value: @code{y}

Depending on its value, which can be @code{x}, @code{y}, or @code{xy},
graphic object @code{errors} will draw points with horizontal, vertical,
or both, error bars. When @code{error_type=boxes}, boxes will be drawn
instead of crosses.

See also @mrefdot{errors}
@end defvr



@anchor{file_name}
@defvr {Graphic option} file_name
Default value: @code{"maxima_out"}

This is the name of the file where terminals @code{png}, @code{jpg}, @code{gif},
@code{eps}, @code{eps_color}, @code{pdf}, @code{pdfcairo} and @code{svg}
will save the graphic.

Since this is a global graphics option, its position in the scene description
does not matter. It can be also used as an argument of function @code{draw}.

Example:

@example
(%i1) draw2d(file_name = "myfile",
             explicit(x^2,x,-1,1),
             terminal  = 'png)$
@end example

See also @mrefcomma{terminal}  @mrefdot{dimensions_draw}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{fill_color}
@defvr {Graphic option} fill_color
Default value: @code{"red"}

@code{fill_color} specifies the color for filling polygons and
2d @code{explicit} functions.

See @code{color} to learn how colors are specified.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{fill_density}
@defvr {Graphic option} fill_density
Default value: 0

@code{fill_density} is a number between 0 and 1 that specifies
the intensity of the @code{fill_color} in @code{bars} objects.

See @code{bars} for examples.
@end defvr




@anchor{filled_func}
@defvr {Graphic option} filled_func
Default value: @code{false}

Option @code{filled_func} controls how regions limited by functions
should be filled. When @code{filled_func} is @code{true}, the region
bounded by the function defined with object @code{explicit} and the
bottom of the graphic window is filled with @code{fill_color}. When 
@code{filled_func} contains a function expression, then the region bounded
by this function and the function defined with object @code{explicit} 
will be filled. By default, explicit functions are not filled.

A useful special case is @code{filled_func=0}, which generates the region 
bond by the horizontal axis and the explicit function.

This option affects only the 2d graphic object @mrefdot{explicit}

Example:

Region bounded by an @code{explicit} object and the bottom of the
graphic window.
@example
(%i1) draw2d(fill_color  = red,
             filled_func = true,
             explicit(sin(x),x,0,10) )$
@end example
@figure{draw_filledfunc}

Region bounded by an @code{explicit} object and the function
defined by option @code{filled_func}. Note that the variable in
@code{filled_func} must be the same as that used in @code{explicit}.
@example
(%i1) draw2d(fill_color  = grey,
             filled_func = sin(x),
             explicit(-sin(x),x,0,%pi));
@end example
@figure{draw_filledfunc2}
See also @mref{fill_color} and @mrefdot{explicit}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{font}
@defvr {Graphic option} font
Default value: @code{""} (empty string)

This option can be used to set the font face to be used by the terminal.
Only one font face and size can be used throughout the plot.

Since this is a global graphics option, its position in the scene description
does not matter.

See also @mrefdot{font_size}

Gnuplot doesn't handle fonts by itself, it leaves this task to the
support libraries of the different terminals, each one with its own
philosophy about it. A brief summary follows:

@itemize @bullet
@item
@i{x11}:
Uses the normal x11 font server mechanism.

Example:
@example
(%i1) draw2d(font      = "Arial", 
             font_size = 20,
             label(["Arial font, size 20",1,1]))$
@end example

@item
@i{windows}:
The windows terminal doesn't support changing of fonts from inside the plot.
Once the plot has been generated, the font can be changed right-clicking on
the menu of the graph window.

@item
@i{png, jpeg, gif}:
The @i{libgd} library uses the font path stored in the environment
variable @code{GDFONTPATH}; in this case, it is only necessary to
set option @code{font} to the font's name. It is also possible to
give the complete path to the font file.

Examples:

Option @code{font} can be given the complete path to the font file:
@example
(%i1) path: "/usr/share/fonts/truetype/freefont/" $
(%i2) file: "FreeSerifBoldItalic.ttf" $
(%i3) draw2d(
        font      = concat(path, file), 
        font_size = 20,
        color     = red,
        label(["FreeSerifBoldItalic font, size 20",1,1]),
        terminal  = png)$
@end example

If environment variable @env{GDFONTPATH} is set to the
path where font files are allocated, it is possible to
set graphic option @code{font} to the name of the font.
@example
(%i1) draw2d(
        font      = "FreeSerifBoldItalic", 
        font_size = 20,
        color     = red,
        label(["FreeSerifBoldItalic font, size 20",1,1]),
        terminal  = png)$
@end example

@item
@i{Postscript}:
Standard Postscript fonts are:@*
@code{"Times-Roman"}, @code{"Times-Italic"}, @code{"Times-Bold"},
@code{"Times-BoldItalic"},@*
@code{"Helvetica"}, @code{"Helvetica-Oblique"}, @code{"Helvetica-Bold"},@*
@code{"Helvetic-BoldOblique"}, @code{"Courier"},
@code{"Courier-Oblique"}, @code{"Courier-Bold"},@*
and @code{"Courier-BoldOblique"}.
  
Example:
@example
(%i1) draw2d(
        font      = "Courier-Oblique", 
        font_size = 15,
        label(["Courier-Oblique font, size 15",1,1]),
        terminal = eps)$
@end example

@item
@i{pdf}:
Uses same fonts as @i{Postscript}.

@item
@i{pdfcairo}:
Uses same fonts as @i{wxt}.

@item
@i{wxt}:
The @i{pango} library finds fonts via the @code{fontconfig} utility.

@item
@i{aqua}:
Default is @code{"Times-Roman"}.
@end itemize

The gnuplot documentation is an important source of information about terminals and fonts.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{font_size}
@defvr {Graphic option} font_size
Default value: 10

This option can be used to set the font size to be used by the terminal.
Only one font face and size can be used throughout the plot. @code{font_size} is
active only when option @code{font} is not equal to the empty string.

Since this is a global graphics option, its position in the scene description
does not matter.

See also @mrefdot{font}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{gnuplot_file_name}
@defvr {Graphic option} gnuplot_file_name
Default value: @code{"maxout_xxx.gnuplot"} with @code{"xxx"}
being a number that is unique to each concurrently-running
maxima process.

This is the name of the file with the necessary commands to
be processed by Gnuplot.

Since this is a global graphics option, its position in the scene description
does not matter. It can be also used as an argument of function @code{draw}.

Example:

@example
(%i1) draw2d(
       file_name = "my_file",
       gnuplot_file_name = "my_commands_for_gnuplot",
       data_file_name    = "my_data_for_gnuplot",
       terminal          = png,
       explicit(x^2,x,-1,1)) $
@end example

See also @mrefdot{data_file_name}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{grid_draw}
@defvr {Graphic option} grid
Default value: @code{false}

If @code{grid} is @code{not false}, a grid will be drawn on the @var{xy} plane.
If @code{grid} is assigned true, one grid line per tick of each axis is drawn.
If @code{grid} is assigned a list @code{nx,ny} with @code{[nx,ny] > [0,0]}
instead @code{nx} lines per tick of the x axis and @code{ny} lines per tick of
the y axis are drawn.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(grid = true,
             explicit(exp(u),u,-2,2))$
@end example
@figure{draw_grid}

@example
(%i1) draw2d(grid = [2,2],
             explicit(sin(x),x,0,2*%pi))$
@end example
@figure{draw_grid2}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{head_angle}
@defvr {Graphic option} head_angle
Default value: 45

@code{head_angle} indicates the angle, in degrees, between the arrow heads and
the segment.

This option is relevant only for @code{vector} objects.

Example:

@example
(%i1) draw2d(xrange      = [0,10],
             yrange      = [0,9],
             head_length = 0.7,
             head_angle  = 10,
             vector([1,1],[0,6]),
             head_angle  = 20,
             vector([2,1],[0,6]),
             head_angle  = 30,
             vector([3,1],[0,6]),
             head_angle  = 40,
             vector([4,1],[0,6]),
             head_angle  = 60,
             vector([5,1],[0,6]),
             head_angle  = 90,
             vector([6,1],[0,6]),
             head_angle  = 120,
             vector([7,1],[0,6]),
             head_angle  = 160,
             vector([8,1],[0,6]),
             head_angle  = 180,
             vector([9,1],[0,6]) )$
@end example
@figure{draw_head_angle}

See also @mrefcomma{head_both}  @mrefcomma{head_length}  and @mrefdot{head_type} 

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{head_both}
@defvr {Graphic option} head_both
Default value: @code{false}

If @code{head_both} is @code{true}, vectors are plotted with two arrow heads.
If @code{false}, only one arrow is plotted.

This option is relevant only for @code{vector} objects.

Example:

@example
(%i1) draw2d(xrange      = [0,8],
             yrange      = [0,8],
             head_length = 0.7,
             vector([1,1],[6,0]),
             head_both   = true,
             vector([1,7],[6,0]) )$
@end example
@figure{draw_head_both}

See also @mrefcomma{head_length}  @mrefcomma{head_angle}  and @mrefdot{head_type} 

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{head_length}
@defvr {Graphic option} head_length
Default value: 2

@code{head_length} indicates, in @var{x}-axis units, the length of arrow heads.

This option is relevant only for @code{vector} objects.

Example:

@example
(%i1) draw2d(xrange      = [0,12],
             yrange      = [0,8],
             vector([0,1],[5,5]),
             head_length = 1,
             vector([2,1],[5,5]),
             head_length = 0.5,
             vector([4,1],[5,5]),
             head_length = 0.25,
             vector([6,1],[5,5]))$
@end example
@figure{draw_head_length}

See also @mrefcomma{head_both}  @mrefcomma{head_angle}  and @mrefdot{head_type} 

@opencatbox
@category{Package draw}
@closecatbox

@end defvr





@anchor{head_type}
@defvr {Graphic option} head_type
Default value: @code{filled}

@code{head_type} is used to specify how arrow heads are plotted. Possible
values are: @code{filled} (closed and filled arrow heads), @code{empty}
(closed but not filled arrow heads), and @code{nofilled} (open arrow heads).

This option is relevant only for @code{vector} objects.

Example:

@example
(%i1) draw2d(xrange      = [0,12],
             yrange      = [0,10],
             head_length = 1,
             vector([0,1],[5,5]), /* default type */
             head_type = 'empty,
             vector([3,1],[5,5]),
             head_type = 'nofilled,
             vector([6,1],[5,5]))$
@end example
@figure{draw_head_type}

See also @mrefcomma{head_both}  @mrefcomma{head_angle}  and @mrefdot{head_length} 

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{interpolate_color}
@defvr {Graphic option} interpolate_color
Default value: @code{false}

This option is relevant only when @code{enhanced3d} is not @code{false}.

When @code{interpolate_color} is @code{false}, surfaces are colored with
homogeneous quadrangles. When @code{true}, color transitions are smoothed
by interpolation.

@code{interpolate_color} also accepts a list of two numbers, @code{[m,n]}.
For positive @var{m} and @var{n}, each quadrangle or triangle is interpolated
@var{m} times and @var{n} times in the respective direction. For negative
@var{m} and @var{n}, the interpolation frequency is chosen so that there will be at least
@var{|m|} and @var{|n|} points drawn; you can consider this as a special gridding function.
Zeros, i.e. @code{interpolate_color=[0,0]}, will automatically choose an
optimal number of interpolated surface points.

Also, @code{interpolate_color=true} is equivalent to @code{interpolate_color=[0,0]}.

Examples:

Color interpolation with explicit functions.

@example
(%i1) draw3d(
        enhanced3d   = sin(x*y),
        explicit(20*exp(-x^2-y^2)-10, x ,-3, 3, y, -3, 3)) $
@end example
@figure{draw_interpolate_color}
@example
(%i2) draw3d(
        interpolate_color = true,
        enhanced3d   = sin(x*y),
        explicit(20*exp(-x^2-y^2)-10, x ,-3, 3, y, -3, 3)) $
@end example
@figure{draw_interpolate_color2}
@example
(%i3) draw3d(
        interpolate_color = [-10,0],
        enhanced3d   = sin(x*y),
        explicit(20*exp(-x^2-y^2)-10, x ,-3, 3, y, -3, 3)) $
@end example
@figure{draw_interpolate_color3}

Color interpolation with the @code{mesh} graphic object.

Interpolating colors in parametric surfaces can give unexpected results.

@example
(%i1) draw3d( 
        enhanced3d = true,
        mesh([[1,1,3],   [7,3,1],[12,-2,4],[15,0,5]],
             [[2,7,8],   [4,3,1],[10,5,8], [12,7,1]],
             [[-2,11,10],[6,9,5],[6,15,1], [20,15,2]])) $
@end example
@figure{draw_interpolate_color4}
@example
(%i2) draw3d( 
        enhanced3d        = true,
        interpolate_color = true,
        mesh([[1,1,3],   [7,3,1],[12,-2,4],[15,0,5]],
             [[2,7,8],   [4,3,1],[10,5,8], [12,7,1]],
             [[-2,11,10],[6,9,5],[6,15,1], [20,15,2]])) $
@end example
@figure{draw_interpolate_color5}
@example
(%i3) draw3d( 
        enhanced3d        = true,
        interpolate_color = true,
        view=map,
        mesh([[1,1,3],   [7,3,1],[12,-2,4],[15,0,5]],
             [[2,7,8],   [4,3,1],[10,5,8], [12,7,1]],
             [[-2,11,10],[6,9,5],[6,15,1], [20,15,2]])) $
@end example
@figure{draw_interpolate_color6}

See also @mrefdot{enhanced3d} 

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{ip_grid}
@defvr {Graphic option} ip_grid
Default value: @code{[50, 50]}

@code{ip_grid} sets the grid for the first sampling in implicit plots.

This option is relevant only for @code{implicit} objects.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{ip_grid_in}
@defvr {Graphic option} ip_grid_in
Default value: @code{[5, 5]}

@code{ip_grid_in} sets the grid for the second sampling in implicit plots.

This option is relevant only for @code{implicit} objects.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{key}
@defvr {Graphic option} key
Default value: @code{""} (empty string)

@code{key} is the name of a function in the legend. If @code{key} is an
empty string, no key is assigned to the function.

This option affects the following graphic objects:
@itemize @bullet
@item
@code{gr2d}: @mrefcomma{points} @mrefcomma{polygon} @mrefcomma{rectangle}
@mrefcomma{ellipse} @mrefcomma{vector} @mrefcomma{explicit} @mrefcomma{implicit}
@mref{parametric} and @mrefdot{polar}

@item
@code{gr3d}: @mrefcomma{points} @mrefcomma{explicit} @mref{parametric}
and @mrefdot{parametric_surface}
@end itemize

Example:

@example
(%i1) draw2d(key   = "Sinus",
             explicit(sin(x),x,0,10),
             key   = "Cosinus",
             color = red,
             explicit(cos(x),x,0,10) )$
@end example
@figure{draw_key}
@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{key_pos}
@defvr {Graphic option} key_pos
Default value: @code{""} (empty string)

@code{key_pos} defines at which position the legend will be drawn. If @code{key} is an
empty string, @code{"top_right"} is used.
Available position specifiers are: @code{top_left}, @code{top_center}, @code{top_right},
@code{center_left}, @code{center}, @code{center_right},
@code{bottom_left}, @code{bottom_center}, and @code{bottom_right}.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(
        key_pos = top_left,
        key   = "x",
        explicit(x,  x,0,10),
        color= red,
        key   = "x squared",
        explicit(x^2,x,0,10))$
(%i3) draw3d(
        key_pos = center,
        key   = "x",
        explicit(x+y,x,0,10,y,0,10),
        color= red,
        key   = "x squared",
        explicit(x^2+y^2,x,0,10,y,0,10))$
@end example
@figure{draw_key_pos}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{label_alignment}
@defvr {Graphic option} label_alignment
Default value: @code{center}

@code{label_alignment} is used to specify where to write labels with
respect to the given coordinates. Possible values are: @code{center},
@code{left}, and @code{right}.

This option is relevant only for @code{label} objects.

Example:

@example
(%i1) draw2d(xrange          = [0,10],
             yrange          = [0,10],
             points_joined   = true,
             points([[5,0],[5,10]]),
             color           = blue,
             label(["Centered alignment (default)",5,2]),
             label_alignment = 'left,
             label(["Left alignment",5,5]),
             label_alignment = 'right,
             label(["Right alignment",5,8]))$
@end example
@figure{draw_label_alignment}

See also @mrefcomma{label_orientation}  and @code{color} 

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{label_orientation}
@defvr {Graphic option} label_orientation
Default value: @code{horizontal}

@code{label_orientation} is used to specify orientation of labels.
Possible values are: @code{horizontal}, and @code{vertical}.

This option is relevant only for @code{label} objects.

Example:

In this example, a dummy point is added to get an image.
Package @code{draw} needs always data to draw an scene.
@example
(%i1) draw2d(xrange     = [0,10],
             yrange     = [0,10],
             point_size = 0,
             points([[5,5]]),
             color      = navy,
             label(["Horizontal orientation (default)",5,2]),
             label_orientation = 'vertical,
             color             = "#654321",
             label(["Vertical orientation",1,5]))$
@end example
@figure{draw_label_orientation}

See also @mref{label_alignment} and @code{color} 

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{line_type}
@defvr {Graphic option} line_type
Default value: @code{solid}

@code{line_type} indicates how lines are displayed; possible values are
@code{solid} and @code{dots}, both available in all terminals, and
@code{dashes}, @code{short_dashes}, @code{short_long_dashes}, @code{short_short_long_dashes}, 
and @code{dot_dash}, which are not available in @code{png}, @code{jpg}, and @code{gif} terminals. 

This option affects the following graphic objects:
@itemize @bullet
@item
@code{gr2d}: @mrefcomma{points} @mrefcomma{polygon} @mrefcomma{rectangle}
@mrefcomma{ellipse} @mrefcomma{vector} @mrefcomma{explicit} @mrefcomma{implicit} 
@mref{parametric} and @mrefdot{polar}

@item
@code{gr3d}: @mrefcomma{points} @mrefcomma{explicit} @mref{parametric} and @mrefdot{parametric_surface}
@end itemize

Example:

@example
(%i1) draw2d(line_type = dots,
             explicit(1 + x^2,x,-1,1),
             line_type = solid, /* default */
             explicit(2 + x^2,x,-1,1))$
@end example
@figure{draw_line_type}

See also @mrefdot{line_width}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{line_width}
@defvr {Graphic option} line_width
Default value: 1

@code{line_width} is the width of plotted lines.
Its value must be a positive number.

This option affects the following graphic objects:
@itemize @bullet
@item
@code{gr2d}: @mrefcomma{points} @mrefcomma{polygon} @mrefcomma{rectangle} 
@mrefcomma{ellipse} @mrefcomma{vector} @mrefcomma{explicit} @mrefcomma{implicit} 
@mref{parametric} and @mrefdot{polar}

@item
@code{gr3d}: @mref{points} and @mrefdot{parametric}
@end itemize

Example:

@example
(%i1) draw2d(explicit(x^2,x,-1,1), /* default width */
             line_width = 5.5,
             explicit(1 + x^2,x,-1,1),
             line_width = 10,
             explicit(2 + x^2,x,-1,1))$
@end example
@figure{draw_line_width}

See also @mrefdot{line_type}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{logcb}
@defvr {Graphic option} logcb
Default value: @code{false}

If @mref{logcb} is @code{true}, the tics in the colorbox will be drawn in the
logarithmic scale.

When @code{enhanced3d} or @code{colorbox} is @code{false}, option @code{logcb} has
no effect.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d (
        enhanced3d = true,
        color      = green,
        logcb = true,
        logz  = true,
        palette = [-15,24,-9],
        explicit(exp(x^2-y^2), x,-2,2,y,-2,2)) $
@end example
@figure{draw_logcb}

See also @mrefcomma{enhanced3d}  @mref{colorbox} and @mrefdot{cbrange}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{logx_draw}
@defvr {Graphic option} logx
Default value: @code{false}

If @code{logx} is @code{true}, the @var{x} axis will be drawn in the
logarithmic scale.

Since this is a global graphics option, its position in the scene description
does not matter, with the exception that it should be written before any 
2D @code{explicit} object, so that @code{draw} can produce a better plot.

Example:

@example
(%i1) draw2d(logx = true,
             explicit(log(x),x,0.01,5))$
@end example

See also @mrefcomma{logy}  @mrefcomma{logx_secondary}  @mrefcomma{logy_secondary}  and @mrefdot{logz}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{logx_secondary}
@defvr {Graphic option} logx_secondary
Default value: @code{false}

If @code{logx_secondary} is @code{true}, the secondary @var{x} axis 
will be drawn in the logarithmic scale.

This option is relevant only for 2d scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(
        grid = true,
        key="x^2, linear scale",
        color=red,
        explicit(x^2,x,1,100),
        xaxis_secondary = true,
        xtics_secondary = true,
        logx_secondary  = true,
        key = "x^2, logarithmic x scale",
        color = blue,
        explicit(x^2,x,1,100) )$
@end example
@figure{draw_logx_secondary}

See also @mrefcomma{logx_draw}  @mrefcomma{logy_draw}  @mrefcomma{logy_secondary}  and @mrefdot{logz}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{logy_draw}
@defvr {Graphic option} logy
Default value: @code{false}

If @code{logy} is @code{true}, the @var{y} axis will be drawn in the
logarithmic scale.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(logy = true,
             explicit(exp(x),x,0,5))$
@end example

See also @mrefcomma{logx_draw}  @mrefcomma{logx_secondary}  @mrefcomma{logy_secondary}  and @mrefdot{logz}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{logy_secondary}
@defvr {Graphic option} logy_secondary
Default value: @code{false}

If @code{logy_secondary} is @code{true}, the secondary @var{y} axis 
will be drawn in the logarithmic scale.

This option is relevant only for 2d scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(
        grid = true,
        key="x^2, linear scale",
        color=red,
        explicit(x^2,x,1,100),
        yaxis_secondary = true,
        ytics_secondary = true,
        logy_secondary  = true,
        key = "x^2, logarithmic y scale",
        color = blue,
        explicit(x^2,x,1,100) )$
@end example

See also @mrefcomma{logx_draw}  @mrefcomma{logy_draw}  @mrefcomma{logx_secondary}  and @mrefdot{logz}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{logz}
@defvr {Graphic option} logz
Default value: @code{false}

If @code{logz} is @code{true}, the @var{z} axis will be drawn in the
logarithmic scale.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(logz = true,
             explicit(exp(u^2+v^2),u,-2,2,v,-2,2))$
@end example

See also @mref{logx_draw} and @mrefdot{logy_draw}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@defvr {Graphic option} nticks
Default value: 29

In 2d, @code{nticks} gives the initial number of points used by the
adaptive plotting routine for explicit objects. It is also the
number of points that will be shown in parametric and polar curves.

This option affects the following graphic objects:
@itemize @bullet
@item
@code{gr2d}: @mrefcomma{ellipse} @mrefcomma{explicit} @mref{parametric} and @mrefdot{polar}

@item
@code{gr3d}: @mrefdot{parametric}
@end itemize

See also @code{adapt_depth}

Example:

@example
(%i1) draw2d(transparent = true,
             ellipse(0,0,4,2,0,180),
             nticks = 5,
             ellipse(0,0,4,2,180,180) )$
@end example
@figure{draw_nticks}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{palette_draw}
@defvr {Graphic option} palette
Default value: @code{color}

@code{palette} indicates how to map gray levels onto color components.
It works together with option @code{enhanced3d} in 3D graphics,
who associates every point of a surfaces to a real number or gray level.
It also works with gray images. With @code{palette}, levels are transformed into colors.

There are two ways for defining these transformations.

First, @code{palette} can be a vector of length three with components 
ranging from -36 to +36; each value is an index for a formula mapping the levels
onto red, green and blue colors, respectively:
@example
 0: 0               1: 0.5           2: 1
 3: x               4: x^2           5: x^3
 6: x^4             7: sqrt(x)       8: sqrt(sqrt(x))
 9: sin(90x)       10: cos(90x)     11: |x-0.5|
12: (2x-1)^2       13: sin(180x)    14: |cos(180x)|
15: sin(360x)      16: cos(360x)    17: |sin(360x)|
18: |cos(360x)|    19: |sin(720x)|  20: |cos(720x)|
21: 3x             22: 3x-1         23: 3x-2
24: |3x-1|         25: |3x-2|       26: (3x-1)/2 
27: (3x-2)/2       28: |(3x-1)/2|   29: |(3x-2)/2|
30: x/0.32-0.78125 31: 2*x-0.84     32: 4x;1;-2x+1.84;x/0.08-11.5
33: |2*x - 0.5|    34: 2*x          35: 2*x - 0.5
36: 2*x - 1
@end example
negative numbers mean negative colour component.
@code{palette = gray} and @code{palette = color} are short cuts for
@code{palette = [3,3,3]} and @code{palette = [7,5,15]}, respectively.

Second, @code{palette} can be a user defined lookup table. In this case,
the format for building a lookup table of length @code{n} is
@code{palette=[color_1, color_2, ..., color_n]}, where @code{color_i} is
a well formed color (see option @code{color}) such that @code{color_1} is
assigned to the lowest gray level and @code{color_n} to the highest. The rest
of colors are interpolated.

Since this is a global graphics option, its position in the scene description
does not matter.

Examples:

It works together with option @code{enhanced3d} in 3D graphics.

@example
(%i1) draw3d(
        enhanced3d = [z-x+2*y,x,y,z],
        palette = [32, -8, 17],
        explicit(20*exp(-x^2-y^2)-10,x,-3,3,y,-3,3))$
@end example
@figure{draw_palette}

It also works with gray images.

@example
(%i1) im: apply(
           'matrix,
            makelist(makelist(random(200),i,1,30),i,1,30))$
(%i2) /* palette = color, default */
      draw2d(image(im,0,0,30,30))$
(%i3) draw2d(palette = gray, image(im,0,0,30,30))$
(%i4) draw2d(palette = [15,20,-4],
             colorbox=false,
             image(im,0,0,30,30))$
@end example
@figure{draw_palette2}

@code{palette} can be a user defined lookup table.
In this example, low values of @code{x} are colored
in red, and higher values in yellow.

@example
(%i1) draw3d(
         palette = [red, blue, yellow],
         enhanced3d = x,
         explicit(x^2+y^2,x,-1,1,y,-1,1)) $
@end example
@figure{draw_palette3}

See also @mref{colorbox} and @mrefdot{enhanced3d}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{point_size}
@defvr {Graphic option} point_size
Default value: 1

@code{point_size} sets the size for plotted points. It must be a
non negative number.

This option has no effect when graphic option @code{point_type} is
set to @code{dot}.

This option affects the following graphic objects:
@itemize @bullet
@item
@code{gr2d}: @mrefdot{points}

@item
@code{gr3d}: @mrefdot{points}
@end itemize

Example:

@example
(%i1) draw2d(points(makelist([random(20),random(50)],k,1,10)),
        point_size = 5,
        points(makelist(k,k,1,20),makelist(random(30),k,1,20)))$
@end example
@figure{draw_point_size}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{point_type_draw}
@defvr {Graphic option} point_type
Default value: 1

@code{point_type} indicates how isolated points are displayed; the value of this
option can be any integer index greater or equal than -1, or the name of
a point style: @code{$none} (-1), @code{dot} (0), @code{plus} (1), @code{multiply} (2),
@code{asterisk} (3), @code{square} (4), @code{filled_square} (5), @code{circle} (6),
@code{filled_circle} (7), @code{up_triangle} (8), @code{filled_up_triangle} (9),
@code{down_triangle} (10), @code{filled_down_triangle} (11), @code{diamant} (12) and
@code{filled_diamant} (13).

This option affects the following graphic objects:
@itemize @bullet
@item
@code{gr2d}: @mrefdot{points}

@item
@code{gr3d}: @mrefdot{points}
@end itemize

Example:

@example
(%i1) draw2d(xrange = [0,10],
             yrange = [0,10],
             point_size = 3,
             point_type = diamant,
             points([[1,1],[5,1],[9,1]]),
             point_type = filled_down_triangle,
             points([[1,2],[5,2],[9,2]]),
             point_type = asterisk,
             points([[1,3],[5,3],[9,3]]),
             point_type = filled_diamant,
             points([[1,4],[5,4],[9,4]]),
             point_type = 5,
             points([[1,5],[5,5],[9,5]]),
             point_type = 6,
             points([[1,6],[5,6],[9,6]]),
             point_type = filled_circle,
             points([[1,7],[5,7],[9,7]]),
             point_type = 8,
             points([[1,8],[5,8],[9,8]]),
             point_type = filled_diamant,
             points([[1,9],[5,9],[9,9]]) )$
@end example
@figure{draw_point_type}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{points_joined}
@defvr {Graphic option} points_joined
Default value: @code{false}

When @code{points_joined} is @code{true}, points are joined by lines; when @code{false},
isolated points are drawn. A third possible value for this graphic option is 
@code{impulses}; in such case, vertical segments are drawn from points to the x-axis (2D)
or to the xy-plane (3D).

This option affects the following graphic objects:
@itemize @bullet
@item
@code{gr2d}: @mrefdot{points}

@item
@code{gr3d}: @mrefdot{points}
@end itemize

Example:

@example
(%i1) draw2d(xrange        = [0,10],
             yrange        = [0,4],
             point_size    = 3,
             point_type    = up_triangle,
             color         = blue,
             points([[1,1],[5,1],[9,1]]),
             points_joined = true,
             point_type    = square,
             line_type     = dots,
             points([[1,2],[5,2],[9,2]]),
             point_type    = circle,
             color         = red,
             line_width    = 7,
             points([[1,3],[5,3],[9,3]]) )$
@end example
@figure{draw_points_joined}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{proportional_axes}
@defvr {Graphic option} proportional_axes
Default value: @code{none}

When @code{proportional_axes} is equal to @code{xy} or @code{xyz},
the aspect ratio of the axis units will be set to 1:1 resulting in a 2D or 3D
scene that will be drawn with axes proportional to their relative lengths.

Since this is a global graphics option, its position in the scene description
does not matter.

This option works with Gnuplot version 4.2.6 or greater.

Examples:

Single 2D plot.

@example
(%i1) draw2d(
        ellipse(0,0,1,1,0,360),
        transparent=true,
        color = blue,
        line_width = 4,
        ellipse(0,0,2,1/2,0,360),
        proportional_axes = 'xy) $
@end example
@figure{draw_proportional_axis}

Multiplot.

@example
(%i1) draw(
        terminal = wxt,
        gr2d(proportional_axes = 'xy,
             explicit(x^2,x,0,1)),
        gr2d(explicit(x^2,x,0,1),
             xrange = [0,1],
             yrange = [0,2],
             proportional_axes='xy),
        gr2d(explicit(x^2,x,0,1)))$
@end example
@figure{draw_proportional_axis2}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{surface_hide}
@defvr {Graphic option} surface_hide
Default value: @code{false}

If @code{surface_hide} is @code{true}, hidden parts are not plotted in 3d surfaces.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw(columns=2,
           gr3d(explicit(exp(sin(x)+cos(x^2)),x,-3,3,y,-3,3)),
           gr3d(surface_hide = true,
                explicit(exp(sin(x)+cos(x^2)),x,-3,3,y,-3,3)) )$
@end example
@figure{draw_surface_hide}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{terminal}
@defvr {Graphic option} terminal
Default value: @code{screen}

Selects the terminal to be used by Gnuplot; possible values are:
@code{screen} (default), @code{png}, @code{pngcairo}, @code{jpg}, @code{gif}, 
@code{eps}, @code{eps_color}, @code{epslatex}, @code{epslatex_standalone}, 
@code{svg}, @code{canvas}, @code{dumb}, @code{dumb_file}, @code{pdf}, @code{pdfcairo}, 
@code{wxt}, @code{animated_gif}, @code{multipage_pdfcairo}, @code{multipage_pdf}, 
@code{multipage_eps}, @code{multipage_eps_color}, and @code{aquaterm}.

Terminals @code{screen}, @code{wxt}, @code{windows} and @code{aquaterm} can
be also defined as a list
with two elements: the name of the terminal itself and a non negative integer number.
In this form, multiple windows can be opened at the same time, each with its
corresponding number. This feature does not work in Windows platforms.

Since this is a global graphics option, its position in the scene description
does not matter. It can be also used as an argument of function @code{draw}.

N.B. pdfcairo requires Gnuplot 4.3 or newer. 
@code{pdf} requires Gnuplot to be compiled with the option @code{--enable-pdf} and libpdf must
be installed. The pdf library is available from: @url{http://www.pdflib.com/en/download/pdflib-family/pdflib-lite/}

Examples:

@example
(%i1) /* screen terminal (default) */
      draw2d(explicit(x^2,x,-1,1))$
(%i2) /* png file */
      draw2d(terminal  = 'png,
             explicit(x^2,x,-1,1))$
(%i3) /* jpg file */
      draw2d(terminal   = 'jpg,
             dimensions = [300,300],
             explicit(x^2,x,-1,1))$
(%i4) /* eps file */
      draw2d(file_name = "myfile",
             explicit(x^2,x,-1,1),
             terminal  = 'eps)$
(%i5) /* pdf file */
      draw2d(file_name = "mypdf",
             dimensions = 100*[12.0,8.0],
             explicit(x^2,x,-1,1),
             terminal  = 'pdf)$
(%i6) /* wxwidgets window */
      draw2d(explicit(x^2,x,-1,1),
             terminal  = 'wxt)$
@end example

Multiple windows.
@example
(%i1) draw2d(explicit(x^5,x,-2,2), terminal=[screen, 3])$
(%i2) draw2d(explicit(x^2,x,-2,2), terminal=[screen, 0])$
@end example

An animated gif file.
@example
(%i1) draw(
        delay     = 100,
        file_name = "zzz",
        terminal  = 'animated_gif,
        gr2d(explicit(x^2,x,-1,1)),
        gr2d(explicit(x^3,x,-1,1)),
        gr2d(explicit(x^4,x,-1,1)));
End of animation sequence
(%o1)          [gr2d(explicit), gr2d(explicit), gr2d(explicit)]
@end example

Option @code{delay} is only active in animated gif's; it is ignored in
any other case.

Multipage output in eps format.
@example
(%i1) draw(
        file_name = "parabol",
        terminal  = multipage_eps,
        dimensions = 100*[10,10],
        gr2d(explicit(x^2,x,-1,1)),
        gr3d(explicit(x^2+y^2,x,-1,1,y,-1,1))) $
@end example

See also @mrefcomma{file_name}  @mref{dimensions_draw} and @mrefdot{delay}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{title_draw}
@defvr {Graphic option} title
Default value: @code{""} (empty string)

Option @code{title}, a string, is the main title for the scene.
By default, no title is written.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(explicit(exp(u),u,-2,2),
             title = "Exponential function")$
@end example
@figure{draw_title}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{transform}
@defvr {Graphic option} transform
Default value: @code{none}

If @code{transform} is @code{none}, the space is not transformed and
graphic objects are drawn as defined. When a space transformation is
desired, a list must be assigned to option @code{transform}. In case of
a 2D scene, the list takes the form @code{[f1(x,y), f2(x,y), x, y]}.
In case of a 3D scene, the list is of the form
@code{[f1(x,y,z), f2(x,y,z), f3(x,y,z), x, y, z]}.

The names of the variables defined in the lists may be different to those
used in the definitions of the graphic objects.

Examples:

Rotation in 2D.

@example
(%i1) th : %pi / 4$
(%i2) draw2d(
        color = "#e245f0",
        proportional_axes = 'xy,
        line_width = 8,
        triangle([3,2],[7,2],[5,5]),
        border     = false,
        fill_color = yellow,
        transform  = [cos(th)*x - sin(th)*y,
                      sin(th)*x + cos(th)*y, x, y],
        triangle([3,2],[7,2],[5,5]) )$
@end example
@figure{draw_transform}

Translation in 3D.

@example
(%i1) draw3d(
        color     = "#a02c00",
        explicit(20*exp(-x^2-y^2)-10,x,-3,3,y,-3,3),
        transform = [x+10,y+10,z+10,x,y,z],
        color     = blue,
        explicit(20*exp(-x^2-y^2)-10,x,-3,3,y,-3,3) )$
@end example

@opencatbox
@category{Package draw}
@closecatbox
@end defvr



@anchor{transparent}
@defvr {Graphic option} transparent
Default value: @code{false}

If @code{transparent} is @code{false}, interior regions of polygons are 
filled according to @code{fill_color}.

This option affects the following graphic objects:
@itemize @bullet
@item
@code{gr2d}: @mrefcomma{polygon} @mref{rectangle} and @mrefdot{ellipse}
@end itemize

Example:

@example
(%i1) draw2d(polygon([[3,2],[7,2],[5,5]]),
             transparent = true,
             color       = blue,
             polygon([[5,2],[9,2],[7,5]]) )$
@end example
@figure{draw_transparent}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{unit_vectors}
@defvr {Graphic option} unit_vectors
Default value: @code{false}

If @code{unit_vectors} is @code{true}, vectors are plotted with module 1.
This is useful for plotting vector fields. If @code{unit_vectors} is @code{false},
vectors are plotted with its original length.

This option is relevant only for @code{vector} objects.

Example:

@example
(%i1) draw2d(xrange      = [-1,6],
             yrange      = [-1,6],
             head_length = 0.1,
             vector([0,0],[5,2]),
             unit_vectors = true,
             color        = red,
             vector([0,3],[5,2]))$
@end example
@figure{draw_unit_vectors}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{user_preamble}
@defvr {Graphic option} user_preamble
Default value: @code{""} (empty string)

Expert Gnuplot users can make use of this option to fine tune Gnuplot's
behaviour by writing settings to be sent before the @code{plot} or @code{splot}
command.

The value of this option must be a string or a list of strings (one per line).

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

Tell Gnuplot to draw axes and grid on top of graphics objects,
@example
(%i1) draw2d(
        xaxis =true, xaxis_type=solid,
        yaxis =true, yaxis_type=solid,
        user_preamble="set grid front",
        region(x^2+y^2<1 ,x,-1.5,1.5,y,-1.5,1.5))$
@end example
@figure{draw_user_preamble}

Tell gnuplot to draw all contour lines in black

@example
(%i1) draw3d(
          contour=both,
          surface_hide=true,enhanced3d=true,wired_surface=true,
          contour_levels=10,
          user_preamble="set for [i=1:8] linetype i dashtype i linecolor 0",
          explicit(sin(x)*cos(y),x,1,10,y,1,10)
      );
@end example
@figure{draw_user_preamble2}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{view}
@defvr {Graphic option} view
Default value: @code{[60,30]}

A pair of angles, measured in degrees, indicating the view direction in a 
3D scene. The first angle is the vertical rotation around the @var{x} axis, in 
the range @math{[0, 360]}. The second one is the horizontal rotation around
the @var{z} axis, in the range @math{[0, 360]}.

If option @code{view} is given the value @code{map}, the view direction is set
to be perpendicular to the xy-plane.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(view = [170, 50],
             enhanced3d = true,
             explicit(sin(x^2+y^2),x,-2,2,y,-2,2) )$
@end example
@figure{draw_view}
@example
(%i2) draw3d(view = map,
             enhanced3d = true,
             explicit(sin(x^2+y^2),x,-2,2,y,-2,2) )$
@end example
@figure{draw_view2}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{wired_surface}
@defvr {Graphic option} wired_surface
Default value: @code{false}

Indicates whether 3D surfaces in @code{enhanced3d} mode show the grid joinning
the points or not.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(
        enhanced3d    = [sin(x),x,y],
        wired_surface = true,
        explicit(x^2+y^2,x,-1,1,y,-1,1)) $
@end example
@figure{draw_wired_surface}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{x_voxel}
@defvr {Graphic option} x_voxel
Default value: 10

@code{x_voxel} is the number of voxels in the x direction to
be used by the @i{marching cubes algorithm} implemented
by the 3d @code{implicit} object. It is also used by graphic
object @mrefdot{region}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{xaxis}
@defvr {Graphic option} xaxis
Default value: @code{false}

If @code{xaxis} is @code{true}, the @var{x} axis is drawn.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(explicit(x^3,x,-1,1),
             xaxis       = true,
             xaxis_color = blue)$
@end example
@figure{draw_xaxis}

See also @mrefcomma{xaxis_width}  @mref{xaxis_type} and @mrefdot{xaxis_color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{xaxis_color}
@defvr {Graphic option} xaxis_color
Default value: @code{"black"}

@code{xaxis_color} specifies the color for the @var{x} axis. See
@code{color} to know how colors are defined.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(explicit(x^3,x,-1,1),
             xaxis       = true,
             xaxis_color = red)$
@end example

See also @mrefcomma{xaxis}  @mref{xaxis_width} and @mrefdot{xaxis_type}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xaxis_secondary}
@defvr {Graphic option} xaxis_secondary
Default value: @code{false}

If @code{xaxis_secondary} is @code{true}, function values can be plotted with 
respect to the second @var{x} axis, which will be drawn on top of the scene.

Note that this is a local graphics option which only affects to 2d plots.

Example:

@example
(%i1) draw2d(
         key   = "Bottom x-axis",
         explicit(x+1,x,1,2),
         color = red,
         key   = "Above x-axis",
         xtics_secondary = true,
         xaxis_secondary = true,
         explicit(x^2,x,-1,1)) $
@end example
@figure{draw_xaxis_secondary}

See also @mrefcomma{xrange_secondary}  @mrefcomma{xtics_secondary}  @mrefcomma{xtics_rotate_secondary} 
@code{xtics_axis_secondary} and @mrefdot{xaxis_secondary}
@c TODO: Document xtics_axis_secondary
@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{xaxis_type}
@defvr {Graphic option} xaxis_type
Default value: @code{dots}

@code{xaxis_type} indicates how the @var{x} axis is displayed; 
possible values are @code{solid} and @code{dots}

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(explicit(x^3,x,-1,1),
             xaxis       = true,
             xaxis_type  = solid)$
@end example

See also @mrefcomma{xaxis}  @mref{xaxis_width} and @mrefdot{xaxis_color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xaxis_width}
@defvr {Graphic option} xaxis_width
Default value: 1

@code{xaxis_width} is the width of the @var{x} axis.
Its value must be a positive number.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(explicit(x^3,x,-1,1),
             xaxis       = true,
             xaxis_width = 3)$
@end example

See also @mrefcomma{xaxis}  @mref{xaxis_type} and @mrefdot{xaxis_color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xlabel_draw}
@defvr {Graphic option} xlabel
Default value: @code{""}

Option @code{xlabel}, a string, is the label for the @var{x} axis.
By default, the axis is labeled with string @code{"x"}.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(xlabel = "Time",
             explicit(exp(u),u,-2,2),
             ylabel = "Population")$
@end example

See also @mrefcomma{xlabel_secondary}  @mrefcomma{ylabel}  @mref{ylabel_secondary} and @mrefdot{zlabel_draw}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xlabel_secondary}
@defvr {Graphic option} xlabel_secondary
Default value: @code{""} (empty string)

Option @code{xlabel_secondary}, a string, is the label for the secondary @var{x} axis.
By default, no label is written.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(
         xaxis_secondary=true,yaxis_secondary=true,
         xtics_secondary=true,ytics_secondary=true,
         xlabel_secondary="t[s]",
         ylabel_secondary="U[V]",
         explicit(sin(t),t,0,10) )$
@end example
@figure{draw_ylabel_secondary}

See also @mrefcomma{xlabel_draw}  @mrefcomma{ylabel_draw}  @mref{ylabel_secondary} and @mrefdot{zlabel_draw}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xrange}
@defvr {Graphic option} xrange
Default value: @code{auto}

If @code{xrange} is @code{auto}, the range for the @var{x} coordinate is
computed automatically.

If the user wants a specific interval for @var{x}, it must be given as a 
Maxima list, as in @code{xrange=[-2, 3]}.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(xrange = [-3,5],
             explicit(x^2,x,-1,1))$
@end example

See also @mref{yrange} and @mrefdot{zrange}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xrange_secondary}
@defvr {Graphic option} xrange_secondary
Default value: @code{auto}

If @code{xrange_secondary} is @code{auto}, the range for the second @var{x} axis is
computed automatically.

If the user wants a specific interval for the second @var{x} axis, it must be given as a 
Maxima list, as in @code{xrange_secondary=[-2, 3]}.

Since this is a global graphics option, its position in the scene description
does not matter.

See also @mrefcomma{xrange}  @mrefcomma{yrange}  @mref{zrange} and @mrefdot{yrange_secondary}

@opencatbox
@category{Package draw}
@closecatbox
@end defvr




@anchor{xtics_draw}
@defvr {Graphic option} xtics
Default value: @code{true}

This graphic option controls the way tic marks are drawn on the @var{x} axis.

@itemize @bullet
@item
When option @code{xtics} is bounded to symbol @var{true}, tic marks are
drawn automatically.

@item
When option @code{xtics} is bounded to symbol @var{false}, tic marks are
not drawn.

@item
When option @code{xtics} is bounded to a positive number, this is the distance
between two consecutive tic marks.

@item
When option @code{xtics} is bounded to a list of length three of the
form @code{[start,incr,end]}, tic marks are plotted from @code{start} 
to @code{end} at intervals of length @code{incr}.

@item
When option @code{xtics} is bounded to a set of numbers of the
form @code{@{n1, n2, ...@}}, tic marks are plotted at values @code{n1},
@code{n2}, ...

@item
When option @code{xtics} is bounded to a set of pairs of the
form @code{@{["label1", n1], ["label2", n2], ...@}}, tic marks corresponding to values @code{n1},
@code{n2}, ... are labeled with @code{"label1"}, @code{"label2"}, ..., respectively.
@end itemize

Since this is a global graphics option, its position in the scene description
does not matter.

Examples:

Disable tics.
@example
(%i1) draw2d(xtics = 'false,
             explicit(x^3,x,-1,1)  )$
@end example

Tics every 1/4 units.
@example
(%i1) draw2d(xtics = 1/4,
             explicit(x^3,x,-1,1)  )$
@end example

Tics from -3/4 to 3/4 in steps of 1/8.
@example
(%i1) draw2d(xtics = [-3/4,1/8,3/4],
             explicit(x^3,x,-1,1)  )$
@end example

Tics at points -1/2, -1/4 and 3/4.
@example
(%i1) draw2d(xtics = @{-1/2,-1/4,3/4@},
             explicit(x^3,x,-1,1)  )$
@end example

Labeled tics.
@example
(%i1) draw2d(xtics = @{["High",0.75],["Medium",0],["Low",-0.75]@},
             explicit(x^3,x,-1,1)  )$
@end example

See also @mrefcomma{ytics}  and @mrefdot{ztics}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xtics_axis}
@defvr {Graphic option} xtics_axis
Default value: @code{false}

If @code{xtics_axis} is @code{true}, tic marks and their labels are plotted just
along the @var{x} axis, if it is @code{false} tics are plotted on the border.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xtics_rotate}
@defvr {Graphic option} xtics_rotate
Default value: @code{false}

If @code{xtics_rotate} is @code{true}, tic marks on the @var{x} axis are rotated 
90 degrees.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr


@anchor{xtics_rotate_secondary}
@defvr {Graphic option} xtics_rotate_secondary
Default value: @code{false}

If @code{xtics_rotate_secondary} is @code{true}, tic marks on the secondary @var{x} axis are rotated 
90 degrees.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xtics_secondary}
@defvr {Graphic option} xtics_secondary
Default value: @code{auto}

This graphic option controls the way tic marks are drawn on the second @var{x} axis.

See @code{xtics} for a complete description.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xtics_secondary_axis}
@defvr {Graphic option} xtics_secondary_axis
Default value: @code{false}

If @code{xtics_secondary_axis} is @code{true}, tic marks and their labels are plotted just
along the secondary @var{x} axis, if it is @code{false} tics are plotted on the border.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{xu_grid}
@defvr {Graphic option} xu_grid
Default value: 30

@code{xu_grid} is the number of coordinates of the first variable
(@code{x} in explicit and @code{u} in parametric 3d surfaces) to 
build the grid of sample points.

This option affects the following graphic objects:
@itemize @bullet
@item
@code{gr3d}: @code{explicit} and @code{parametric_surface}.
@end itemize

Example:

@example
(%i1) draw3d(xu_grid = 10,
             yv_grid = 50,
             explicit(x^2+y^2,x,-3,3,y,-3,3) )$
@end example

See also @mrefdot{yv_grid}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{xy_file}
@defvr {Graphic option} xy_file
Default value: @code{""} (empty string)

@code{xy_file} is the name of the file where the coordinates will be saved
after clicking with the mouse button and hitting the 'x' key. By default,
no coordinates are saved.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{xyplane}
@defvr {Graphic option} xyplane
Default value: @code{false}

Allocates the xy-plane in 3D scenes. When @code{xyplane} is
@code{false}, the xy-plane is placed automatically; when it is
a real number, the xy-plane intersects the z-axis at this level.
This option has no effect in 2D scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(xyplane = %e-2,
             explicit(x^2+y^2,x,-1,1,y,-1,1))$
@end example

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{y_voxel}
@defvr {Graphic option} y_voxel
Default value: 10

@code{y_voxel} is the number of voxels in the y direction to
be used by the @i{marching cubes algorithm} implemented
by the 3d @code{implicit} object. It is also used by graphic
object @mrefdot{region}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{yaxis}
@defvr {Graphic option} yaxis
Default value: @code{false}

If @code{yaxis} is @code{true}, the @var{y} axis is drawn.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(explicit(x^3,x,-1,1),
             yaxis       = true,
             yaxis_color = blue)$
@end example

See also @mrefcomma{yaxis_width}  @mref{yaxis_type} and @mrefdot{yaxis_color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{yaxis_color}
@defvr {Graphic option} yaxis_color
Default value: @code{"black"}

@code{yaxis_color} specifies the color for the @var{y} axis. See
@code{color} to know how colors are defined.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(explicit(x^3,x,-1,1),
             yaxis       = true,
             yaxis_color = red)$
@end example

See also @mrefcomma{yaxis}  @mref{yaxis_width} and @mrefdot{yaxis_type}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{yaxis_secondary}
@defvr {Graphic option} yaxis_secondary
Default value: @code{false}

If @code{yaxis_secondary} is @code{true}, function values can be plotted with 
respect to the second @var{y} axis, which will be drawn on the right side of the
scene.

Note that this is a local graphics option which only affects to 2d plots.

Example:

@example
(%i1) draw2d(
         explicit(sin(x),x,0,10),
         yaxis_secondary = true,
         ytics_secondary = true,
         color = blue,
         explicit(100*sin(x+0.1)+2,x,0,10));
@end example

See also @mrefcomma{yrange_secondary}  @mrefcomma{ytics_secondary}  @mref{ytics_rotate_secondary}
and @code{ytics_axis_secondary}
@c TODO: Document ytics_axis_secondary

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{yaxis_type}
@defvr {Graphic option} yaxis_type
Default value: @code{dots}

@code{yaxis_type} indicates how the @var{y} axis is displayed; 
possible values are @code{solid} and @code{dots}.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(explicit(x^3,x,-1,1),
             yaxis       = true,
             yaxis_type  = solid)$
@end example

See also @mrefcomma{yaxis}  @mref{yaxis_width} and @mrefdot{yaxis_color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{yaxis_width}
@defvr {Graphic option} yaxis_width
Default value: 1

@code{yaxis_width} is the width of the @var{y} axis.
Its value must be a positive number.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(explicit(x^3,x,-1,1),
             yaxis       = true,
             yaxis_width = 3)$
@end example

See also @mrefcomma{yaxis}  @mref{yaxis_type} and @mrefdot{yaxis_color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{ylabel_draw}
@defvr {Graphic option} ylabel
Default value: @code{""}

Option @code{ylabel}, a string, is the label for the @var{y} axis.
By default, the axis is labeled with string @code{"y"}.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(xlabel = "Time",
             ylabel = "Population",
             explicit(exp(u),u,-2,2) )$
@end example

See also @mrefcomma{xlabel_draw}  @mrefcomma{xlabel_secondary}  @mrefcomma{ylabel_secondary}  and @mrefdot{zlabel_draw}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{ylabel_secondary}
@defvr {Graphic option} ylabel_secondary
Default value: @code{""} (empty string)

Option @code{ylabel_secondary}, a string, is the label for the secondary @var{y} axis.
By default, no label is written.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(
        key_pos=bottom_right,
        key="current",
        xlabel="t[s]",
        ylabel="I[A]",ylabel_secondary="P[W]",
        explicit(sin(t),t,0,10),
        yaxis_secondary=true,
        ytics_secondary=true,
        color=red,key="Power",
        explicit((sin(t))^2,t,0,10)
    )$
@end example

See also @mrefcomma{xlabel_draw}  @mrefcomma{xlabel_secondary}  @mref{ylabel_draw} and @mrefdot{zlabel_draw}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{yrange}
@defvr {Graphic option} yrange
Default value: @code{auto}

If @code{yrange} is @code{auto}, the range for the @var{y} coordinate is
computed automatically.

If the user wants a specific interval for @var{y}, it must be given as a 
Maxima list, as in @code{yrange=[-2, 3]}.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(yrange = [-2,3],
             explicit(x^2,x,-1,1),
             xrange = [-3,3])$
@end example

See also @mrefcomma{xrange}  @mref{yrange_secondary} and @mrefdot{zrange}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{yrange_secondary}
@defvr {Graphic option} yrange_secondary
Default value: @code{auto}

If @code{yrange_secondary} is @code{auto}, the range for the second @var{y} axis is
computed automatically.

If the user wants a specific interval for the second @var{y} axis, it must be given as a 
Maxima list, as in @code{yrange_secondary=[-2, 3]}.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw2d(
         explicit(sin(x),x,0,10),
         yaxis_secondary = true,
         ytics_secondary = true,
         yrange = [-3, 3],
         yrange_secondary = [-20, 20],
         color = blue,
         explicit(100*sin(x+0.1)+2,x,0,10)) $
@end example

See also @mrefcomma{xrange}  @mref{yrange} and @mrefdot{zrange}

@opencatbox
@category{Package draw}
@closecatbox
@end defvr



@anchor{ytics_draw}
@defvr {Graphic option} ytics
Default value: @code{true}

This graphic option controls the way tic marks are drawn on the @var{y} axis.

See @code{xtics} for a complete description.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{ytics_axis}
@defvr {Graphic option} ytics_axis
Default value: @code{false}

If @code{ytics_axis} is @code{true}, tic marks and their labels are plotted just
along the @var{y} axis, if it is @code{false} tics are plotted on the border.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{ytics_rotate}
@defvr {Graphic option} ytics_rotate
Default value: @code{false}

If @code{ytics_rotate} is @code{true}, tic marks on the @var{y} axis are rotated 
90 degrees.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{ytics_rotate_secondary}
@defvr {Graphic option} ytics_rotate_secondary
Default value: @code{false}

If @code{ytics_rotate_secondary} is @code{true}, tic marks on the secondary @var{y} axis are rotated 
90 degrees.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{ytics_secondary}
@defvr {Graphic option} ytics_secondary
Default value: @code{auto}

This graphic option controls the way tic marks are drawn on the second @var{y} axis.

See @code{xtics} for a complete description.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{ytics_secondary_axis}
@defvr {Graphic option} ytics_secondary_axis
Default value: @code{false}

If @code{ytics_secondary_axis} is @code{true}, tic marks and their labels are plotted just
along the secondary @var{y} axis, if it is @code{false} tics are plotted on the border.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{yv_grid}
@defvr {Graphic option} yv_grid
Default value: 30

@code{yv_grid} is the number of coordinates of the second variable
(@code{y} in explicit and @code{v} in parametric 3d surfaces) to 
build the grid of sample points.

This option affects the following graphic objects:
@itemize @bullet
@item
@code{gr3d}: @mref{explicit} and @mref{parametric_surface}.
@end itemize

Example:

@example
(%i1) draw3d(xu_grid = 10,
             yv_grid = 50,
             explicit(x^2+y^2,x,-3,3,y,-3,3) )$
@end example
@figure{draw_xugrid}

See also @mrefdot{xu_grid}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr


@anchor{z_voxel}
@defvr {Graphic option} z_voxel
Default value: 10

@code{z_voxel} is the number of voxels in the z direction to
be used by the @i{marching cubes algorithm} implemented
by the 3d @code{implicit} object.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr


@anchor{zaxis}
@defvr {Graphic option} zaxis
Default value: @code{false}

If @code{zaxis} is @code{true}, the @var{z} axis is drawn in 3D plots.
This option has no effect in 2D scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(explicit(x^2+y^2,x,-1,1,y,-1,1),
             zaxis       = true,
             zaxis_type  = solid,
             zaxis_color = blue)$
@end example

See also @mrefcomma{zaxis_width}  @mref{zaxis_type} and @mrefdot{zaxis_color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{zaxis_color}
@defvr {Graphic option} zaxis_color
Default value: @code{"black"}

@code{zaxis_color} specifies the color for the @var{z} axis. See
@code{color} to know how colors are defined. 
This option has no effect in 2D scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(explicit(x^2+y^2,x,-1,1,y,-1,1),
             zaxis       = true,
             zaxis_type  = solid,
             zaxis_color = red)$
@end example

See also @mrefcomma{zaxis}  @mref{zaxis_width} and @mrefdot{zaxis_type}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{zaxis_type}
@defvr {Graphic option} zaxis_type
Default value: @code{dots}

@code{zaxis_type} indicates how the @var{z} axis is displayed; 
possible values are @code{solid} and @code{dots}.
This option has no effect in 2D scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(explicit(x^2+y^2,x,-1,1,y,-1,1),
             zaxis       = true,
             zaxis_type  = solid)$
@end example

See also @mrefcomma{zaxis}  @mref{zaxis_width} and @mrefdot{zaxis_color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{zaxis_width}
@defvr {Graphic option} zaxis_width
Default value: 1

@code{zaxis_width} is the width of the @var{z} axis.
Its value must be a positive number. This option has no effect in 2D scenes.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(explicit(x^2+y^2,x,-1,1,y,-1,1),
             zaxis       = true,
             zaxis_type  = solid,
             zaxis_width = 3)$
@end example

See also @mrefcomma{zaxis}  @mref{zaxis_type} and @mrefdot{zaxis_color}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr



@anchor{zlabel_draw}
@defvr {Graphic option} zlabel
Default value: @code{""}

Option @code{zlabel}, a string, is the label for the @var{z} axis.
By default, the axis is labeled with string @code{"z"}.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(zlabel = "Z variable",
             ylabel = "Y variable",
             explicit(sin(x^2+y^2),x,-2,2,y,-2,2),
             xlabel = "X variable" )$
@end example

See also @mrefcomma{xlabel_draw}  @mrefcomma{ylabel_draw}  and @mrefdot{zlabel_rotate}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{zlabel_rotate}
@defvr {Graphic option} zlabel_rotate
Default value: @code{"auto"}

This graphics option allows to choose if the z axis label of 3d plots is
drawn horizontal (@code{false}), vertical (@code{true}) or if maxima
automatically chooses an orientation based on the length of the label
(@code{auto}).

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(
          explicit(sin(x)*sin(y),x,0,10,y,0,10),
          zlabel_rotate=false
      )$
@end example

See also @mrefdot{zlabel_draw}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{zrange}
@defvr {Graphic option} zrange
Default value: @code{auto}

If @code{zrange} is @code{auto}, the range for the @var{z} coordinate is
computed automatically.

If the user wants a specific interval for @var{z}, it must be given as a 
Maxima list, as in @code{zrange=[-2, 3]}.

Since this is a global graphics option, its position in the scene description
does not matter.

Example:

@example
(%i1) draw3d(yrange = [-3,3],
             zrange = [-2,5],
             explicit(x^2+y^2,x,-1,1,y,-1,1),
             xrange = [-3,3])$
@end example

See also @mref{xrange} and @mrefdot{yrange}

@opencatbox
@category{Package draw}
@closecatbox
@end defvr


@anchor{ztics}
@defvr {Graphic option} ztics
Default value: @code{true}

This graphic option controls the way tic marks are drawn on the @var{z} axis.

See @code{xtics} for a complete description.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@anchor{ztics_axis}
@defvr {Graphic option} ztics_axis
Default value: @code{false}

If @code{ztics_axis} is @code{true}, tic marks and their labels are plotted just
along the @var{z} axis, if it is @code{false} tics are plotted on the border.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr


@anchor{ztics_rotate}
@defvr {Graphic option} ztics_rotate
Default value: @code{false}

If @code{ztics_rotate} is @code{true}, tic marks on the @var{z} axis are rotated 
90 degrees.

Since this is a global graphics option, its position in the scene description
does not matter.

@opencatbox
@category{Package draw}
@closecatbox

@end defvr




@subsection Graphics objects



@anchor{bars}
@deffn  {Graphic object} bars ([@var{x1},@var{h1},@var{w1}], [@var{x2},@var{h2},@var{w2}, ...])
Draws vertical bars in 2D.

@b{2D}

@code{bars ([@var{x1},@var{h1},@var{w1}], [@var{x2},@var{h2},@var{w2}, ...])} 
draws bars centered at values @var{x1}, @var{x2}, ... with heights @var{h1}, @var{h2}, ...
and widths @var{w1}, @var{w2}, ...

This object is affected by the following @i{graphic options}: @mrefcomma{key} 
@mrefcomma{fill_color} @mref{fill_density} and @mrefdot{line_width}

Example:

@example
(%i1) draw2d(
       key          = "Group A",
       fill_color   = blue,
       fill_density = 0.2,
       bars([0.8,5,0.4],[1.8,7,0.4],[2.8,-4,0.4]),
       key          = "Group B",
       fill_color   = red,
       fill_density = 0.6,
       line_width   = 4,
       bars([1.2,4,0.4],[2.2,-2,0.4],[3.2,5,0.4]),
       xaxis = true);
@end example
@figure{draw_bars}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn



@anchor{cylindrical}
@deffn  {Graphic object} cylindrical (@var{radius}, @var{z}, @var{minz}, @var{maxz}, @var{azi}, @var{minazi}, @var{maxazi})
Draws 3D functions defined in cylindrical coordinates.

@b{3D}

@code{cylindrical(@var{radius}, @var{z}, @var{minz}, @var{maxz}, @var{azi},
@var{minazi}, @var{maxazi})} plots the function @code{@var{radius}(@var{z},
@var{azi})} defined in cylindrical coordinates, with variable @var{z} taking
values from @var{minz} to @var{maxz} and @i{azimuth} @var{azi} taking values
from @var{minazi} to @var{maxazi}.

This object is affected by the following @i{graphic options}: @mrefcomma{xu_grid} 
@mrefcomma{yv_grid} @mrefcomma{line_type} @mrefcomma{key} @mrefcomma{wired_surface} @code{enhanced3d} and @code{color}

Example:

@example
(%i1) draw3d(cylindrical(1,z,-2,2,az,0,2*%pi))$
@end example
@figure{draw_cylindrical}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@anchor{elevation_grid}
@deffn  {Graphic object} elevation_grid (@var{mat},@var{x0},@var{y0},@var{width},@var{height})
Draws matrix @var{mat} in 3D space. @var{z} values are taken from @var{mat},
the abscissas range from @var{x0} to @math{@var{x0} + @var{width}}
and ordinates from @var{y0} to @math{@var{y0} + @var{height}}. Element @math{a(1,1)}
is projected on point @math{(x0,y0+height)}, @math{a(1,n)} on @math{(x0+width,y0+height)},
@math{a(m,1)} on @math{(x0,y0)}, and @math{a(m,n)} on @math{(x0+width,y0)}.

This object is affected by the following @i{graphic options}: @mrefcomma{line_type},
@mref{line_width}  @mrefcomma{key}  @mrefcomma{wired_surface}  @mref{enhanced3d} and @code{color}

In older versions of Maxima, @mref{elevation_grid} was called @mrefdot{mesh}
See also @mrefdot{mesh}

Example:

@example
(%i1) m: apply(
            matrix,
            makelist(makelist(random(10.0),k,1,30),i,1,20)) $
(%i2) draw3d(
         color = blue,
         elevation_grid(m,0,0,3,2),
         xlabel = "x",
         ylabel = "y",
         surface_hide = true);
@end example
@figure{draw_elevation_grid}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@anchor{ellipse}
@deffn  {Graphic object} ellipse (@var{xc}, @var{yc}, @var{a}, @var{b}, @var{ang1}, @var{ang2})
Draws ellipses and circles in 2D.


@b{2D}

@code{ellipse (@var{xc}, @var{yc}, @var{a}, @var{b}, @var{ang1}, @var{ang2})}
plots an ellipse centered at @code{[@var{xc}, @var{yc}]} with horizontal and vertical
semi axis @var{a} and @var{b}, respectively, starting at angle @var{ang1} with an amplitude
equal to angle @var{ang2}.

This object is affected by the following @i{graphic options}: @mrefcomma{nticks} 
@mrefcomma{transparent} @mrefcomma{fill_color} @mrefcomma{border} @code{line_width}, 
@mrefcomma{line_type} @mref{key} and @code{color}

Example:

@example
(%i1) draw2d(transparent = false,
             fill_color  = red,
             color       = gray30,
             transparent = false,
             line_width  = 5,
             ellipse(0,6,3,2,270,-270),
             /* center (x,y), a, b, start & end in degrees */
             transparent = true,
             color       = blue,
             line_width  = 3,
             ellipse(2.5,6,2,3,30,-90),
             xrange      = [-3,6],
             yrange      = [2,9] )$
@end example
@figure{draw_ellipse}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn


@anchor{errors}
@deffn  {Graphic object} errors ([@var{x1}, @var{x2}, @dots{}], [@var{y1}, @var{y2}, @dots{}])
Draws points with error bars, horizontally, vertically or both, depending on the
value of option @code{error_type}.

@b{2D}

If @code{error_type = x}, arguments to @code{errors} must be of the form
@code{[x, y, xdelta]} or @code{[x, y, xlow, xhigh]}.  If @code{error_type = y}, 
arguments must be of the form @code{[x, y, ydelta]} or
@code{[x, y, ylow, yhigh]}.  If @code{error_type = xy} or
@code{error_type = boxes}, arguments to @code{errors} must be of the form
@code{[x, y, xdelta, ydelta]} or @code{[x, y, xlow, xhigh, ylow, yhigh]}.

See also @mrefdot{error_type}

This object is affected by the following @i{graphic options}: @mrefcomma{error_type}  
@mrefcomma{points_joined}  @mrefcomma{line_width}  @mrefcomma{key}  @mrefcomma{line_type}  
@code{color}  @mrefcomma{fill_density}  @mref{xaxis_secondary}  and  @mrefdot{yaxis_secondary}

Option @mref{fill_density} is only relevant when @code{error_type=boxes}.

Examples:

Horizontal error bars.

@example
(%i1) draw2d(
        error_type = 'y,
        errors([[1,2,1], [3,5,3], [10,3,1], [17,6,2]]))$
@end example
@figure{draw_errors}

Vertical and horizontal error bars.

@example
(%i1) draw2d(
        error_type = 'xy,
        points_joined = true,
        color = blue,
        errors([[1,2,1,2], [3,5,2,1], [10,3,1,1], [17,6,1/2,2]])); 
@end example
@figure{draw_errors2}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn


@anchor{explicit}
@deffn  {Graphic object} explicit @
@fname{explicit} (@var{expr},@var{var},@var{minval},@var{maxval}) @
@fname{explicit} (@var{fcn},@var{var},@var{minval},@var{maxval}) @
@fname{explicit} (@var{expr},@var{var1},@var{minval1},@var{maxval1},@var{var2},@var{minval2},@var{maxval2}) @
@fname{explicit} (@var{fcn},@var{var1},@var{minval1},@var{maxval1},@var{var2},@var{minval2},@var{maxval2})

Draws explicit functions in 2D and 3D.

@b{2D}

@code{explicit(@var{fcn},@var{var},@var{minval},@var{maxval})} plots explicit function @var{fcn},
with variable @var{var} taking values from @var{minval} to @var{maxval}.

This object is affected by the following @i{graphic options}: @mrefcomma{nticks} 
@code{adapt_depth}, @mrefcomma{draw_realpart} @mrefcomma{line_width} @mrefcomma{line_type} @mrefcomma{key} 
@mrefcomma{filled_func} @mref{fill_color} and @code{color}

Example:

@example
(%i1) draw2d(line_width = 3,
             color      = blue,
             explicit(x^2,x,-3,3) )$
@end example
@figure{draw_explicit}
@example
(%i2) draw2d(fill_color  = brown,
             filled_func = true,
             explicit(x^2,x,-3,3) )$
@end example
@figure{draw_explicit2}

@b{3D}

@code{explicit(@var{fcn}, @var{var1}, @var{minval1}, @var{maxval1}, @var{var2},
@var{minval2}, @var{maxval2})} plots the explicit function @var{fcn}, with
variable @var{var1} taking values from @var{minval1} to @var{maxval1} and
variable @var{var2} taking values from @var{minval2} to @var{maxval2}.

This object is affected by the following @i{graphic options}: @mrefcomma{draw_realpart} @mrefcomma{xu_grid}
@mrefcomma{yv_grid} @mrefcomma{line_type} @mrefcomma{line_width} @mrefcomma{key} @mrefcomma{wired_surface}
@mref{enhanced3d} and @code{color}.

Example:

@example
(%i1) draw3d(key   = "Gauss",
             color = "#a02c00",
             explicit(20*exp(-x^2-y^2)-10,x,-3,3,y,-3,3),
             yv_grid     = 10,
             color = blue,
             key   = "Plane",
             explicit(x+y,x,-5,5,y,-5,5),
             surface_hide = true)$
@end example
@figure{draw_explicit3}

See also @mref{filled_func} for filled functions.

@opencatbox
@category{Package draw}
@closecatbox

@end deffn



@anchor{image}
@deffn  {Graphic object} image (@var{im},@var{x0},@var{y0},@var{width},@var{height})
Renders images in 2D.

@b{2D}

@code{image (@var{im},@var{x0},@var{y0},@var{width},@var{height})} plots image @var{im} in the rectangular
region from vertex @code{(@var{x0},@var{y0})} to @code{(x0+@var{width},y0+@var{height})} on the real
plane. Argument @var{im} must be a matrix of real numbers, a matrix of
vectors of length three or a @var{picture} object.

If @var{im} is a matrix of real numbers or a @var{levels picture} object,
pixel values are interpreted according to graphic option @code{palette},
which is a vector of length three with components 
ranging from -36 to +36; each value is an index for a formula mapping the levels
onto red, green and blue colors, respectively:
@example
 0: 0               1: 0.5           2: 1
 3: x               4: x^2           5: x^3
 6: x^4             7: sqrt(x)       8: sqrt(sqrt(x))
 9: sin(90x)       10: cos(90x)     11: |x-0.5|
12: (2x-1)^2       13: sin(180x)    14: |cos(180x)|
15: sin(360x)      16: cos(360x)    17: |sin(360x)|
18: |cos(360x)|    19: |sin(720x)|  20: |cos(720x)|
21: 3x             22: 3x-1         23: 3x-2
24: |3x-1|         25: |3x-2|       26: (3x-1)/2
27: (3x-2)/2       28: |(3x-1)/2|   29: |(3x-2)/2|
30: x/0.32-0.78125                  31: 2*x-0.84
32: 4x;1;-2x+1.84;x/0.08-11.5
33: |2*x - 0.5|    34: 2*x          35: 2*x - 0.5
36: 2*x - 1
@end example
negative numbers mean negative colour component.

@code{palette = gray} and @code{palette = color} are short cuts for
@code{palette = [3,3,3]} and @code{palette = [7,5,15]}, respectively.

If @var{im} is a matrix of vectors of length three or an @var{rgb picture} object,
they are interpreted as red, green and blue color components.

Examples:

If @var{im} is a matrix of real numbers, pixel values are interpreted according
to graphic option @code{palette}.
@example
(%i1) im: apply(
           'matrix,
            makelist(makelist(random(200),i,1,30),i,1,30))$
(%i2) /* palette = color, default */
      draw2d(image(im,0,0,30,30))$
@end example
@figure{draw_image}
@example
(%i3) draw2d(palette = gray, image(im,0,0,30,30))$
@end example
@figure{draw_image2}
@example
(%i4) draw2d(palette = [15,20,-4],
             colorbox=false,
             image(im,0,0,30,30))$
@end example
@figure{draw_image3}

See also @mrefdot{colorbox}

If @var{im} is a matrix of vectors of length three, they are interpreted
as red, green and blue color components.
@example
(%i1) im: apply(
            'matrix,
             makelist(
               makelist([random(300),
                         random(300),
                         random(300)],i,1,30),i,1,30))$
(%i2) draw2d(image(im,0,0,30,30))$
@end example
@figure{draw_image4}

Package @code{draw} automatically loads package @code{picture}. In this
example, a level picture object is built by hand and then rendered.
@example
(%i1) im: make_level_picture([45,87,2,134,204,16],3,2);
(%o1)       picture(level, 3, 2, @{Array:  #(45 87 2 134 204 16)@})
(%i2) /* default color palette */
      draw2d(image(im,0,0,30,30))$
@end example
@figure{draw_image5}
@example
(%i3) /* gray palette */
      draw2d(palette = gray,
             image(im,0,0,30,30))$
@end example
@figure{draw_image6}

An xpm file is read and then rendered.
@example
(%i1) im: read_xpm("myfile.xpm")$
(%i2) draw2d(image(im,0,0,10,7))$
@end example

See also @mrefcomma{make_level_picture}  @mref{make_rgb_picture} and @mrefdot{read_xpm}

@url{http://www.telefonica.net/web2/biomates/maxima/gpdraw/image}@*
contains more elaborated examples.

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@anchor{implicit}
@deffn  {Graphic object} implicit @
@fname{implicit} (@var{fcn},@var{x},@var{xmin},@var{xmax},@var{y},@var{ymin},@var{ymax}) @
@fname{implicit} (@var{fcn},@var{x},@var{xmin},@var{xmax},@var{y},@var{ymin},@var{ymax},@var{z},@var{zmin},@var{zmax})

Draws implicit functions in 2D and 3D.

@b{2D}

@code{implicit(@var{fcn},@var{x},@var{xmin},@var{xmax},@var{y},@var{ymin},@var{ymax})}
plots the implicit function defined by @var{fcn}, with variable @var{x} taking values
from @var{xmin} to @var{xmax}, and variable @var{y} taking values
from @var{ymin} to @var{ymax}.

This object is affected by the following @i{graphic options}: @mrefcomma{ip_grid} 
@mrefcomma{ip_grid_in} @mrefcomma{line_width} @mrefcomma{line_type} @mref{key} and @code{color}.

Example:

@example
(%i1) draw2d(grid      = true,
             line_type = solid,
             key       = "y^2=x^3-2*x+1",
             implicit(y^2=x^3-2*x+1, x, -4,4, y, -4,4),
             line_type = dots,
             key       = "x^3+y^3 = 3*x*y^2-x-1",
             implicit(x^3+y^3 = 3*x*y^2-x-1, x,-4,4, y,-4,4),
             title     = "Two implicit functions" )$
@end example
@figure{draw_implicit}

@b{3D}

@code{implicit (@var{fcn},@var{x},@var{xmin},@var{xmax}, @var{y},@var{ymin},@var{ymax}, @var{z},@var{zmin},@var{zmax})}
plots the implicit surface defined by @var{fcn}, with variable @var{x} taking values
from @var{xmin} to @var{xmax}, variable @var{y} taking values
from @var{ymin} to @var{ymax} and variable @var{z} taking values
from @var{zmin} to @var{zmax}. This object implements the @i{marching cubes algorithm}.

This object is affected by the following @i{graphic options}: @mrefcomma{x_voxel} 
@mrefcomma{y_voxel} @mrefcomma{z_voxel} @mrefcomma{line_width} @mrefcomma{line_type} @mrefcomma{key}
@mrefcomma{wired_surface} @mref{enhanced3d} and @code{color}.

Example:

@example
(%i1) draw3d(
        color=blue,
        implicit((x^2+y^2+z^2-1)*(x^2+(y-1.5)^2+z^2-0.5)=0.015,
                 x,-1,1,y,-1.2,2.3,z,-1,1),
        surface_hide=true);
@end example
@figure{draw_implicit2}

@opencatbox
@category{Package draw}
@closecatbox
@end deffn



@anchor{label_draw}
@deffn  {Graphic object} label @
@fname{label} ([@var{string},@var{x},@var{y}],...) @
@fname{label} ([@var{string},@var{x},@var{y},@var{z}],...)

Writes labels in 2D and 3D.

Colored labels work only with Gnuplot 4.3 and up.

This object is affected by the following @i{graphic options}: @mrefcomma{label_alignment} 
@mref{label_orientation} and @code{color}.

@b{2D}

@code{label([@var{string},@var{x},@var{y}])} writes the @var{string} at point
@code{[@var{x},@var{y}]}.

Example:

@example
(%i1) draw2d(yrange = [0.1,1.4],
             color = red,
             label(["Label in red",0,0.3]),
             color = "#0000ff",
             label(["Label in blue",0,0.6]),
             color = light_blue,
             label(["Label in light-blue",0,0.9],
                   ["Another light-blue",0,1.2])  )$
@end example
@figure{draw_label}

@b{3D}

@code{label([@var{string},@var{x},@var{y},@var{z}])} writes the @var{string} at point
@code{[@var{x},@var{y},@var{z}]}.

Example:

@example
(%i1) draw3d(explicit(exp(sin(x)+cos(x^2)),x,-3,3,y,-3,3),
             color = red,
             label(["UP 1",-2,0,3], ["UP 2",1.5,0,4]),
             color = blue,
             label(["DOWN 1",2,0,-3]) )$
@end example
@figure{draw_label2}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn


@anchor{mesh}
@deffn  {Graphic object} mesh (@var{row_1},@var{row_2},...)
Draws a quadrangular mesh in 3D.

@b{3D}

Argument @var{row_i} is a list of @var{n} 3D points of the form
@code{[[x_i1,y_i1,z_i1], ...,[x_in,y_in,z_in]]}, and all rows are
of equal length. All these points define an arbitrary surface in 3D and
in some sense it's a generalization of the @code{elevation_grid} object.

This object is affected by the following @i{graphic options}: @mrefcomma{line_type} 
@mrefcomma{line_width} @mrefcomma{color} @mrefcomma{key} @mrefcomma{wired_surface} @mref{enhanced3d} and @mrefdot{transform}

Examples:

A simple example.

@example
(%i1) draw3d( 
         mesh([[1,1,3],   [7,3,1],[12,-2,4],[15,0,5]],
              [[2,7,8],   [4,3,1],[10,5,8], [12,7,1]],
              [[-2,11,10],[6,9,5],[6,15,1], [20,15,2]])) $
@end example
@figure{draw_mesh}

Plotting a triangle in 3D.

@example
(%i1) draw3d(
        line_width = 2,
        mesh([[1,0,0],[0,1,0]],
             [[0,0,1],[0,0,1]])) $
@end example
@figure{draw_mesh2}

Two quadrilaterals.

@example
(%i1) draw3d(
        surface_hide = true,
        line_width   = 3,
        color = red,
        mesh([[0,0,0], [0,1,0]],
             [[2,0,2], [2,2,2]]),
        color = blue,
        mesh([[0,0,2], [0,1,2]],
             [[2,0,4], [2,2,4]])) $
@end example
@figure{draw_mesh3}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn


@anchor{parametric}
@deffn  {Graphic object} parametric @
@fname{parametric} (@var{xfun},@var{yfun},@var{par},@var{parmin},@var{parmax}) @
@fname{parametric} (@var{xfun},@var{yfun},@var{zfun},@var{par},@var{parmin},@var{parmax})

Draws parametric functions in 2D and 3D.

This object is affected by the following @i{graphic options}: @mrefcomma{nticks} 
@mrefcomma{line_width} @mrefcomma{line_type} @mrefcomma{key} @mref{color} and @mrefdot{enhanced3d}

@b{2D}

The command @code{parametric(@var{xfun}, @var{yfun}, @var{par}, @var{parmin},
@var{parmax})} plots the parametric function @code{[@var{xfun}, @var{yfun}]},
with parameter @var{par} taking values from @var{parmin} to @var{parmax}.

Example:

@example
(%i1) draw2d(explicit(exp(x),x,-1,3),
             color = red,
             key   = "This is the parametric one!!",
             parametric(2*cos(rrr),rrr^2,rrr,0,2*%pi))$
@end example
@figure{draw_parametric}

@b{3D}

@code{parametric(@var{xfun}, @var{yfun}, @var{zfun}, @var{par}, @var{parmin},
@var{parmax})} plots the parametric curve @code{[@var{xfun}, @var{yfun},
@var{zfun}]}, with parameter @var{par} taking values from @var{parmin} to
@var{parmax}.

Example:

@example
(%i1) draw3d(explicit(exp(sin(x)+cos(x^2)),x,-3,3,y,-3,3),
             color = royalblue,
             parametric(cos(5*u)^2,sin(7*u),u-2,u,0,2),
             color      = turquoise,
             line_width = 2,
             parametric(t^2,sin(t),2+t,t,0,2),
             surface_hide = true,
             title = "Surface & curves" )$
@end example
@figure{draw_parametric2}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn



@anchor{parametric_surface}
@deffn  {Graphic object} parametric_surface (@var{xfun}, @var{yfun}, @var{zfun}, @var{par1}, @var{par1min}, @var{par1max}, @var{par2}, @var{par2min}, @var{par2max})
Draws parametric surfaces in 3D.

@b{3D}

The command @code{parametric_surface(@var{xfun}, @var{yfun}, @var{zfun},
@var{par1}, @var{par1min}, @var{par1max}, @var{par2}, @var{par2min},
@var{par2max})} plots the parametric surface @code{[@var{xfun}, @var{yfun},
@var{zfun}]}, with parameter @var{par1} taking values from @var{par1min} to
@var{par1max} and parameter @var{par2} taking values from @var{par2min} to
@var{par2max}.

This object is affected by the following @i{graphic options}: @mrefcomma{draw_realpart} @mrefcomma{xu_grid} 
@mrefcomma{yv_grid} @mrefcomma{line_type} @mrefcomma{line_width} @mrefcomma{key} @mrefcomma{wired_surface} @mref{enhanced3d}
 and @code{color}.

Example:

@example
(%i1) draw3d(title          = "Sea shell",
             xu_grid        = 100,
             yv_grid        = 25,
             view           = [100,20],
             surface_hide   = true,
             parametric_surface(0.5*u*cos(u)*(cos(v)+1),
                           0.5*u*sin(u)*(cos(v)+1),
                           u*sin(v) - ((u+3)/8*%pi)^2 - 20,
                           u, 0, 13*%pi, v, -%pi, %pi) )$
@end example
@figure{draw_parametric3}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn



@anchor{points}
@deffn  {Graphic object} points @
@fname{points} ([[@var{x1},@var{y1}], [@var{x2},@var{y2}],...]) @
@fname{points} ([@var{x1},@var{x2},...], [@var{y1},@var{y2},...]) @
@fname{points} ([@var{y1},@var{y2},...]) @
@fname{points} ([[@var{x1},@var{y1},@var{z1}], [@var{x2},@var{y2},@var{z2}],...]) @
@fname{points} ([@var{x1},@var{x2},...], [@var{y1},@var{y2},...], [@var{z1},@var{z2},...]) @
@fname{points} (@var{matrix}) @
@fname{points} (@var{1d_y_array}) @
@fname{points} (@var{1d_x_array}, @var{1d_y_array}) @
@fname{points} (@var{1d_x_array}, @var{1d_y_array}, @var{1d_z_array}) @
@fname{points} (@var{2d_xy_array}) @
@fname{points} (@var{2d_xyz_array})

Draws points in 2D and 3D.

This object is affected by the following @i{graphic options}: @mrefcomma{point_size} 
@mrefcomma{point_type} @mrefcomma{points_joined} @mrefcomma{line_width} @mrefcomma{key}
@mref{line_type} and @code{color}. In 3D mode, it is also affected by @mref{enhanced3d}

@b{2D}

@code{points ([[@var{x1},@var{y1}], [@var{x2},@var{y2}],...])} or
@code{points ([@var{x1},@var{x2},...], [@var{y1},@var{y2},...])}
plots points @code{[x1,y1]}, @code{[x2,y2]}, etc. If abscissas
are not given, they are set to consecutive positive integers, so that 
@code{points ([@var{y1},@var{y2},...])} draws points @code{[1,@var{y1}]}, @code{[2,@var{y2}]}, etc.
If @var{matrix} is a two-column or two-row matrix, @code{points (@var{matrix})}
draws the associated points. If @var{matrix} is a one-column or one-row matrix,
abscissas are assigned automatically.

If @var{1d_y_array} is a 1D lisp array of numbers, @code{points (@var{1d_y_array})} plots them
setting abscissas to consecutive positive integers. @code{points (@var{1d_x_array}, @var{1d_y_array})}
plots points with their coordinates taken from the two arrays passed as arguments. If
@var{2d_xy_array} is a 2D array with two columns, or with two rows, @code{points (@var{2d_xy_array})}
plots the corresponding points on the plane.

Examples:

Two types of arguments for @code{points}, a list of pairs and two lists
of separate coordinates.
@example
(%i1) draw2d(
        key = "Small points",
        points(makelist([random(20),random(50)],k,1,10)),
        point_type    = circle,
        point_size    = 3,
        points_joined = true,
        key           = "Great points",
        points(makelist(k,k,1,20),makelist(random(30),k,1,20)),
        point_type    = filled_down_triangle,
        key           = "Automatic abscissas",
        color         = red,
        points([2,12,8]))$
@end example
@figure{draw_points}

Drawing impulses.
@example
(%i1) draw2d(
        points_joined = impulses,
        line_width    = 2,
        color         = red,
        points(makelist([random(20),random(50)],k,1,10)))$
@end example
@figure{draw_points2}

Array with ordinates.
@example
(%i1) a: make_array (flonum, 100) $
(%i2) for i:0 thru 99 do a[i]: random(1.0) $
(%i3) draw2d(points(a)) $
@end example
@figure{draw_points3}

Two arrays with separate coordinates.
@example
(%i1) x: make_array (flonum, 100) $
(%i2) y: make_array (fixnum, 100) $
(%i3) for i:0 thru 99 do (
        x[i]: float(i/100),
        y[i]: random(10) ) $
(%i4) draw2d(points(x, y)) $
@end example
@figure{draw_points4}

A two-column 2D array.
@example
(%i1) xy: make_array(flonum, 100, 2) $
(%i2) for i:0 thru 99 do (
        xy[i, 0]: float(i/100),
        xy[i, 1]: random(10) ) $
(%i3) draw2d(points(xy)) $
@end example
@figure{draw_points5}

Drawing an array filled with function @code{read_array}.
@example
(%i1) a: make_array(flonum,100) $
(%i2) read_array (file_search ("pidigits.data"), a) $
(%i3) draw2d(points(a)) $
@end example

@b{3D}

@code{points([[@var{x1}, @var{y1}, @var{z1}], [@var{x2}, @var{y2}, @var{z2}],
...])} or @code{points([@var{x1}, @var{x2}, ...], [@var{y1}, @var{y2}, ...],
[@var{z1}, @var{z2},...])} plots points @code{[@var{x1}, @var{y1}, @var{z1}]},
@code{[@var{x2}, @var{y2}, @var{z2}]}, etc.  If @var{matrix} is a three-column
or three-row matrix, @code{points (@var{matrix})} draws the associated points.

When arguments are lisp arrays, @code{points (@var{1d_x_array}, @var{1d_y_array}, @var{1d_z_array})}
takes coordinates from the three 1D arrays.  If @var{2d_xyz_array} is a 2D array with three columns,
or with three rows, @code{points (@var{2d_xyz_array})} plots the corresponding points.

Examples:

One tridimensional sample,
@example
(%i1) load ("numericalio")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
(%i3) draw3d(title = "Daily average wind speeds",
             point_size = 2,
             points(args(submatrix (s2, 4, 5))) )$
@end example

Two tridimensional samples,
@example
(%i1) load ("numericalio")$
(%i2) s2 : read_matrix (file_search ("wind.data"))$
(%i3) draw3d(
         title = "Daily average wind speeds. Two data sets",
         point_size = 2,
         key        = "Sample from stations 1, 2 and 3",
         points(args(submatrix (s2, 4, 5))),
         point_type = 4,
         key        = "Sample from stations 1, 4 and 5",
         points(args(submatrix (s2, 2, 3))) )$
@end example

Unidimensional arrays,
@example
(%i1) x: make_array (fixnum, 10) $
(%i2) y: make_array (fixnum, 10) $
(%i3) z: make_array (fixnum, 10) $
(%i4) for i:0 thru 9 do (
        x[i]: random(10),
        y[i]: random(10),
        z[i]: random(10) ) $
(%i5) draw3d(points(x,y,z)) $
@end example
@figure{draw_points6}

Bidimensional colored array,
@example
(%i1) xyz: make_array(fixnum, 10, 3) $
(%i2) for i:0 thru 9 do (
        xyz[i, 0]: random(10),
        xyz[i, 1]: random(10),
        xyz[i, 2]: random(10) ) $
(%i3) draw3d(
         enhanced3d = true,
         points_joined = true,
         points(xyz)) $
@end example
@figure{draw_points7}

Color numbers explicitly specified by the user.
@example
(%i1) pts: makelist([t,t^2,cos(t)], t, 0, 15)$
(%i2) col_num: makelist(k, k, 1, length(pts))$
(%i3) draw3d(
        enhanced3d = ['part(col_num,k),k],
        point_size = 3,
        point_type = filled_circle,
        points(pts))$
@end example
@figure{draw_points8}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn



@anchor{polar}
@deffn  {Graphic object} polar (@var{radius},@var{ang},@var{minang},@var{maxang})
Draws 2D functions defined in polar coordinates.

@b{2D}

@code{polar (@var{radius},@var{ang},@var{minang},@var{maxang})} plots function 
@code{@var{radius}(@var{ang})} defined in polar coordinates, with variable 
@var{ang} taking values from 
@var{minang} to @var{maxang}.

This object is affected by the following @i{graphic options}: @mrefcomma{nticks} 
@mrefcomma{line_width} @mrefcomma{line_type} @mref{key} and @code{color}.

Example:

@example
(%i1) draw2d(user_preamble = "set grid polar",
             nticks        = 200,
             xrange        = [-5,5],
             yrange        = [-5,5],
             color         = blue,
             line_width    = 3,
             title         = "Hyperbolic Spiral",
             polar(10/theta,theta,1,10*%pi) )$
@end example
@figure{draw_polar}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@anchor{polygon}
@deffn  {Graphic object} polygon @
@fname{polygon} ([[@var{x1}, @var{y1}], [@var{x2}, @var{y2}], @dots{}]) @
@fname{polygon} ([@var{x1}, @var{x2}, @dots{}], [@var{y1}, @var{y2}, @dots{}])

Draws polygons in 2D.

@b{2D}

The commands @code{polygon([[@var{x1}, @var{y1}], [@var{x2}, @var{y2}], ...])}
or @code{polygon([@var{x1}, @var{x2}, ...], [@var{y1}, @var{y2}, ...])} plot on
the plane a polygon with vertices @code{[@var{x1}, @var{y1}]}, @code{[@var{x2},
@var{y2}]}, etc.

This object is affected by the following @i{graphic options}: @mrefcomma{transparent} 
@mrefcomma{fill_color} @mrefcomma{border} @mrefcomma{line_width} @mrefcomma{key}
 @mref{line_type} and @code{color}.

Example:

@example
(%i1) draw2d(color      = "#e245f0",
             line_width = 8,
             polygon([[3,2],[7,2],[5,5]]),
             border      = false,
             fill_color  = yellow,
             polygon([[5,2],[9,2],[7,5]]) )$
@end example
@figure{draw_polygon}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn


@anchor{quadrilateral}
@deffn  {Graphic object} quadrilateral (@var{point_1}, @var{point_2}, @var{point_3}, @var{point_4})
Draws a quadrilateral.

@b{2D}

@code{quadrilateral([@var{x1}, @var{y1}], [@var{x2}, @var{y2}], 
[@var{x3}, @var{y3}], [@var{x4}, @var{y4}])} draws a quadrilateral with vertices
@code{[@var{x1}, @var{y1}]}, @code{[@var{x2}, @var{y2}]}, 
@code{[@var{x3}, @var{y3}]}, and @code{[@var{x4}, @var{y4}]}.

This object is affected by the following @i{graphic options}:@*
@mrefcomma{transparent} @mrefcomma{fill_color} @mrefcomma{border} @mrefcomma{line_width}
@mrefcomma{key} @mrefcomma{xaxis_secondary} @mrefcomma{yaxis_secondary} @mrefcomma{line_type}
@code{transform} and @code{color}.

Example:

@example
(%i1) draw2d(
        quadrilateral([1,1],[2,2],[3,-1],[2,-2]))$
@end example
@figure{draw_quadrilateral}

@b{3D}

@code{quadrilateral([@var{x1}, @var{y1}, @var{z1}], [@var{x2}, @var{y2},
@var{z2}], [@var{x3}, @var{y3}, @var{z3}], [@var{x4}, @var{y4}, @var{z4}])}
draws a quadrilateral with vertices @code{[@var{x1}, @var{y1}, @var{z1}]},
@code{[@var{x2}, @var{y2}, @var{z2}]}, @code{[@var{x3}, @var{y3}, @var{z3}]},
and @code{[@var{x4}, @var{y4}, @var{z4}]}.

This object is affected by the following @i{graphic options}: @mrefcomma{line_type} 
@mrefcomma{line_width} @mrefcomma{color} @mrefcomma{key} @mref{enhanced3d} and
@mrefdot{transform}

@opencatbox
@category{Package draw}
@closecatbox
@end deffn

@anchor{rectangle}
@deffn  {Graphic object} rectangle ([@var{x1},@var{y1}], [@var{x2},@var{y2}])
Draws rectangles in 2D.

@b{2D}

@code{rectangle ([@var{x1},@var{y1}], [@var{x2},@var{y2}])} draws a rectangle with opposite vertices
@code{[@var{x1},@var{y1}]} and @code{[@var{x2},@var{y2}]}.

This object is affected by the following @i{graphic options}: @mrefcomma{transparent} 
@mrefcomma{fill_color} @mrefcomma{border} @mrefcomma{line_width} @mrefcomma{key}
@mref{line_type} and @code{color}.

Example:

@example
(%i1) draw2d(fill_color  = red,
             line_width  = 6,
             line_type   = dots,
             transparent = false,
             fill_color  = blue,
             rectangle([-2,-2],[8,-1]), /* opposite vertices */
             transparent = true,
             line_type   = solid,
             line_width  = 1,
             rectangle([9,4],[2,-1.5]),
             xrange      = [-3,10],
             yrange      = [-3,4.5] )$
@end example
@figure{draw_rectangle}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@anchor{region}
@deffn  {Graphic object} region (@var{expr},@var{var1},@var{minval1},@var{maxval1},@var{var2},@var{minval2},@var{maxval2})
Plots a region on the plane defined by inequalities.

@b{2D}
@var{expr} is an expression formed by inequalities and boolean operators
@code{and}, @code{or}, and @mrefdot{not} The region is bounded by the rectangle
defined by @math{[@var{minval1}, @var{maxval1}]} and @math{[@var{minval2}, @var{maxval2}]}.

This object is affected by the following @i{graphic options}: @mrefcomma{fill_color} 
@mrefcomma{key} @mref{x_voxel} and @mrefdot{y_voxel}

Example:

@example
(%i1) draw2d(
        x_voxel = 30,
        y_voxel = 30,
        region(x^2+y^2<1 and x^2+y^2 > 1/2,
               x, -1.5, 1.5, y, -1.5, 1.5));
@end example
@end deffn
@figure{draw_region}


@anchor{spherical}
@deffn  {Graphic object} spherical (@var{radius}, @var{azi}, @var{minazi}, @var{maxazi}, @var{zen}, @var{minzen}, @var{maxzen})
Draws 3D functions defined in spherical coordinates.

@b{3D}

@code{spherical(@var{radius}, @var{azi}, @var{minazi}, @var{maxazi}, @var{zen},
@var{minzen}, @var{maxzen})} plots the function @code{@var{radius}(@var{azi},
@var{zen})} defined in spherical coordinates, with @i{azimuth} @var{azi} taking
values from @var{minazi} to @var{maxazi} and @i{zenith} @var{zen} taking values
from @var{minzen} to @var{maxzen}.

This object is affected by the following @i{graphic options}: @mrefcomma{xu_grid} 
@mrefcomma{yv_grid} @mrefcomma{line_type} @mrefcomma{key} @mrefcomma{wired_surface} @mref{enhanced3d} and @code{color}.

Example:

@example
(%i1) draw3d(spherical(1,a,0,2*%pi,z,0,%pi))$
@end example
@figure{draw_spherical}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn


@anchor{triangle}
@deffn  {Graphic object} triangle (@var{point_1}, @var{point_2}, @var{point_3})
Draws a triangle.

@b{2D}

@code{triangle ([@var{x1},@var{y1}], [@var{x2},@var{y2}], [@var{x3},@var{y3}])} draws a triangle with vertices @code{[@var{x1},@var{y1}]}, @code{[@var{x2},@var{y2}]},
and @code{[@var{x3},@var{y3}]}.

This object is affected by the following @i{graphic options}:@*
@mrefcomma{transparent} @mrefcomma{fill_color} @mrefcomma{border} @mrefcomma{line_width}
@mrefcomma{key} @mrefcomma{xaxis_secondary} @mrefcomma{yaxis_secondary} @mrefcomma{line_type}
@mref{transform} and @code{color}.

Example:

@example
(%i1) draw2d(
        triangle([1,1],[2,2],[3,-1]))$
@end example
@figure{draw_triangle}

@b{3D}

@code{triangle ([@var{x1},@var{y1},@var{z1}], [@var{x2},@var{y2},@var{z2}], [@var{x3},@var{y3},@var{z3}])} draws a triangle with vertices @code{[@var{x1},@var{y1},@var{z1}]},
@code{[@var{x2},@var{y2},@var{z2}]}, and @code{[@var{x3},@var{y3},@var{z3}]}.

This object is affected by the following @i{graphic options}: @mrefcomma{line_type} 
@mrefcomma{line_width} @mrefcomma{color} @mrefcomma{key} @mref{enhanced3d} and @mrefdot{transform}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn


@anchor{tube}
@deffn  {Graphic object} tube (@var{xfun},@var{yfun},@var{zfun},@var{rfun},@var{p},@var{pmin},@var{pmax})
Draws a tube in 3D with varying diameter.

@b{3D}

@code{[@var{xfun},@var{yfun},@var{zfun}]}
is the parametric curve with parameter @var{p} taking values from @var{pmin}
to @var{pmax}. Circles of radius @var{rfun} are placed with their centers on
the parametric curve and perpendicular to it.

This object is affected by the following @i{graphic options}: @mrefcomma{xu_grid} 
@mrefcomma{yv_grid} @mrefcomma{line_type} @mrefcomma{line_width} @mrefcomma{key} @mrefcomma{wired_surface} @mrefcomma{enhanced3d}
@mref{color} and @mrefdot{capping}

Example:

@example
(%i1) draw3d(
        enhanced3d = true,
        xu_grid = 50,
        tube(cos(a), a, 0, cos(a/10)^2,
             a, 0, 4*%pi) )$
@end example
@figure{draw_tube}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn



@anchor{vector}
@deffn  {Graphic object} vector @
@fname{vector} ([@var{x},@var{y}], [@var{dx},@var{dy}]) @
@fname{vector} ([@var{x},@var{y},@var{z}], [@var{dx},@var{dy},@var{dz}])

Draws vectors in 2D and 3D.

This object is affected by the following @i{graphic options}: @mrefcomma{head_both} 
@mrefcomma{head_length} @mrefcomma{head_angle} @mrefcomma{head_type} @mrefcomma{line_width} 
@mrefcomma{line_type} @mref{key} and @code{color}.

@b{2D}

@code{vector([@var{x},@var{y}], [@var{dx},@var{dy}])} plots vector
@code{[@var{dx},@var{dy}]} with origin in @code{[@var{x},@var{y}]}.

Example:

@example
(%i1) draw2d(xrange      = [0,12],
             yrange      = [0,10],
             head_length = 1,
             vector([0,1],[5,5]), /* default type */
             head_type = 'empty,
             vector([3,1],[5,5]),
             head_both = true,
             head_type = 'nofilled,
             line_type = dots,
             vector([6,1],[5,5]))$
@end example
@figure{draw_vector}

@b{3D}

@code{vector([@var{x},@var{y},@var{z}], [@var{dx},@var{dy},@var{dz}])} 
plots vector @code{[@var{dx},@var{dy},@var{dz}]} with
origin in @code{[@var{x},@var{y},@var{z}]}.

Example:

@example
(%i1) draw3d(color = cyan,
             vector([0,0,0],[1,1,1]/sqrt(3)),
             vector([0,0,0],[1,-1,0]/sqrt(2)),
             vector([0,0,0],[1,1,-2]/sqrt(6)) )$
@end example
@figure{draw_vector2}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn





@node Functions and Variables for pictures, Functions and Variables for worldmap, Functions and Variables for draw, draw-pkg
@section Functions and Variables for pictures



@anchor{get_pixel}
@deffn  {Function} get_pixel (@var{pic},@var{x},@var{y})
Returns pixel from picture. Coordinates @var{x} and @var{y} range from 0 to
@code{width-1} and @code{height-1}, respectively.

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@anchor{make_level_picture}
@deffn  {Function} make_level_picture @
@fname{make_level_picture} (@var{data}) @
@fname{make_level_picture} (@var{data},@var{width},@var{height})

Returns a levels @var{picture} object. @code{make_level_picture (@var{data})}
builds the @var{picture} object from matrix @var{data}.
@code{make_level_picture (@var{data},@var{width},@var{height})}
builds the object from a list of numbers; in this case, both the
@var{width} and the @var{height} must be given.

The returned @var{picture} object contains the following 
four parts:

@enumerate
@item symbol @code{level}
@item image width
@item image height
@item an integer array with pixel data ranging from 0 to 255.
Argument @var{data} must contain only numbers ranged from 0 to 255;
negative numbers are substituted by 0, and those which are
greater than 255 are set to 255.
@end enumerate

Example:

Level picture from matrix.
@example
(%i1) make_level_picture(matrix([3,2,5],[7,-9,3000]));
(%o1)         picture(level, 3, 2, @{Array:  #(3 2 5 7 0 255)@})
@end example

Level picture from numeric list.
@example
(%i1) make_level_picture([-2,0,54,%pi],2,2);
(%o1)            picture(level, 2, 2, @{Array:  #(0 0 54 3)@})
@end example

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@anchor{make_rgb_picture}
@deffn  {Function} make_rgb_picture (@var{redlevel},@var{greenlevel},@var{bluelevel})
Returns an rgb-coloured @var{picture} object. All three arguments must
be levels picture; with red, green and blue levels.

The returned @var{picture} object contains the following 
four parts:

@enumerate
@item symbol @code{rgb}
@item image width
@item image height
@item an integer array of length @var{3*width*height} with pixel data ranging
from 0 to 255. Each pixel is represented by three consecutive numbers
(red, green, blue).
@end enumerate

Example:

@example
(%i1) red: make_level_picture(matrix([3,2],[7,260]));
(%o1)           picture(level, 2, 2, @{Array:  #(3 2 7 255)@})
(%i2) green: make_level_picture(matrix([54,23],[73,-9]));
(%o2)           picture(level, 2, 2, @{Array:  #(54 23 73 0)@})
(%i3) blue: make_level_picture(matrix([123,82],[45,32.5698]));
(%o3)          picture(level, 2, 2, @{Array:  #(123 82 45 33)@})
(%i4) make_rgb_picture(red,green,blue);
(%o4) picture(rgb, 2, 2, 
              @{Array:  #(3 54 123 2 23 82 7 73 45 255 0 33)@})
@end example

@opencatbox
@category{Package draw}
@closecatbox

@end deffn





@anchor{negative_picture}
@deffn  {Function} negative_picture (@var{pic})
Returns the negative of a (@var{level} or @var{rgb}) picture.

@opencatbox
@category{Package draw}
@closecatbox
@end deffn





@anchor{picture_equalp}
@deffn  {Function} picture_equalp (@var{x},@var{y})
Returns @code{true} in case of equal pictures, and @code{false} otherwise.

@opencatbox
@category{Package draw}
@category{Predicate functions}
@closecatbox

@end deffn




@anchor{picturep}
@deffn  {Function} picturep (@var{x})
Returns @code{true} if the argument is a well formed image,
and @code{false} otherwise.

@opencatbox
@category{Package draw}
@category{Predicate functions}
@closecatbox

@end deffn



@anchor{read_xpm}
@deffn  {Function} read_xpm (@var{xpm_file})
Reads a file in xpm and returns a picture object.

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@anchor{rgb2level}
@deffn  {Function} rgb2level (@var{pic})
Transforms an @var{rgb} picture into a @var{level} one by
averaging the red, green and blue channels.

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@anchor{take_channel}
@deffn  {Function} take_channel (@var{im},@var{color})
If argument @var{color} is @code{red}, @code{green} or @code{blue},
function @code{take_channel} returns the corresponding color channel of
picture @var{im}.
Example:

@example
(%i1) red: make_level_picture(matrix([3,2],[7,260]));
(%o1)           picture(level, 2, 2, @{Array:  #(3 2 7 255)@})
(%i2) green: make_level_picture(matrix([54,23],[73,-9]));
(%o2)           picture(level, 2, 2, @{Array:  #(54 23 73 0)@})
(%i3) blue: make_level_picture(matrix([123,82],[45,32.5698]));
(%o3)          picture(level, 2, 2, @{Array:  #(123 82 45 33)@})
(%i4) make_rgb_picture(red,green,blue);
(%o4) picture(rgb, 2, 2, 
              @{Array:  #(3 54 123 2 23 82 7 73 45 255 0 33)@})
(%i5) take_channel(%,'green);  /* simple quote!!! */
(%o5)           picture(level, 2, 2, @{Array:  #(54 23 73 0)@})
@end example

@opencatbox
@category{Package draw}
@closecatbox

@end deffn





@node Functions and Variables for worldmap,  , Functions and Variables for pictures, draw-pkg
@section Functions and Variables for worldmap

@subsection Variables and Functions



@anchor{boundaries_array}
@defvr {Global variable} boundaries_array
Default value: @code{false}

@code{boundaries_array} is where the graphic object @code{geomap} looks
for boundaries coordinates.

Each component of @code{boundaries_array} is an array of floating
point quantities, the coordinates of a polygonal segment or map boundary.

See also @mrefdot{geomap}

@opencatbox
@category{Package draw}
@closecatbox

@end defvr





@anchor{numbered_boundaries}
@deffn  {Function} numbered_boundaries (@var{nlist})
Draws a list of polygonal segments (boundaries), labeled by
its numbers (@code{boundaries_array} coordinates). This is of great
help when building new geographical entities.

Example:

Map of Europe labeling borders with their component number in
@code{boundaries_array}.
@example
(%i1) load(worldmap)$
(%i2) european_borders: 
           region_boundaries(-31.81,74.92,49.84,32.06)$
(%i3) numbered_boundaries(european_borders)$
@end example

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@anchor{make_poly_continent}
@deffn  {Function} make_poly_continent @
@fname{make_poly_continent} (@var{continent_name}) @
@fname{make_poly_continent} (@var{country_list})

Makes the necessary polygons to draw a colored continent
or a list of countries.

Example:

@example
(%i1) load(worldmap)$
(%i2) /* A continent */
      make_poly_continent(Africa)$
(%i3) apply(draw2d, %)$
@end example
@figure{worldmap_make_poly_continent}
@example
(%i4) /* A list of countries */
      make_poly_continent([Germany,Denmark,Poland])$
(%i5) apply(draw2d, %)$
@end example
@figure{worldmap_make_poly_continent2}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn





@anchor{make_poly_country}
@deffn  {Function} make_poly_country (@var{country_name})
Makes the necessary polygons to draw a colored country.
If islands exist, one country can be defined with more than
just one polygon.

Example:

@example
(%i1) load(worldmap)$
(%i2) make_poly_country(India)$
(%i3) apply(draw2d, %)$
@end example
@figure{worldmap_make_poly_country}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn





@anchor{make_polygon}
@deffn  {Function} make_polygon (@var{nlist})
Returns a @code{polygon} object from boundary indices. Argument
@var{nlist} is a list of components of @code{boundaries_array}.

Example:

Bhutan is defined by boundary numbers 171, 173
and 1143, so that @code{make_polygon([171,173,1143])}
appends arrays of coordinates @code{boundaries_array[171]},
@code{boundaries_array[173]} and @code{boundaries_array[1143]} and 
returns a @code{polygon} object suited to be plotted by 
@code{draw}. To avoid an error message, arrays must be
compatible in the sense that any two consecutive
arrays have two coordinates in the extremes in common. In this
example, the two first components of @code{boundaries_array[171]} are
equal to the last two coordinates of @code{boundaries_array[173]}, and 
the two first of @code{boundaries_array[173]} are equal to the two first
of @code{boundaries_array[1143]}; in conclussion, boundary numbers
171, 173 and 1143 (in this order) are compatible and the colored 
polygon can be drawn.
@example
(%i1) load(worldmap)$
(%i2) Bhutan;
(%o2)                        [[171, 173, 1143]]
(%i3) boundaries_array[171];
(%o3) @{Array:  
       #(88.750549 27.14727 88.806351 27.25305 88.901367 27.282221
         88.917877 27.321039)@}
(%i4) boundaries_array[173];
(%o4) @{Array:
       #(91.659554 27.76511 91.6008 27.66666 91.598022 27.62499
         91.631348 27.536381 91.765533 27.45694 91.775253 27.4161 
         92.007751 27.471939 92.11441 27.28583 92.015259 27.168051
         92.015533 27.08083 92.083313 27.02277 92.112183 26.920271
         92.069977 26.86194 91.997192 26.85194 91.915253 26.893881
         91.916924 26.85416 91.8358 26.863331 91.712479 26.799999 
         91.542191 26.80444 91.492188 26.87472 91.418854 26.873329
         91.371353 26.800831 91.307457 26.778049 90.682457 26.77417
         90.392197 26.903601 90.344131 26.894159 90.143044 26.75333
         89.98996 26.73583 89.841919 26.70138 89.618301 26.72694 
         89.636093 26.771111 89.360786 26.859989 89.22081 26.81472
         89.110237 26.829161 88.921631 26.98777 88.873016 26.95499
         88.867737 27.080549 88.843307 27.108601 88.750549 
         27.14727)@}
(%i5) boundaries_array[1143];
(%o5) @{Array:  
       #(91.659554 27.76511 91.666924 27.88888 91.65831 27.94805 
         91.338028 28.05249 91.314972 28.096661 91.108856 27.971109
         91.015808 27.97777 90.896927 28.05055 90.382462 28.07972
         90.396088 28.23555 90.366074 28.257771 89.996353 28.32333
         89.83165 28.24888 89.58609 28.139999 89.35997 27.87166 
         89.225517 27.795 89.125793 27.56749 88.971077 27.47361
         88.917877 27.321039)@}
(%i6) Bhutan_polygon: make_polygon([171,173,1143])$
(%i7) draw2d(Bhutan_polygon)$
@end example
@figure{worldmap_make_polygon}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn





@anchor{region_boundaries}
@deffn  {Function} region_boundaries (@var{x1},@var{y1},@var{x2},@var{y2})
Detects polygonal segments of global variable @code{boundaries_array}
fully contained in the rectangle with vertices (@var{x1},@var{y1}) -upper left- 
and (@var{x2},@var{y2}) -bottom right-.

Example:

Returns segment numbers for plotting southern Italy.
@example
(%i1) load(worldmap)$
(%i2) region_boundaries(10.4,41.5,20.7,35.4);
(%o2)                [1846, 1863, 1864, 1881, 1888, 1894]
(%i3) draw2d(geomap(%))$
@end example
@figure{worldmap_region_boundaries}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn



@anchor{region_boundaries_plus}
@deffn  {Function} region_boundaries_plus (@var{x1},@var{y1},@var{x2},@var{y2})
Detects polygonal segments of global variable @code{boundaries_array}
containing at least one vertex in the rectangle defined by vertices (@var{x1},@var{y1})
-upper left- and (@var{x2},@var{y2}) -bottom right-.

Example:

@example
(%i1) load(worldmap)$
(%i2) region_boundaries_plus(10.4,41.5,20.7,35.4);
(%o2) [1060, 1062, 1076, 1835, 1839, 1844, 1846, 1858,
       1861, 1863, 1864, 1871, 1881, 1888, 1894, 1897]
(%i3) draw2d(geomap(%))$
@end example
@figure{worldmap_region_boundaries_plus}

@opencatbox
@category{Package draw}
@closecatbox

@end deffn




@subsection Graphic objects


@anchor{geomap}
@deffn  {Graphic object} geomap @
@fname{geomap} (@var{numlist}) @
@fname{geomap} (@var{numlist},@var{3Dprojection})

Draws cartographic maps in 2D and 3D.

@b{2D}

This function works together with global variable @code{boundaries_array}.

Argument @var{numlist} is a list containing numbers or lists of numbers.
All these numbers must be integers greater or equal than zero, 
representing the components of global array @code{boundaries_array}.

Each component of @code{boundaries_array} is an array of floating
point quantities, the coordinates of a polygonal segment or map boundary.

@code{geomap (@var{numlist})} flattens its arguments and draws the
associated boundaries in @code{boundaries_array}.

This object is affected by the following @i{graphic options}: @mrefcomma{line_width} 
@mref{line_type} and @code{color}.

Examples:

A simple map defined by hand:
@example
(%i1) load(worldmap)$
(%i2) /* Vertices of boundary #0: @{(1,1),(2,5),(4,3)@} */
   ( bnd0: make_array(flonum,6),
     bnd0[0]:1.0, bnd0[1]:1.0, bnd0[2]:2.0,
     bnd0[3]:5.0, bnd0[4]:4.0, bnd0[5]:3.0 )$
(%i3) /* Vertices of boundary #1: @{(4,3),(5,4),(6,4),(5,1)@} */
   ( bnd1: make_array(flonum,8),
     bnd1[0]:4.0, bnd1[1]:3.0, bnd1[2]:5.0, bnd1[3]:4.0,
     bnd1[4]:6.0, bnd1[5]:4.0, bnd1[6]:5.0, bnd1[7]:1.0)$
(%i4) /* Vertices of boundary #2: @{(5,1), (3,0), (1,1)@} */
   ( bnd2: make_array(flonum,6),
     bnd2[0]:5.0, bnd2[1]:1.0, bnd2[2]:3.0,
     bnd2[3]:0.0, bnd2[4]:1.0, bnd2[5]:1.0 )$
(%i5) /* Vertices of boundary #3: @{(1,1), (4,3)@} */
   ( bnd3: make_array(flonum,4),
     bnd3[0]:1.0, bnd3[1]:1.0, bnd3[2]:4.0, bnd3[3]:3.0)$
(%i6) /* Vertices of boundary #4: @{(4,3), (5,1)@} */
   ( bnd4: make_array(flonum,4),
     bnd4[0]:4.0, bnd4[1]:3.0, bnd4[2]:5.0, bnd4[3]:1.0)$
(%i7) /* Pack all together in boundaries_array */
   ( boundaries_array: make_array(any,5),
     boundaries_array[0]: bnd0, boundaries_array[1]: bnd1,
     boundaries_array[2]: bnd2, boundaries_array[3]: bnd3,
     boundaries_array[4]: bnd4 )$
(%i8) draw2d(geomap([0,1,2,3,4]))$
@end example
@figure{worldmap_geomap}

The auxiliary package @code{worldmap} sets the global variable
@code{boundaries_array} to real world boundaries in
(longitude, latitude) coordinates. These data are in the 
public domain and come from 
@c Link is dead, linked to archive.org. Does someone know a better Link?
@url{https://web.archive.org/web/20100310124019/http://www-cger.nies.go.jp/grid-e/gridtxt/grid19.html}.
Package @code{worldmap} defines also boundaries for countries,
continents and coastlines as lists with the necessary components of 
@code{boundaries_array} (see file @code{share/draw/worldmap.mac}
for more information). Package @code{worldmap} automatically loads 
package @code{worldmap}.
@example
(%i1) load(worldmap)$
(%i2) c1: gr2d(geomap([Canada,United_States,
                       Mexico,Cuba]))$
(%i3) c2: gr2d(geomap(Africa))$
(%i4) c3: gr2d(geomap([Oceania,China,Japan]))$
(%i5) c4: gr2d(geomap([France,Portugal,Spain,
                       Morocco,Western_Sahara]))$
(%i6) draw(columns  = 2,
           c1,c2,c3,c4)$
@end example
@figure{worldmap_geomap2}

Package @code{worldmap} is also useful for plotting
countries as polygons. In this case, graphic object
@code{geomap} is no longer necessary and the @code{polygon}
object is used instead. Since lists are now used and not
arrays, maps rendering will be slower. See also @mref{make_poly_country}
and @mref{make_poly_continent} to understand the following code.
@example
(%i1) load(worldmap)$
(%i2) mymap: append(
   [color      = white],  /* borders are white */
   [fill_color = red],             make_poly_country(Bolivia),
   [fill_color = cyan],            make_poly_country(Paraguay),
   [fill_color = green],           make_poly_country(Colombia),
   [fill_color = blue],            make_poly_country(Chile),
   [fill_color = "#23ab0f"],       make_poly_country(Brazil),
   [fill_color = goldenrod],       make_poly_country(Argentina),
   [fill_color = "midnight-blue"], make_poly_country(Uruguay))$
(%i3) apply(draw2d, mymap)$
@end example
@figure{worldmap_geomap3}


@b{3D}

@code{geomap (@var{numlist})} projects map boundaries on the sphere of radius 1
centered at (0,0,0). It is possible to change the sphere or the projection type
by using @code{geomap (@var{numlist},@var{3Dprojection})}.

Available 3D projections:

@itemize @bullet
@item
@code{[spherical_projection,@var{x},@var{y},@var{z},@var{r}]}: projects map boundaries on the sphere of
radius @var{r} centered at (@var{x},@var{y},@var{z}).
@example
(%i1) load(worldmap)$
(%i2) draw3d(geomap(Australia), /* default projection */
             geomap(Australia,
                    [spherical_projection,2,2,2,3]))$
@end example
@figure{worldmap_geomap4}

@item
@code{[cylindrical_projection,@var{x},@var{y},@var{z},@var{r},@var{rc}]}: re-projects spherical map boundaries on the cylinder of radius
@var{rc} and axis passing through the poles of the globe of radius @var{r} centered at (@var{x},@var{y},@var{z}).
@example
(%i1) load(worldmap)$
(%i2) draw3d(geomap([America_coastlines,Eurasia_coastlines],
                    [cylindrical_projection,2,2,2,3,4]))$
@end example
@figure{worldmap_geomap5}

@item
@code{[conic_projection,@var{x},@var{y},@var{z},@var{r},@var{alpha}]}: re-projects spherical map boundaries on the cones of angle @var{alpha},
with axis passing through the poles of the globe of radius @var{r} centered at (@var{x},@var{y},@var{z}). Both 
the northern and southern cones are tangent to sphere.
@example
(%i1) load(worldmap)$
(%i2) draw3d(geomap(World_coastlines,
                    [conic_projection,0,0,0,1,90]))$
@end example
@end itemize
@figure{worldmap_geomap6}

See also @url{http://riotorto.users.sf.net/gnuplot/geomap}
for more elaborated examples.

@opencatbox
@category{Package draw}
@closecatbox

@end deffn

