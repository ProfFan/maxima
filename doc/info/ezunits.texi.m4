@c -*- Mode: texinfo -*-
@menu
* Introduction to ezunits::
* Introduction to physical_constants::
* Functions and Variables for ezunits::
@end menu

@node Introduction to ezunits, Introduction to physical_constants, ezunits-pkg, ezunits-pkg
@section Introduction to ezunits

@code{ezunits} is a package for working with dimensional quantities,
including some functions for dimensional analysis.
@code{ezunits} can carry out arithmetic operations on dimensional quantities and unit conversions.
The built-in units include Systeme Internationale (SI) and US customary units,
and other units can be declared.
See also @mrefcomma{physical_constants} a collection of physical constants.

@code{load("ezunits")} loads this package.
@code{demo("ezunits")} displays several examples.
The convenience function @code{known_units} returns a list of
the built-in and user-declared units,
while @code{display_known_unit_conversions} displays
the set of known conversions in an easy-to-read format.

An expression @math{a ` b} represents a dimensional quantity,
with @code{a} indicating a nondimensional quantity and @code{b} indicating the dimensional units.
A symbol can be used as a unit without declaring it as such;
unit symbols need not have any special properties.
The quantity and unit of an expression @math{a ` b} can
be extracted by the @code{qty} and @code{units} functions, respectively.

A symbol may be declared to be a dimensional quantity,
with specified quantity or specified units or both.

