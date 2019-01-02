@c -*- Mode: texinfo -*-
@menu
* Functions and Variables for Groups::
@end menu

@node Functions and Variables for Groups,  , Groups, Groups
@section Functions and Variables for Groups

@anchor{todd_coxeter}
@deffn {Function} todd_coxeter @
@fname{todd_coxeter} (@var{relations}, @var{subgroup}) @
@fname{todd_coxeter} (@var{relations})

Find the order of G/H where G is the Free Group modulo @var{relations}, and
H is the subgroup of G generated by @var{subgroup}.  @var{subgroup} is an optional
argument, defaulting to [].  In doing this it produces a
multiplication table for the right action of G on G/H, where the
cosets are enumerated [H,Hg2,Hg3,...].  This can be seen internally in
the variable @code{todd_coxeter_state}.

Example:

@c ===beg===
@c symet(n):=create_list(
@c         if (j - i) = 1 then (p(i,j))^^3 else
@c             if (not i = j) then (p(i,j))^^2 else
@c                 p(i,i) , j, 1, n-1, i, 1, j);
@c p(i,j) := concat(x,i).concat(x,j);
@c symet(5);
@c todd_coxeter(%o3);
@c todd_coxeter(%o3,[x1]);
@c todd_coxeter(%o3,[x1,x2]);
@c ===end===
@example
(%i1) symet(n):=create_list(
        if (j - i) = 1 then (p(i,j))^^3 else
            if (not i = j) then (p(i,j))^^2 else
                p(i,i) , j, 1, n-1, i, 1, j);
                                                       <3>
(%o1) symet(n) := create_list(if j - i = 1 then p(i, j)

                                <2>
 else (if not i = j then p(i, j)    else p(i, i)), j, 1, n - 1,

i, 1, j)
(%i2) p(i,j) := concat(x,i).concat(x,j);
(%o2)        p(i, j) := concat(x, i) . concat(x, j)
(%i3) symet(5);
         <2>           <3>    <2>           <2>           <3>
(%o3) [x1   , (x1 . x2)   , x2   , (x1 . x3)   , (x2 . x3)   ,

            <2>           <2>           <2>           <3>    <2>
          x3   , (x1 . x4)   , (x2 . x4)   , (x3 . x4)   , x4   ]
(%i4) todd_coxeter(%o3);

Rows tried 426
(%o4)                          120
(%i5) todd_coxeter(%o3,[x1]);

Rows tried 213
(%o5)                          60
(%i6) todd_coxeter(%o3,[x1,x2]);

Rows tried 71
(%o6)                          20
@end example
@opencatbox
@category{Group theory}
@closecatbox
@end deffn
