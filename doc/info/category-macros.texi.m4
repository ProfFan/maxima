@c -*- Mode: texinfo -*-
@ifhtml
@macro fname {name}
@*@ @ @ @ @t{\name\}
@end macro
@end ifhtml
@iftex
@macro fname {name}
@*@t{\name\}
@end macro
@end iftex
@ifinfo
@macro fname {name}
@*\name\
@end macro
@end ifinfo

@ifhtml
@macro figure {file}
@image{figures/\file\}
@end macro
@end ifhtml
@iftex
@macro figure {file}
@center @image{figures/\file\, 10cm}
@end macro
@end iftex
@ifinfo
@macro figure {file}
(Figure \file\)
@end macro
@end ifinfo

@ifhtml
@macro opencatbox {}
@html
<div class=categorybox>
@end html
@end macro

@macro category {name}
@html
&middot;
@end html
@ref{Category: \name\}
@end macro

@macro closecatbox {}
@html
</div>
@end html
@end macro

@c Macros for cross references

@macro mref {nodename}
@code{@ref{\nodename\}}
@end macro

@macro mxref {nodename, text}
@code{@ref{\nodename\, \text\}}
@end macro

@macro mrefdot {nodename}
@code{@ref{\nodename\}}.
@end macro

@macro mxrefdot {nodename, text}
@code{@ref{\nodename\, \text\}}.
@end macro

@macro mrefcomma {nodename}
@code{@ref{\nodename\}},
@end macro

@macro mxrefcomma {nodename, text}
@code{@ref{\nodename\, \text\}},
@end macro

@macro mrefparen {nodename}
@code{@ref{\nodename\}})
@end macro

@end ifhtml

@c Non html versions of the macros

@ifnothtml

@macro opencatbox {}
@end macro

@macro category {name}
@end macro

@macro closecatbox {}
@end macro

@c Macros for cross references

@ifnottex
@macro mref {nodename}
@code{\nodename\}
@end macro

@macro mxref {nodename, text}
@code{\text\}
@end macro

@macro mrefdot {nodename}
@code{\nodename\}.
@end macro

@macro mxrefdot {nodename, text}
@code{\text\}.
@end macro

@macro mrefcomma {nodename}
@code{\nodename\},
@end macro

@macro mxrefcomma {nodename, text}
@code{\text\},
@end macro

@macro mrefparen {nodename}
@code{\nodename\})
@end macro
@end ifnottex
@iftex

@macro mref {nodename}
@code{@mmref{\nodename\}{\nodename\}}
@end macro

@macro mxref {nodename, text}
@code{@ref{\nodename\, \text\}}
@end macro

@macro mrefdot {nodename}
@code{@mmref{\nodename\}{\nodename\}}.
@end macro

@macro mxrefdot {nodename, text}
@code{@ref{\nodename\, \text\}}.
@end macro

@macro mrefcomma {nodename}
@code{@mmref{\nodename\}{\nodename\}},
@end macro

@macro mxrefcomma {nodename, text}
@code{@ref{\nodename\, \text\}},
@end macro

@macro mrefparen {nodename}
@code{@mmref{\nodename\}{\nodename\}})
@end macro

@end iftex
@end ifnothtml


@tex
\global\def\linkcolor{0 .5 0}
\global\def\urlcolor{0 0 .5}
@end tex