An expression @math{a ` b `@w{}` c} converts from unit @code{b} to unit @code{c}.
@code{ezunits} has built-in conversions for SI base units,
SI derived units, and some non-SI units.
Unit conversions not already known to @code{ezunits} can be declared.
The unit conversions known to @code{ezunits} are specified by the
global variable @code{known_unit_conversions},
which comprises built-in and user-defined conversions.
Conversions for products, quotients, and powers of units are
derived from the set of known unit conversions.

As Maxima generally prefers exact numbers (integers or rationals)
to inexact (float or bigfloat),
so @code{ezunits} preserves exact numbers when they appear
in dimensional quantities.
All built-in unit conversions are expressed in terms of exact numbers;
inexact numbers in declared conversions are coerced to exact.

There is no preferred system for display of units;
input units are not converted to other units
unless conversion is explicitly indicated.
@code{ezunits} recognizes the prefixes m-, k-, M, and G-
(for milli-, kilo-, mega-, and giga-)
as applied to SI base units and SI derived units,
but such prefixes are applied only when indicated by an explicit conversion.

Arithmetic operations on dimensional quantities are carried out by
conventional rules for such operations.

@itemize
@item @math{(x ` a) * (y ` b)} is equal to @math{(x * y) ` (a * b)}.
@item @math{(x ` a) + (y ` a)} is equal to @math{(x + y) ` a}.
@item @math{(x ` a)^y} is equal to @math{x^y ` a^y} when @code{y} is nondimensional.
@end itemize

@code{ezunits} does not require that units in a sum have the same dimensions;
such terms are not added together, and no error is reported.

@code{ezunits} includes functions for elementary dimensional analysis,
namely the fundamental dimensions and fundamental units
of a dimensional quantity,
and computation of dimensionless quantities and natural units.
The functions for dimensional analysis were adapted from similar
functions in another package, written by Barton Willis.

For the purpose of dimensional analysis,
a list of fundamental dimensions and an associated list of fundamental units
are maintained;
by default the fundamental dimensions are
length, mass, time, charge, temperature, and quantity,
and the fundamental units are the associated SI units,
but other fundamental dimensions and units can be declared.

@opencatbox
@category{Physical units} @category{Share packages} @category{Package ezunits}
@closecatbox

@node Introduction to physical_constants, Functions and Variables for ezunits, Introduction to ezunits, ezunits-pkg
@section Introduction to physical_constants

@anchor{physical_constants}
@code{physical_constants} is a collection of physical constants,
copied from CODATA 2006 recommended values
(@url{http://physics.nist.gov/constants}).
@code{load ("physical_constants")} loads this package,
and loads @code{ezunits} also, if it is not already loaded.

A physical constant is represented as a symbol which has a property
which is the constant value.
The constant value is a dimensional quantity, as represented by @code{ezunits}.
The function @code{constvalue} fetches the constant value;
the constant value is not the ordinary value of the symbol,
so symbols of physical constants persist in evaluated expressions until their
values are fetched by @code{constvalue}.

@code{physical_constants} includes some auxiliary information,
namely, a description string for each constant,
an estimate of the error of its numerical value,
and a property for TeX display.
To identify physical constants, each symbol has the
@code{physical_constant} property;
@code{propvars(physical_constant)} therefore shows the list
of all such symbols.

@code{physical_constants} comprises the following constants.

@table @code
@item %c
speed of light in vacuum
@item %mu_0
magnetic constant
@item %e_0
electric constant
@item %Z_0
characteristic impedance of vacuum
@item %G
Newtonian constant of gravitation
@item %h
Planck constant
@item %h_bar
Planck constant
@item %m_P
Planck mass
@item %T_P
Planck temperature
@item %l_P
Planck length
@item %t_P
Planck time
@item %%e
elementary charge
@item %Phi_0
magnetic flux quantum
@item %G_0
conductance quantum
@item %K_J
Josephson constant
@item %R_K
von Klitzing constant
@item %mu_B
Bohr magneton
@item %mu_N
nuclear magneton
@item %alpha
fine-structure constant
@item %R_inf
Rydberg constant
@item %a_0
Bohr radius
@item %E_h
Hartree energy
@item %ratio_h_me
quantum of circulation
@item %m_e
electron mass
@item %N_A
Avogadro constant
@item %m_u
atomic mass constant
@item %F
Faraday constant
@item %R
molar gas constant
@item %%k
Boltzmann constant
@item %V_m
molar volume of ideal gas
@item %n_0
Loschmidt constant
@item %ratio_S0_R
Sackur-Tetrode constant (absolute entropy constant)
@item %sigma
Stefan-Boltzmann constant
@item %c_1
first radiation constant
@item %c_1L
first radiation constant for spectral radiance
@item %c_2
second radiation constant
@item %b
Wien displacement law constant
@item %b_prime
Wien displacement law constant
@end table

Reference: @url{http://physics.nist.gov/constants}

Examples:

The list of all symbols which have the @code{physical_constant} property.

@c ===beg===
@c load ("physical_constants")$
@c propvars (physical_constant);
@c ===end===
@example
(%i1) load ("physical_constants")$
(%i2) propvars (physical_constant);
(%o2) [%c, %mu_0, %e_0, %Z_0, %G, %h, %h_bar, %m_P, %T_P, %l_P, 
%t_P, %%e, %Phi_0, %G_0, %K_J, %R_K, %mu_B, %mu_N, %alpha, 
%R_inf, %a_0, %E_h, %ratio_h_me, %m_e, %N_A, %m_u, %F, %R, %%k, 
%V_m, %n_0, %ratio_S0_R, %sigma, %c_1, %c_1L, %c_2, %b, %b_prime]
@end example

Properties of the physical constant @code{%c}.

@c ===beg===
@c load ("physical_constants")$
@c constantp (%c);
@c get (%c, description);
@c constvalue (%c);
@c get (%c, RSU);
@c tex (%c);
@c ===end===
@example
(%i1) load ("physical_constants")$
(%i2) constantp (%c);
(%o2)                         true
(%i3) get (%c, description);
(%o3)               speed of light in vacuum
(%i4) constvalue (%c);
                                      m
(%o4)                     299792458 ` -
                                      s
(%i5) get (%c, RSU);
(%o5)                           0
(%i6) tex (%c);
$$c$$
(%o6)                         false
@end example

The energy equivalent of 1 pound-mass.
The symbol @code{%c} persists until its value is fetched by @code{constvalue}.

@c ===beg===
@c load ("physical_constants")$
@c m * %c^2;
@c %, m = 1 ` lbm;
@c constvalue (%);
@c E : % `` J;
@c E `` GJ;
@c float (%);
@c ===end===
@example
(%i1) load ("physical_constants")$
(%i2) m * %c^2;
                                2
(%o2)                         %c  m
(%i3) %, m = 1 ` lbm;
                              2
(%o3)                       %c  ` lbm
(%i4) constvalue (%);
                                            2
                                       lbm m
(%o4)              89875517873681764 ` ------
                                          2
                                         s
(%i5) E : % `` J;
Computing conversions to base units; may take a moment. 
                     366838848464007200
(%o5)                ------------------ ` J
                             9
(%i6) E `` GJ;
                      458548560580009
(%o6)                 --------------- ` GJ
                         11250000
(%i7) float (%);
(%o7)              4.0759872051556356e+7 ` GJ
@end example

@opencatbox
@category{Physical units} @category{Share packages} @category{Package physical_constants}
@closecatbox

@node Functions and Variables for ezunits, , Introduction to physical_constants, ezunits-pkg
@section Functions and Variables for ezunits

@deffn {Operator} `

The dimensional quantity operator.
An expression @math{a ` b} represents a dimensional quantity,
with @code{a} indicating a nondimensional quantity and @code{b} indicating the dimensional units.
A symbol can be used as a unit without declaring it as such;
unit symbols need not have any special properties.
The quantity and unit of an expression @math{a ` b} can
be extracted by the @code{qty} and @code{units} functions, respectively.

Arithmetic operations on dimensional quantities are carried out by
conventional rules for such operations.

@itemize
@item @math{(x ` a) * (y ` b)} is equal to @math{(x * y) ` (a * b)}.
@item @math{(x ` a) + (y ` a)} is equal to @math{(x + y) ` a}.
@item @math{(x ` a)^y} is equal to @math{x^y ` a^y} when @code{y} is nondimensional.
@end itemize

@code{ezunits} does not require that units in a sum have the same dimensions;
such terms are not added together, and no error is reported.

@code{load ("ezunits")} enables this operator.

Examples:

SI (Systeme Internationale) units.

@c ===beg===
@c load ("ezunits")$
@c foo : 10 ` m;
@c qty (foo);
@c units (foo);
@c dimensions (foo);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) foo : 10 ` m;
(%o2)                        10 ` m
(%i3) qty (foo);
(%o3)                          10
(%i4) units (foo);
(%o4)                           m
(%i5) dimensions (foo);
(%o5)                        length
@end example

"Customary" units.

@c ===beg===
@c load ("ezunits")$
@c bar : x ` acre;
@c dimensions (bar);
@c fundamental_units (bar);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) bar : x ` acre;
(%o2)                       x ` acre
(%i3) dimensions (bar);
                                   2
(%o3)                        length
(%i4) fundamental_units (bar);
                                2
(%o4)                          m
@end example

Units ad hoc.

@c ===beg===
@c load ("ezunits")$
@c baz : 3 ` sheep + 8 ` goat + 1 ` horse;
@c subst ([sheep = 3*goat, horse = 10*goat], baz);
@c baz2 : 1000`gallon/fortnight;
@c subst (fortnight = 14*day, baz2);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) baz : 3 ` sheep + 8 ` goat + 1 ` horse;
(%o2)           8 ` goat + 3 ` sheep + 1 ` horse
(%i3) subst ([sheep = 3*goat, horse = 10*goat], baz);
(%o3)                       27 ` goat
(%i4) baz2 : 1000`gallon/fortnight;
                                gallon
(%o4)                   1000 ` ---------
                               fortnight
(%i5) subst (fortnight = 14*day, baz2);
                          500   gallon
(%o5)                     --- ` ------
                           7     day
@end example

Arithmetic operations on dimensional quantities.

@c ===beg===
@c load ("ezunits")$
@c 100 ` kg + 200 ` kg;
@c 100 ` m^3 - 100 ` m^3;
@c (10 ` kg) * (17 ` m/s^2);
@c (x ` m) / (y ` s);
@c (a ` m)^2;
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) 100 ` kg + 200 ` kg;
(%o2)                       300 ` kg
(%i3) 100 ` m^3 - 100 ` m^3;
                                  3
(%o3)                        0 ` m
(%i4) (10 ` kg) * (17 ` m/s^2);
                                 kg m
(%o4)                      170 ` ----
                                   2
                                  s
(%i5) (x ` m) / (y ` s);
                              x   m
(%o5)                         - ` -
                              y   s
(%i6) (a ` m)^2;
                              2    2
(%o6)                        a  ` m
@end example

@opencatbox
@category{Package ezunits}
@closecatbox

@end deffn

@deffn {Operator} `@w{}`

The unit conversion operator.
An expression @math{a ` b `@w{}` c} converts from unit @code{b} to unit @code{c}.
@code{ezunits} has built-in conversions for SI base units,
SI derived units, and some non-SI units.
Unit conversions not already known to @code{ezunits} can be declared.
The unit conversions known to @code{ezunits} are specified by the
global variable @code{known_unit_conversions},
which comprises built-in and user-defined conversions.
Conversions for products, quotients, and powers of units are
derived from the set of known unit conversions.

There is no preferred system for display of units;
input units are not converted to other units
unless conversion is explicitly indicated.
@code{ezunits} does not attempt to simplify units by prefixes
(milli-, centi-, deci-, etc)
unless such conversion is explicitly indicated.

@code{load ("ezunits")} enables this operator.

Examples:

The set of known unit conversions.

@c ===beg===
@c load ("ezunits")$
@c display2d : false$
@c known_unit_conversions;
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) display2d : false$
(%i3) known_unit_conversions;
(%o3) @{acre = 4840*yard^2,Btu = 1055*J,cfm = feet^3/minute,
       cm = m/100,day = 86400*s,feet = 381*m/1250,ft = feet,
       g = kg/1000,gallon = 757*l/200,GHz = 1000000000*Hz,
       GOhm = 1000000000*Ohm,GPa = 1000000000*Pa,
       GWb = 1000000000*Wb,Gg = 1000000*kg,Gm = 1000000000*m,
       Gmol = 1000000*mol,Gs = 1000000000*s,ha = hectare,
       hectare = 100*m^2,hour = 3600*s,Hz = 1/s,inch = feet/12,
       km = 1000*m,kmol = 1000*mol,ks = 1000*s,l = liter,
       lbf = pound_force,lbm = pound_mass,liter = m^3/1000,
       metric_ton = Mg,mg = kg/1000000,MHz = 1000000*Hz,
       microgram = kg/1000000000,micrometer = m/1000000,
       micron = micrometer,microsecond = s/1000000,
       mile = 5280*feet,minute = 60*s,mm = m/1000,
       mmol = mol/1000,month = 2629800*s,MOhm = 1000000*Ohm,
       MPa = 1000000*Pa,ms = s/1000,MWb = 1000000*Wb,
       Mg = 1000*kg,Mm = 1000000*m,Mmol = 1000000000*mol,
       Ms = 1000000*s,ns = s/1000000000,ounce = pound_mass/16,
       oz = ounce,Ohm = s*J/C^2,
       pound_force = 32*ft*pound_mass/s^2,
       pound_mass = 200*kg/441,psi = pound_force/inch^2,
       Pa = N/m^2,week = 604800*s,Wb = J/A,yard = 3*feet,
       year = 31557600*s,C = s*A,F = C^2/J,GA = 1000000000*A,
       GC = 1000000000*C,GF = 1000000000*F,GH = 1000000000*H,
       GJ = 1000000000*J,GK = 1000000000*K,GN = 1000000000*N,
       GS = 1000000000*S,GT = 1000000000*T,GV = 1000000000*V,
       GW = 1000000000*W,H = J/A^2,J = m*N,kA = 1000*A,
       kC = 1000*C,kF = 1000*F,kH = 1000*H,kHz = 1000*Hz,
       kJ = 1000*J,kK = 1000*K,kN = 1000*N,kOhm = 1000*Ohm,
       kPa = 1000*Pa,kS = 1000*S,kT = 1000*T,kV = 1000*V,
       kW = 1000*W,kWb = 1000*Wb,mA = A/1000,mC = C/1000,
       mF = F/1000,mH = H/1000,mHz = Hz/1000,mJ = J/1000,
       mK = K/1000,mN = N/1000,mOhm = Ohm/1000,mPa = Pa/1000,
       mS = S/1000,mT = T/1000,mV = V/1000,mW = W/1000,
       mWb = Wb/1000,MA = 1000000*A,MC = 1000000*C,
       MF = 1000000*F,MH = 1000000*H,MJ = 1000000*J,
       MK = 1000000*K,MN = 1000000*N,MS = 1000000*S,
       MT = 1000000*T,MV = 1000000*V,MW = 1000000*W,
       N = kg*m/s^2,R = 5*K/9,S = 1/Ohm,T = J/(m^2*A),V = J/C,
       W = J/s@}
@end example

Elementary unit conversions.

@c ===beg===
@c load ("ezunits")$
@c 1 ` ft `` m;
@c %, numer; 
@c 1 ` kg `` lbm; 
@c %, numer;
@c 1 ` W `` Btu/hour;
@c %, numer;
@c 100 ` degC `` degF;
@c -40 ` degF `` degC;
@c 1 ` acre*ft `` m^3;
@c %, numer;
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) 1 ` ft `` m;
Computing conversions to base units; may take a moment. 
                            381
(%o2)                       ---- ` m
                            1250
(%i3) %, numer;
(%o3)                      0.3048 ` m
(%i4) 1 ` kg `` lbm;
                            441
(%o4)                       --- ` lbm
                            200
(%i5) %, numer;
(%o5)                      2.205 ` lbm
(%i6) 1 ` W `` Btu/hour;
                           720   Btu
(%o6)                      --- ` ----
                           211   hour
(%i7) %, numer;
                                        Btu
(%o7)               3.412322274881517 ` ----
                                        hour
(%i8) 100 ` degC `` degF;
(%o8)                      212 ` degF
(%i9) -40 ` degF `` degC;
(%o9)                     (- 40) ` degC
(%i10) 1 ` acre*ft `` m^3;
                        60228605349    3
(%o10)                  ----------- ` m
                         48828125
(%i11) %, numer;
                                          3
(%o11)                1233.48183754752 ` m
@end example

Coercing quantities in feet and meters to one or the other.

@c ===beg===
@c load ("ezunits")$
@c 100 ` m + 100 ` ft;
@c (100 ` m + 100 ` ft) `` ft;
@c %, numer;
@c (100 ` m + 100 ` ft) `` m;
@c %, numer;
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) 100 ` m + 100 ` ft;
(%o2)                  100 ` m + 100 ` ft
(%i3) (100 ` m + 100 ` ft) `` ft;
Computing conversions to base units; may take a moment. 
                           163100
(%o3)                      ------ ` ft
                            381
(%i4) %, numer;
(%o4)                428.0839895013123 ` ft
(%i5) (100 ` m + 100 ` ft) `` m;
                            3262
(%o5)                       ---- ` m
                             25
(%i6) %, numer;
(%o6)                      130.48 ` m
@end example

Dimensional analysis to find fundamental dimensions and fundamental units.

@c ===beg===
@c load ("ezunits")$
@c foo : 1 ` acre * ft;
@c dimensions (foo);
@c fundamental_units (foo);
@c foo `` m^3;
@c %, numer;
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) foo : 1 ` acre * ft;
(%o2)                      1 ` acre ft
(%i3) dimensions (foo);
                                   3
(%o3)                        length
(%i4) fundamental_units (foo);
                                3
(%o4)                          m
(%i5) foo `` m^3;
Computing conversions to base units; may take a moment. 
                        60228605349    3
(%o5)                   ----------- ` m
                         48828125
(%i6) %, numer;
                                          3
(%o6)                 1233.48183754752 ` m
@end example

Declared unit conversions.

@c ===beg===
@c load ("ezunits")$
@c declare_unit_conversion (MMBtu = 10^6*Btu, kW = 1000*W);
@c declare_unit_conversion (kWh = kW*hour, MWh = 1000*kWh, 
@c                          bell = 1800*s);
@c 1 ` kW*s `` MWh;
@c 1 ` kW/m^2 `` MMBtu/bell/ft^2;
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) declare_unit_conversion (MMBtu = 10^6*Btu, kW = 1000*W);
(%o2)                         done
(%i3) declare_unit_conversion (kWh = kW*hour, MWh = 1000*kWh,
                               bell = 1800*s);
(%o3)                         done
(%i4) 1 ` kW*s `` MWh;
Computing conversions to base units; may take a moment. 
                             1
(%o4)                     ------- ` MWh
                          3600000
(%i5) 1 ` kW/m^2 `` MMBtu/bell/ft^2;
                       1306449      MMBtu
(%o5)                 ---------- ` --------
                      8242187500          2
                                   bell ft
@end example

@opencatbox
@category{Package ezunits}
@closecatbox

@end deffn

@anchor{constvalue}
@deffn {Function} constvalue (@var{x})

Shows the value and the units of one of the constants declared by package
@code{physical_constants}, which includes a list of physical constants, or
of a new constant declared in package @code{ezunits} (see
@mref{declare_constvalue}).

Note that constant values as recognized by @code{constvalue}
are separate from values declared by @code{numerval} and
recognized by @code{constantp}.

Example:

@c ===beg===
@c load ("physical_constants")$
@c constvalue (%G);
@c get ('%G, 'description);
@c ===end===
@example
(%i1) load ("physical_constants")$
(%i2) constvalue (%G);
                                     3
                                    m
(%o2)                    6.67428 ` -----
                                       2
                                   kg s
(%i3) get ('%G, 'description);
(%o3)           Newtonian constant of gravitation
@end example

@opencatbox
@category{Package ezunits}
@closecatbox
@end deffn

@anchor{declare_constvalue}
@deffn {Function} declare_constvalue (@var{a}, @var{x})

Declares the value of a constant to be used in package @code{ezunits}. This
function should be loaded with @code{load ("ezunits")}. 

Example:

@c ===beg===
@c load ("ezunits")$
@c declare_constvalue (FOO, 100 ` lbm / acre);
@c FOO * (50 ` acre);
@c constvalue (%);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) declare_constvalue (FOO, 100 ` lbm / acre);
                                 lbm
(%o2)                      100 ` ----
                                 acre
(%i3) FOO * (50 ` acre);
(%o3)                     50 FOO ` acre
(%i4) constvalue (%);
(%o4)                      5000 ` lbm
@end example

@opencatbox
@category{Package ezunits}
@closecatbox
@end deffn

@anchor{remove_constvalue}
@deffn {Function} remove_constvalue (@var{a})

Reverts the effect of @mrefdot{declare_constvalue} This function should be
loaded with @code{load ("ezunits")}.

@opencatbox
@category{Package ezunits}
@closecatbox
@end deffn

@anchor{units}
@deffn {Function} units (@var{x})

Returns the units of a dimensional quantity @var{x},
or returns 1 if @var{x} is nondimensional.

@var{x} may be a literal dimensional expression @math{a ` b},
a symbol with declared units via @code{declare_units}, 
or an expression containing either or both of those.

This function should be loaded with @code{load ("ezunits")}.

Example:

@c ===beg===
@c load ("ezunits")$
@c foo : 100 ` kg;
@c bar : x ` m/s;
@c units (foo);
@c units (bar);
@c units (foo * bar);
@c units (foo / bar);
@c units (foo^2);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) foo : 100 ` kg;
(%o2)                       100 ` kg
(%i3) bar : x ` m/s;
                                  m
(%o3)                         x ` -
                                  s
(%i4) units (foo);
(%o4)                          kg
(%i5) units (bar);
                                m
(%o5)                           -
                                s
(%i6) units (foo * bar);
                              kg m
(%o6)                         ----
                               s
(%i7) units (foo / bar);
                              kg s
(%o7)                         ----
                               m
(%i8) units (foo^2);
                                 2
(%o8)                          kg
@end example

@opencatbox
@category{Package ezunits}
@closecatbox
@end deffn

@anchor{declare_units}
@deffn {Function} declare_units (@var{a}, @var{u})

Declares that @mref{units} should return units @var{u} for @var{a},
where @var{u} is an expression. This function should be loaded with
@code{load ("ezunits")}.

Example:

@c ===beg===
@c load ("ezunits")$
@c units (aa);
@c declare_units (aa, J);
@c units (aa);
@c units (aa^2);
@c foo : 100 ` kg;
@c units (aa * foo);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) units (aa);
(%o2)                           1
(%i3) declare_units (aa, J);
(%o3)                           J
(%i4) units (aa);
(%o4)                           J
(%i5) units (aa^2);
                                2
(%o5)                          J
(%i6) foo : 100 ` kg;
(%o6)                       100 ` kg
(%i7) units (aa * foo);
(%o7)                         kg J
@end example

@opencatbox
@category{Package ezunits}
@closecatbox
@end deffn

@anchor{qty}
@deffn {Function} qty (@var{x})

Returns the nondimensional part of a dimensional quantity @var{x},
or returns @var{x} if @var{x} is nondimensional.
@var{x} may be a literal dimensional expression @math{a ` b},
a symbol with declared quantity, 
or an expression containing either or both of those.

This function should be loaded with @code{load ("ezunits")}.

Example:

@c ===beg===
@c load ("ezunits")$
@c foo : 100 ` kg;
@c qty (foo);
@c bar : v ` m/s;
@c foo * bar;
@c qty (foo * bar);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) foo : 100 ` kg;
(%o2)                       100 ` kg
(%i3) qty (foo);
(%o3)                          100
(%i4) bar : v ` m/s;
                                  m
(%o4)                         v ` -
                                  s
(%i5) foo * bar;
                                  kg m
(%o5)                     100 v ` ----
                                   s
(%i6) qty (foo * bar);
(%o6)                         100 v
@end example

@opencatbox
@category{Package ezunits}
@closecatbox
@end deffn

@anchor{declare_qty}
@deffn {Function} declare_qty (@var{a}, @var{x})

Declares that @mref{qty} should return @var{x} for symbol @var{a}, where
@var{x} is a nondimensional quantity. This function should be loaded
with @code{load ("ezunits")}.

Example:

@c ===beg===
@c load ("ezunits")$
@c declare_qty (aa, xx);
@c qty (aa);
@c qty (aa^2);
@c foo : 100 ` kg;
@c qty (aa * foo);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) declare_qty (aa, xx);
(%o2)                          xx
(%i3) qty (aa);
(%o3)                          xx
(%i4) qty (aa^2);
                                 2
(%o4)                          xx
(%i5) foo : 100 ` kg;
(%o5)                       100 ` kg
(%i6) qty (aa * foo);
(%o6)                        100 xx
@end example

@opencatbox
@category{Package ezunits}
@closecatbox
@end deffn

@c PROBABLY SHOULD RENAME THIS TO DIMENSIONALP !!
@anchor{unitp}
@deffn {Function} unitp (@var{x})

Returns @code{true} if @var{x} is a literal dimensional expression,
a symbol declared dimensional,
or an expression in which the main operator is declared dimensional.
@code{unitp} returns @code{false} otherwise.

@code{load ("ezunits")} loads this function.

Examples:

@code{unitp} applied to a literal dimensional expression.

@c ===beg===
@c load ("ezunits")$
@c unitp (100 ` kg);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) unitp (100 ` kg);
(%o2)                         true
@end example

@code{unitp} applied to a symbol declared dimensional.

@c ===beg===
@c load ("ezunits")$
@c unitp (foo);
@c declare (foo, dimensional);
@c unitp (foo);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) unitp (foo);
(%o2)                         false
(%i3) declare (foo, dimensional);
(%o3)                         done
(%i4) unitp (foo);
(%o4)                         true
@end example

@code{unitp} applied to an expression in which the main operator is declared dimensional.

@c ===beg===
@c load ("ezunits")$
@c unitp (bar (x, y, z));
@c declare (bar, dimensional);
@c unitp (bar (x, y, z));
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) unitp (bar (x, y, z));
(%o2)                         false
(%i3) declare (bar, dimensional);
(%o3)                         done
(%i4) unitp (bar (x, y, z));
(%o4)                         true
@end example

@opencatbox
@category{Package ezunits}
@closecatbox

@end deffn

@anchor{declare_unit_conversion}
@deffn {Function} declare_unit_conversion (@var{u} = @var{v}, ...)

Appends equations @var{u} = @var{v}, ... to the list of unit conversions
known to the unit conversion operator @math{`@w{}`}.
@var{u} and @var{v} are both multiplicative terms,
in which any variables are units,
or both literal dimensional expressions.

At present, it is necessary to express conversions such that
the left-hand side of each equation is a simple unit
(not a multiplicative expression)
or a literal dimensional expression with the quantity equal to 1
and the unit being a simple unit.
This limitation might be relaxed in future versions.

@code{known_unit_conversions} is the list of known unit conversions.

This function should be loaded with @code{load ("ezunits")}.

Examples:

Unit conversions expressed by equations of multiplicative terms.

@c ===beg===
@c load ("ezunits")$
@c declare_unit_conversion (nautical_mile = 1852 * m, 
@c                          fortnight = 14 * day);
@c 100 ` nautical_mile / fortnight `` m/s;
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) declare_unit_conversion (nautical_mile = 1852 * m,
                               fortnight = 14 * day);
(%o2)                         done
(%i3) 100 ` nautical_mile / fortnight `` m/s;
Computing conversions to base units; may take a moment. 
                            463    m
(%o3)                       ---- ` -
                            3024   s
@end example

Unit conversions expressed by equations of literal dimensional expressions.

@c ===beg===
@c load ("ezunits")$
@c declare_unit_conversion (1 ` fluid_ounce = 2 ` tablespoon);
@c declare_unit_conversion (1 ` tablespoon = 3 ` teaspoon);
@c 15 ` fluid_ounce `` teaspoon;
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) declare_unit_conversion (1 ` fluid_ounce = 2 ` tablespoon);
(%o2)                         done
(%i3) declare_unit_conversion (1 ` tablespoon = 3 ` teaspoon);
(%o3)                         done
(%i4) 15 ` fluid_ounce `` teaspoon;
Computing conversions to base units; may take a moment. 
(%o4)                     90 ` teaspoon
@end example

@opencatbox
@category{Package ezunits}
@closecatbox

@end deffn

@anchor{declare_dimensions}
@deffn {Function} declare_dimensions (@var{a_1}, @var{d_1}, ..., @var{a_n}, @var{d_n})

Declares @var{a_1}, ..., @var{a_n} to have dimensions @var{d_1}, ...,
@var{d_n}, respectively.

Each @var{a_k} is a symbol or a list of symbols.
If it is a list, then every symbol in @var{a_k} is declared to have dimension @var{d_k}.

@code{load ("ezunits")} loads these functions.

Examples:

@c ===beg===
@c load ("ezunits") $
@c declare_dimensions ([x, y, z], length, [t, u], time);
@c dimensions (y^2/u);
@c fundamental_units (y^2/u);
@c ===end===
@example
(%i1) load ("ezunits") $
(%i2) declare_dimensions ([x, y, z], length, [t, u], time);
(%o2)                         done
(%i3) dimensions (y^2/u);
                                   2
                             length
(%o3)                        -------
                              time
(%i4) fundamental_units (y^2/u);
0 errors, 0 warnings
                                2
                               m
(%o4)                          --
                               s
@end example

@opencatbox
@category{Package ezunits}
@closecatbox
@end deffn

@anchor{remove_dimensions}
@deffn {Function} remove_dimensions (@var{a_1}, ..., @var{a_n})

Reverts the effect of @code{declare_dimensions}. This function should be
loaded with @code{load ("ezunits")}.


@opencatbox
@category{Package ezunits}
@closecatbox
@end deffn

@anchor{declare_fundamental_dimensions}
@deffn {Function} declare_fundamental_dimensions (@var{d_1}, @var{d_2}, @var{d_3}, ...)
@deffnx {Function} remove_fundamental_dimensions (@var{d_1}, @var{d_2}, @var{d_3}, ...)
@deffnx {Global variable} fundamental_dimensions

@code{declare_fundamental_dimensions} declares fundamental dimensions.
Symbols @var{d_1}, @var{d_2}, @var{d_3}, ... are appended to the list of
fundamental dimensions, if they are not already on the list.

@code{remove_fundamental_dimensions} reverts the effect of @code{declare_fundamental_dimensions}.

@code{fundamental_dimensions} is the list of fundamental dimensions.
By default, the list comprises several physical dimensions.

@code{load ("ezunits")} loads these functions.

Examples:

@c ===beg===
@c load ("ezunits") $
@c fundamental_dimensions;
@c declare_fundamental_dimensions (money, cattle, happiness);
@c fundamental_dimensions;
@c remove_fundamental_dimensions (cattle, happiness);
@c fundamental_dimensions;
@c ===end===
@example
(%i1) load ("ezunits") $
(%i2) fundamental_dimensions;
(%o2) [length, mass, time, current, temperature, quantity]
(%i3) declare_fundamental_dimensions (money, cattle, happiness);
(%o3)                         done
(%i4) fundamental_dimensions;
(%o4) [length, mass, time, current, temperature, quantity, 
                                        money, cattle, happiness]
(%i5) remove_fundamental_dimensions (cattle, happiness);
(%o5)                         done
(%i6) fundamental_dimensions;
(%o6) [length, mass, time, current, temperature, quantity, money]
@end example

@opencatbox
@category{Package ezunits}
@closecatbox

@end deffn

@anchor{declare_fundamental_units}
@deffn {Function} declare_fundamental_units (@var{u_1}, @var{d_1}, ..., @var{u_n}, @var{d_n})
@deffnx {Function} remove_fundamental_units (@var{u_1}, ..., @var{u_n})

@code{declare_fundamental_units} declares @var{u_1}, ..., @var{u_n}
to have dimensions @var{d_1}, ..., @var{d_n}, respectively.
All arguments must be symbols.

After calling @code{declare_fundamental_units},
@code{dimensions(@var{u_k})} returns @var{d_k} for each argument @var{u_1}, ..., @var{u_n},
and @code{fundamental_units(@var{d_k})} returns @var{u_k} for each argument @var{d_1}, ..., @var{d_n}.

@code{remove_fundamental_units} reverts the effect of @code{declare_fundamental_units}.

@code{load ("ezunits")} loads these functions.

Examples:

@c ===beg===
@c load ("ezunits") $
@c declare_fundamental_dimensions (money, cattle, happiness);
@c declare_fundamental_units (dollar, money, goat, cattle,
@c                            smile, happiness);
@c dimensions (100 ` dollar/goat/km^2);
@c dimensions (x ` smile/kg);
@c fundamental_units (money*cattle/happiness);
@c ===end===
@example
(%i1) load ("ezunits") $
(%i2) declare_fundamental_dimensions (money, cattle, happiness);
(%o2)                         done
(%i3) declare_fundamental_units (dollar, money, goat, cattle,
                                 smile, happiness);
(%o3)                 [dollar, goat, smile]
(%i4) dimensions (100 ` dollar/goat/km^2);
                             money
(%o4)                    --------------
                                      2
                         cattle length
(%i5) dimensions (x ` smile/kg);
                            happiness
(%o5)                       ---------
                              mass
(%i6) fundamental_units (money*cattle/happiness);
0 errors, 0 warnings
                           dollar goat
(%o6)                      -----------
                              smile
@end example

@opencatbox
@category{Package ezunits}
@closecatbox

@end deffn

@anchor{dimensions}
@deffn {Function} dimensions (@var{x})
@deffnx {Function} dimensions_as_list (@var{x})

@code{dimensions} returns the dimensions of the dimensional quantity @var{x}
as an expression comprising products and powers of base dimensions.

@code{dimensions_as_list} returns the dimensions of the dimensional quantity @var{x}
as a list, in which each element is an integer which indicates the power of the
corresponding base dimension in the dimensions of @var{x}.

@code{load ("ezunits")} loads these functions.

Examples:

@c ===beg===
@c load ("ezunits")$
@c dimensions (1000 ` kg*m^2/s^3);
@c declare_units (foo, acre*ft/hour);
@c dimensions (foo);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) dimensions (1000 ` kg*m^2/s^3);
                                2
                          length  mass
(%o2)                     ------------
                                 3
                             time
(%i3) declare_units (foo, acre*ft/hour);
                             acre ft
(%o3)                        -------
                              hour
(%i4) dimensions (foo);
                                   3
                             length
(%o4)                        -------
                              time
@end example

@c ===beg===
@c load ("ezunits")$
@c fundamental_dimensions;
@c dimensions_as_list (1000 ` kg*m^2/s^3);
@c declare_units (foo, acre*ft/hour);
@c dimensions_as_list (foo);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) fundamental_dimensions;
(%o2)  [length, mass, time, charge, temperature, quantity]
(%i3) dimensions_as_list (1000 ` kg*m^2/s^3);
(%o3)                 [2, 1, - 3, 0, 0, 0]
(%i4) declare_units (foo, acre*ft/hour);
                             acre ft
(%o4)                        -------
                              hour
(%i5) dimensions_as_list (foo);
(%o5)                 [3, 0, - 1, 0, 0, 0]
@end example

@opencatbox
@category{Package ezunits}
@closecatbox

@end deffn

@anchor{fundamental_units}
@deffn {Function} fundamental_units @
@fname{fundamental_units} (@var{x}) @
@fname{fundamental_units} ()

@code{fundamental_units(@var{x})} returns the units
associated with the fundamental dimensions of @var{x}.
as determined by @code{dimensions(@var{x})}.

@var{x} may be a literal dimensional expression @math{a ` b},
a symbol with declared units via @code{declare_units}, 
or an expression containing either or both of those.

@code{fundamental_units()} returns the list of all known fundamental units,
as declared by @code{declare_fundamental_units}.

@code{load ("ezunits")} loads this function.

Examples:

@c ===beg===
@c load ("ezunits")$
@c fundamental_units ();
@c fundamental_units (100 ` mile/hour);
@c declare_units (aa, g/foot^2);
@c fundamental_units (aa);
@c ===end===
@example
(%i1) load ("ezunits")$
(%i2) fundamental_units ();
(%o2)                 [m, kg, s, A, K, mol]
(%i3) fundamental_units (100 ` mile/hour);
                                m
(%o3)                           -
                                s
(%i4) declare_units (aa, g/foot^2);
                                g
(%o4)                         -----
                                  2
                              foot
(%i5) fundamental_units (aa);
                               kg
(%o5)                          --
                                2
                               m
@end example

@opencatbox
@category{Package ezunits}
@closecatbox

@end deffn

@anchor{dimensionless}
@deffn {Function} dimensionless (@var{L})

Returns a basis for the dimensionless quantities which can be formed
from a list @var{L} of dimensional quantities.

@code{load ("ezunits")} loads this function.

Examples:

@c ===beg===
@c load ("ezunits") $
@c dimensionless ([x ` m, y ` m/s, z ` s]);
@c ===end===
@example
(%i1) load ("ezunits") $
(%i2) dimensionless ([x ` m, y ` m/s, z ` s]);
0 errors, 0 warnings
0 errors, 0 warnings
                               y z
(%o2)                         [---]
                                x
@end example

Dimensionless quantities derived from fundamental physical quantities.
Note that the first element on the list
is proportional to the fine-structure constant.

@c ===beg===
@c load ("ezunits") $
@c load ("physical_constants") $
@c dimensionless([%h_bar, %m_e, %m_P, %%e, %c, %e_0]);
@c ===end===
@example
(%i1) load ("ezunits") $
(%i2) load ("physical_constants") $
(%i3) dimensionless([%h_bar, %m_e, %m_P, %%e, %c, %e_0]);
0 errors, 0 warnings
0 errors, 0 warnings
                              2
                           %%e        %m_e
(%o3)                [--------------, ----]
                      %c %e_0 %h_bar  %m_P
@end example

@opencatbox
@category{Package ezunits}
@closecatbox

@end deffn

@c NEED TO FILL IN !!
@anchor{natural_unit}
@deffn {Function} natural_unit (@var{expr}, [@var{v_1}, ..., @var{v_n}])

Finds exponents @var{e_1}, ..., @var{e_n} such that
@code{dimension(@var{expr}) = dimension(@var{v_1}^@var{e_1} ... @var{v_n}^@var{e_n})}.

@code{load ("ezunits")} loads this function.

Examples:

@c ===beg===
@c ===end===
@example
@end example

@opencatbox
@category{Package ezunits}
@closecatbox

@end deffn


