@c -*- Mode: texinfo -*-
@menu
* Introduction to graphs::
* Functions and Variables for graphs::
@end menu

@node Introduction to graphs, Functions and Variables for graphs, graphs-pkg, graphs-pkg
@section Introduction to graphs

The @code{graphs} package provides graph and digraph data structure for
Maxima. Graphs and digraphs are simple (have no multiple edges nor
loops), although digraphs can have a directed edge from @var{u} to
@var{v} and a directed edge from @var{v} to @var{u}.

Internally graphs are represented by adjacency lists and implemented as
a lisp structures. Vertices are identified by their ids (an id is an
integer). Edges/arcs are represented by lists of length 2. Labels can be
assigned to vertices of graphs/digraphs and weights can be assigned to
edges/arcs of graphs/digraphs.

There is a @code{draw_graph} function for drawing graphs. Graphs are
drawn using a force based vertex positioning
algorithm. @code{draw_graph} can also use graphviz programs available
from @url{http://www.graphviz.org}. @code{draw_graph} is based on the maxima
@code{draw} package.

To use the @code{graphs} package, first load it with @code{load("graphs")}.

@opencatbox
@category{Share packages} @category{Package graphs}
@closecatbox

@node Functions and Variables for graphs, , Introduction to graphs, graphs-pkg
@section Functions and Variables for graphs

@subsection Building graphs

@anchor{create_graph}
@deffn {Function} create_graph @
@fname{create_graph} (@var{v_list}, @var{e_list}) @
@fname{create_graph} (@var{n}, @var{e_list}) @
@fname{create_graph} (@var{v_list}, @var{e_list}, @var{directed})

Creates a new graph on the set of vertices @var{v_list} and with edges @var{e_list}.

@var{v_list} is a list of vertices (@code{[v1, v2,..., vn]}) or a
list of vertices together with vertex labels (@code{[[v1,l1], [v2,l2],..., [vn,ln]]}).

@var{n} is the number of vertices. Vertices will be identified by integers from 0 to n-1.

@var{e_list} is a list of edges (@code{[e1, e2,..., em]}) or a list of
edges together with edge-weights (@code{[[e1, w1], ..., [em, wm]]}).

If @var{directed} is not @code{false}, a directed graph will be returned.

Example 1: create a cycle on 3 vertices:
@c ===beg===
@c load ("graphs")$
@c g : create_graph([1,2,3], [[1,2], [2,3], [1,3]])$
@c print_graph(g)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : create_graph([1,2,3], [[1,2], [2,3], [1,3]])$
(%i3) print_graph(g)$
Graph on 3 vertices with 3 edges.
Adjacencies:
  3 :  1  2
  2 :  3  1
  1 :  3  2
@end example

Example 2: create a cycle on 3 vertices with edge weights:
@c ===beg===
@c load ("graphs")$
@c g : create_graph([1,2,3], [[[1,2], 1.0], [[2,3], 2.0],
@c                           [[1,3], 3.0]])$
@c print_graph(g)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : create_graph([1,2,3], [[[1,2], 1.0], [[2,3], 2.0],
                          [[1,3], 3.0]])$
(%i3) print_graph(g)$
Graph on 3 vertices with 3 edges.
Adjacencies:
  3 :  1  2
  2 :  3  1
  1 :  3  2
@end example

Example 3: create a directed graph:
@c ===beg===
@c load ("graphs")$
@c d : create_graph(
@c         [1,2,3,4], 
@c         [
@c          [1,3], [1,4],
@c          [2,3], [2,4]
@c         ],
@c         'directed = true)$
@c print_graph(d)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) d : create_graph(
        [1,2,3,4],
        [
         [1,3], [1,4],
         [2,3], [2,4]
        ],
        'directed = true)$
(%i3) print_graph(d)$
Digraph on 4 vertices with 4 arcs.
Adjacencies:
  4 :
  3 :
  2 :  4  3
  1 :  4  3
@end example

@opencatbox
@category{Package graphs}
@closecatbox
@end deffn

@anchor{copy_graph}
@deffn {Function} copy_graph (@var{g})
Returns a copy of the graph @var{g}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{circulant_graph}
@deffn {Function} circulant_graph (@var{n}, @var{d})
Returns the circulant graph with parameters @var{n} and @var{d}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : circulant_graph(10, [1,3])$
@c print_graph(g)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : circulant_graph(10, [1,3])$
(%i3) print_graph(g)$
Graph on 10 vertices with 20 edges.
Adjacencies:
  9 :  2  6  0  8
  8 :  1  5  9  7
  7 :  0  4  8  6
  6 :  9  3  7  5
  5 :  8  2  6  4
  4 :  7  1  5  3
  3 :  6  0  4  2
  2 :  9  5  3  1
  1 :  8  4  2  0
  0 :  7  3  9  1
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{clebsch_graph}
@deffn {Function} clebsch_graph ()
Returns the Clebsch graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{complement_graph}
@deffn {Function} complement_graph (@var{g})
Returns the complement of the graph @var{g}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{complete_bipartite_graph}
@deffn {Function} complete_bipartite_graph (@var{n}, @var{m})
Returns the complete bipartite graph on @var{n+m} vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{complete_graph}
@deffn {Function} complete_graph (@var{n})
Returns the complete graph on @var{n} vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{cycle_digraph}
@deffn {Function} cycle_digraph (@var{n})
Returns the directed cycle on @var{n} vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{cycle_graph}
@deffn {Function} cycle_graph (@var{n})
Returns the cycle on @var{n} vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{cuboctahedron_graph}
@deffn {Function} cuboctahedron_graph (@var{n})
Returns the cuboctahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{cube_graph}
@deffn {Function} cube_graph (@var{n})
Returns the @var{n}-dimensional cube.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{dodecahedron_graph}
@deffn {Function} dodecahedron_graph ()
Returns the dodecahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{empty_graph}
@deffn {Function} empty_graph (@var{n})
Returns the empty graph on @var{n} vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{flower_snark}
@deffn {Function} flower_snark (@var{n})
Returns the flower graph on @var{4n} vertices.

Example:
@c ===beg===
@c load ("graphs")$
@c f5 : flower_snark(5)$
@c chromatic_index(f5);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) f5 : flower_snark(5)$
(%i3) chromatic_index(f5);
(%o3)                           4
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{from_adjacency_matrix}
@deffn {Function} from_adjacency_matrix (@var{A})
Returns the graph represented by its adjacency matrix @var{A}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{frucht_graph}
@deffn {Function} frucht_graph ()
Returns the Frucht graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{graph_product}
@deffn {Function} graph_product (@var{g1}, @var{g1})
Returns the direct product of graphs @var{g1} and @var{g2}.

Example:
@c ===beg===
@c load ("graphs")$
@c grid : graph_product(path_graph(3), path_graph(4))$
@c draw_graph(grid)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) grid : graph_product(path_graph(3), path_graph(4))$
(%i3) draw_graph(grid)$
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@ifhtml
@image{figures/graphs01,6cm}
@end ifhtml

@anchor{graph_union}
@deffn {Function} graph_union (@var{g1}, @var{g1})
Returns the union (sum) of graphs @var{g1} and @var{g2}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{grid_graph}
@deffn {Function} grid_graph (@var{n}, @var{m})
Returns the @var{n x m} grid.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{great_rhombicosidodecahedron_graph}
@deffn {Function} great_rhombicosidodecahedron_graph ()
Returns the great rhombicosidodecahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{great_rhombicuboctahedron_graph}
@deffn {Function} great_rhombicuboctahedron_graph ()
Returns the great rhombicuboctahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{grotzch_graph}
@deffn {Function} grotzch_graph ()
Returns the Grotzch graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{heawood_graph}
@deffn {Function} heawood_graph ()
Returns the Heawood graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{icosahedron_graph}
@deffn {Function} icosahedron_graph ()
Returns the icosahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{icosidodecahedron_graph}
@deffn {Function} icosidodecahedron_graph ()
Returns the icosidodecahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{induced_subgraph}
@deffn {Function} induced_subgraph (@var{V}, @var{g})
Returns the graph induced on the subset @var{V} of vertices of the graph
@var{g}.

Example:
@c ===beg===
@c load ("graphs")$
@c p : petersen_graph()$
@c V : [0,1,2,3,4]$
@c g : induced_subgraph(V, p)$
@c print_graph(g)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : petersen_graph()$
(%i3) V : [0,1,2,3,4]$
(%i4) g : induced_subgraph(V, p)$
(%i5) print_graph(g)$
Graph on 5 vertices with 5 edges.
Adjacencies:
  4 :  3  0
  3 :  2  4
  2 :  1  3
  1 :  0  2
  0 :  1  4
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{line_graph}
@deffn {Function} line_graph (@var{g})
Returns the line graph of the graph @var{g}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{make_graph}
@deffn {Function} make_graph @
@fname{make_graph} (@var{vrt}, @var{f}) @
@fname{make_graph} (@var{vrt}, @var{f}, @var{oriented})

Creates a graph using a predicate function @var{f}.

@var{vrt} is a list/set of vertices or an integer. If @var{vrt} is an
integer, then vertices of the graph will be integers from 1 to
@var{vrt}.

@var{f} is a predicate function. Two vertices @var{a} and @var{b} will
be connected if @code{f(a,b)=true}.

If @var{directed} is not @var{false}, then the graph will be directed.

Example 1:
@c ===beg===
@c load("graphs")$
@c g : make_graph(powerset({1,2,3,4,5}, 2), disjointp)$
@c is_isomorphic(g, petersen_graph());
@c get_vertex_label(1, g);
@c ===end===
@example
(%i1) load("graphs")$
(%i2) g : make_graph(powerset(@{1,2,3,4,5@}, 2), disjointp)$
(%i3) is_isomorphic(g, petersen_graph());
(%o3)                         true
(%i4) get_vertex_label(1, g);
(%o4)                        @{1, 2@}
@end example

Example 2:
@c ===beg===
@c load("graphs")$
@c f(i, j) := is (mod(j, i)=0)$
@c g : make_graph(20, f, directed=true)$
@c out_neighbors(4, g);
@c in_neighbors(18, g);
@c ===end===
@example
(%i1) load("graphs")$
(%i2) f(i, j) := is (mod(j, i)=0)$
(%i3) g : make_graph(20, f, directed=true)$
(%i4) out_neighbors(4, g);
(%o4)                    [8, 12, 16, 20]
(%i5) in_neighbors(18, g);
(%o5)                    [1, 2, 3, 6, 9]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{mycielski_graph}
@deffn {Function} mycielski_graph (@var{g})
Returns the mycielskian graph of the graph @var{g}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{new_graph}
@deffn {Function} new_graph ()
Returns the graph with no vertices and no edges.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{path_digraph}
@deffn {Function} path_digraph (@var{n})
Returns the directed path on @var{n} vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{path_graph}
@deffn {Function} path_graph (@var{n})
Returns the path on @var{n} vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{petersen_graph}
@deffn {Function} petersen_graph @
@fname{petersen_graph} () @
@fname{petersen_graph} (@var{n}, @var{d})

Returns the petersen graph @var{P_@{n,d@}}. The default values for
@var{n} and @var{d} are @code{n=5} and @code{d=2}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{random_bipartite_graph}
@deffn {Function} random_bipartite_graph (@var{a}, @var{b}, @var{p})
Returns a random bipartite graph on @code{a+b} vertices. Each edge is
present with probability @var{p}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{random_digraph}
@deffn {Function} random_digraph (@var{n}, @var{p})
Returns a random directed graph on @var{n} vertices. Each arc is present
with probability @var{p}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{random_regular_graph}
@deffn {Function} random_regular_graph @
@fname{random_regular_graph} (@var{n}) @
@fname{random_regular_graph} (@var{n}, @var{d})

Returns a random @var{d}-regular graph on @var{n} vertices. The default
value for @var{d} is @code{d=3}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{random_graph}
@deffn {Function} random_graph (@var{n}, @var{p})
Returns a random graph on @var{n} vertices. Each edge is present with
probability @var{p}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{random_graph1}
@deffn {Function} random_graph1 (@var{n}, @var{m})
Returns a random graph on @var{n} vertices and random @var{m} edges.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{random_network}
@deffn {Function} random_network (@var{n}, @var{p}, @var{w})
Returns a random network on @var{n} vertices. Each arc is present with
probability @var{p} and has a weight in the range @code{[0,w]}. The
function returns a list @code{[network, source, sink]}.

Example:
@c ===beg===
@c load ("graphs")$
@c [net, s, t] : random_network(50, 0.2, 10.0);
@c max_flow(net, s, t)$
@c first(%);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) [net, s, t] : random_network(50, 0.2, 10.0);
(%o2)                   [DIGRAPH, 50, 51]
(%i3) max_flow(net, s, t)$
(%i4) first(%);
(%o4)                   27.65981397932507
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{random_tournament}
@deffn {Function} random_tournament (@var{n})
Returns a random tournament on @var{n} vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{random_tree}
@deffn {Function} random_tree (@var{n})
Returns a random tree on @var{n} vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{small_rhombicosidodecahedron_graph}
@deffn {Function} small_rhombicosidodecahedron_graph ()
Returns the small rhombicosidodecahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{small_rhombicuboctahedron_graph}
@deffn {Function} small_rhombicuboctahedron_graph ()
Returns the small rhombicuboctahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{snub_cube_graph}
@deffn {Function} snub_cube_graph ()
Returns the snub cube graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{snub_dodecahedron_graph}
@deffn {Function} snub_dodecahedron_graph ()
Returns the snub dodecahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{truncated_cube_graph}
@deffn {Function} truncated_cube_graph ()
Returns the truncated cube graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{truncated_dodecahedron_graph}
@deffn {Function} truncated_dodecahedron_graph ()
Returns the truncated dodecahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn


@anchor{truncated_icosahedron_graph}
@deffn {Function} truncated_icosahedron_graph ()
Returns the truncated icosahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn


@anchor{truncated_tetrahedron_graph}
@deffn {Function} truncated_tetrahedron_graph ()
Returns the truncated tetrahedron graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{tutte_graph}
@deffn {Function} tutte_graph ()
Returns the Tutte graph.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{underlying_graph}
@deffn {Function} underlying_graph (@var{g})
Returns the underlying graph of the directed graph @var{g}.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@anchor{wheel_graph}
@deffn {Function} wheel_graph (@var{n})
Returns the wheel graph on @var{n+1} vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - constructions}
@closecatbox
@end deffn

@subsection Graph properties

@anchor{adjacency_matrix}
@deffn {Function} adjacency_matrix (@var{gr})
Returns the adjacency matrix of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c c5 : cycle_graph(4)$
@c adjacency_matrix(c5);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) c5 : cycle_graph(4)$
(%i3) adjacency_matrix(c5);
                         [ 0  1  0  1 ]
                         [            ]
                         [ 1  0  1  0 ]
(%o3)                    [            ]
                         [ 0  1  0  1 ]
                         [            ]
                         [ 1  0  1  0 ]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{average_degree}
@deffn {Function} average_degree (@var{gr})
Returns the average degree of vertices in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c average_degree(grotzch_graph());
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) average_degree(grotzch_graph());
                               40
(%o2)                          --
                               11
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{biconnected_components}
@deffn {Function} biconnected_components (@var{gr})
Returns the (vertex sets of) 2-connected components of the graph
@var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : create_graph(
@c             [1,2,3,4,5,6,7],
@c             [
@c              [1,2],[2,3],[2,4],[3,4],
@c              [4,5],[5,6],[4,6],[6,7]
@c             ])$
@c biconnected_components(g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : create_graph(
            [1,2,3,4,5,6,7],
            [
             [1,2],[2,3],[2,4],[3,4],
             [4,5],[5,6],[4,6],[6,7]
            ])$
(%i3) biconnected_components(g);
(%o3)        [[6, 7], [4, 5, 6], [1, 2], [2, 3, 4]]
@end example

@ifhtml
@image{figures/graphs13,6cm}
@end ifhtml

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{bipartition}
@deffn {Function} bipartition (@var{gr})
Returns a bipartition of the vertices of the graph @var{gr} or an empty
list if @var{gr} is not bipartite.

Example:

@c ===beg===
@c load ("graphs")$
@c h : heawood_graph()$
@c [A,B]:bipartition(h);
@c draw_graph(h, show_vertices=A, program=circular)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) h : heawood_graph()$
(%i3) [A,B]:bipartition(h);
(%o3)  [[8, 12, 6, 10, 0, 2, 4], [13, 5, 11, 7, 9, 1, 3]]
(%i4) draw_graph(h, show_vertices=A, program=circular)$
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@ifhtml
@image{figures/graphs02,6cm}
@end ifhtml

@anchor{chromatic_index}
@deffn {Function} chromatic_index (@var{gr})
Returns the chromatic index of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p : petersen_graph()$
@c chromatic_index(p);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : petersen_graph()$
(%i3) chromatic_index(p);
(%o3)                           4
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{chromatic_number}
@deffn {Function} chromatic_number (@var{gr})
Returns the chromatic number of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c chromatic_number(cycle_graph(5));
@c chromatic_number(cycle_graph(6));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) chromatic_number(cycle_graph(5));
(%o2)                           3
(%i3) chromatic_number(cycle_graph(6));
(%o3)                           2
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{clear_edge_weight}
@deffn {Function} clear_edge_weight (@var{e}, @var{gr})
Removes the weight of the edge  @var{e} in the graph @var{gr}.

Example:

@c ===beg===
@c load ("graphs")$
@c g : create_graph(3, [[[0,1], 1.5], [[1,2], 1.3]])$
@c get_edge_weight([0,1], g);
@c clear_edge_weight([0,1], g)$
@c get_edge_weight([0,1], g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : create_graph(3, [[[0,1], 1.5], [[1,2], 1.3]])$
(%i3) get_edge_weight([0,1], g);
(%o3)                          1.5
(%i4) clear_edge_weight([0,1], g)$
(%i5) get_edge_weight([0,1], g);
(%o5)                           1
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{clear_vertex_label}
@deffn {Function} clear_vertex_label (@var{v}, @var{gr})
Removes the label of the vertex @var{v} in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : create_graph([[0,"Zero"], [1, "One"]], [[0,1]])$
@c get_vertex_label(0, g);
@c clear_vertex_label(0, g);
@c get_vertex_label(0, g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : create_graph([[0,"Zero"], [1, "One"]], [[0,1]])$
(%i3) get_vertex_label(0, g);
(%o3)                         Zero
(%i4) clear_vertex_label(0, g);
(%o4)                         done
(%i5) get_vertex_label(0, g);
(%o5)                         false
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{connected_components}
@deffn {Function} connected_components (@var{gr})
Returns the (vertex sets of) connected components of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g: graph_union(cycle_graph(5), path_graph(4))$
@c connected_components(g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g: graph_union(cycle_graph(5), path_graph(4))$
(%i3) connected_components(g);
(%o3)            [[1, 2, 3, 4, 0], [8, 7, 6, 5]]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{diameter}
@deffn {Function} diameter (@var{gr})
Returns the diameter of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c diameter(dodecahedron_graph());
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) diameter(dodecahedron_graph());
(%o2)                           5
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{edge_coloring}
@deffn {Function} edge_coloring (@var{gr})
Returns an optimal coloring of the edges of the graph @var{gr}.

The function returns the chromatic index and a list representing the
coloring of the edges of @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p : petersen_graph()$
@c [ch_index, col] : edge_coloring(p);
@c assoc([0,1], col);
@c assoc([0,5], col);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : petersen_graph()$
(%i3) [ch_index, col] : edge_coloring(p);
(%o3) [4, [[[0, 5], 3], [[5, 7], 1], [[0, 1], 1], [[1, 6], 2], 
[[6, 8], 1], [[1, 2], 3], [[2, 7], 4], [[7, 9], 2], [[2, 3], 2], 
[[3, 8], 3], [[5, 8], 2], [[3, 4], 1], [[4, 9], 4], [[6, 9], 3], 
[[0, 4], 2]]]
(%i4) assoc([0,1], col);
(%o4)                           1
(%i5) assoc([0,5], col);
(%o5)                           3
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{degree_sequence}
@deffn {Function} degree_sequence (@var{gr})
Returns the list of vertex degrees of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c degree_sequence(random_graph(10, 0.4));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) degree_sequence(random_graph(10, 0.4));
(%o2)            [2, 2, 2, 2, 2, 2, 3, 3, 3, 3]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{edge_connectivity}
@deffn {Function} edge_connectivity (@var{gr})
Returns the edge-connectivity of the graph @var{gr}.

See also @mref{min_edge_cut}.

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{edges}
@deffn {Function} edges (@var{gr})
Returns the list of edges (arcs) in a (directed) graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c edges(complete_graph(4));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) edges(complete_graph(4));
(%o2)   [[2, 3], [1, 3], [1, 2], [0, 3], [0, 2], [0, 1]]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{get_edge_weight}
@deffn {Function} get_edge_weight @
@fname{get_edge_weight} (@var{e}, @var{gr}) @
@fname{get_edge_weight} (@var{e}, @var{gr}, @var{ifnot})

Returns the weight of the edge @var{e} in the graph @var{gr}.

If there is no weight assigned to the edge, the function returns 1. If
the edge is not present in the graph, the function signals an error or
returns the optional argument @var{ifnot}.

Example:
@c ===beg===
@c load ("graphs")$
@c c5 : cycle_graph(5)$
@c get_edge_weight([1,2], c5);
@c set_edge_weight([1,2], 2.0, c5);
@c get_edge_weight([1,2], c5);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) c5 : cycle_graph(5)$
(%i3) get_edge_weight([1,2], c5);
(%o3)                           1
(%i4) set_edge_weight([1,2], 2.0, c5);
(%o4)                         done
(%i5) get_edge_weight([1,2], c5);
(%o5)                          2.0
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{get_vertex_label}
@deffn {Function} get_vertex_label (@var{v}, @var{gr})
Returns the label of the vertex @var{v} in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : create_graph([[0,"Zero"], [1, "One"]], [[0,1]])$
@c get_vertex_label(0, g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : create_graph([[0,"Zero"], [1, "One"]], [[0,1]])$
(%i3) get_vertex_label(0, g);
(%o3)                         Zero
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{graph_charpoly}
@deffn {Function} graph_charpoly (@var{gr}, @var{x})
Returns the characteristic polynomial (in variable @var{x}) of the graph
@var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p : petersen_graph()$
@c graph_charpoly(p, x), factor;
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : petersen_graph()$
(%i3) graph_charpoly(p, x), factor;
                                   5        4
(%o3)               (x - 3) (x - 1)  (x + 2)
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{graph_center}
@deffn {Function} graph_center (@var{gr})
Returns the center of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : grid_graph(5,5)$
@c graph_center(g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : grid_graph(5,5)$
(%i3) graph_center(g);
(%o3)                         [12]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{graph_eigenvalues}
@deffn {Function} graph_eigenvalues (@var{gr})
Returns the eigenvalues of the graph @var{gr}. The function returns
eigenvalues in the same format as maxima @mref{eigenvalues} function.

Example:
@c ===beg===
@c load ("graphs")$
@c p : petersen_graph()$
@c graph_eigenvalues(p);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : petersen_graph()$
(%i3) graph_eigenvalues(p);
(%o3)               [[3, - 2, 1], [1, 4, 5]]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{graph_periphery}
@deffn {Function} graph_periphery (@var{gr})
Returns the periphery of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : grid_graph(5,5)$
@c graph_periphery(g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : grid_graph(5,5)$
(%i3) graph_periphery(g);
(%o3)                    [24, 20, 4, 0]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{graph_size}
@deffn {Function} graph_size (@var{gr})
Returns the number of edges in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p : petersen_graph()$
@c graph_size(p);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : petersen_graph()$
(%i3) graph_size(p);
(%o3)                          15
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{graph_order}
@deffn {Function} graph_order (@var{gr})
Returns the number of vertices in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p : petersen_graph()$
@c graph_order(p);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : petersen_graph()$
(%i3) graph_order(p);
(%o3)                          10
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{girth}
@deffn {Function} girth (@var{gr})
Returns the length of the shortest cycle in @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : heawood_graph()$
@c girth(g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : heawood_graph()$
(%i3) girth(g);
(%o3)                           6
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{hamilton_cycle}
@deffn {Function} hamilton_cycle (@var{gr})
Returns the Hamilton cycle of the graph @var{gr} or an empty list if
@var{gr} is not hamiltonian.

Example:
@c ===beg===
@c load ("graphs")$
@c c : cube_graph(3)$
@c hc : hamilton_cycle(c);
@c draw_graph(c, show_edges=vertices_to_cycle(hc))$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) c : cube_graph(3)$
(%i3) hc : hamilton_cycle(c);
(%o3)              [7, 3, 2, 6, 4, 0, 1, 5, 7]
(%i4) draw_graph(c, show_edges=vertices_to_cycle(hc))$
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@ifhtml
@image{figures/graphs03,6cm}
@end ifhtml

@anchor{hamilton_path}
@deffn {Function} hamilton_path (@var{gr})
Returns the Hamilton path of the graph @var{gr} or an empty list if
@var{gr} does not have a Hamilton path.

Example:
@c ===beg===
@c load ("graphs")$
@c p : petersen_graph()$
@c hp : hamilton_path(p);
@c draw_graph(p, show_edges=vertices_to_path(hp))$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : petersen_graph()$
(%i3) hp : hamilton_path(p);
(%o3)            [0, 5, 7, 2, 1, 6, 8, 3, 4, 9]
(%i4) draw_graph(p, show_edges=vertices_to_path(hp))$
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@ifhtml
@image{figures/graphs04,6cm}
@end ifhtml

@anchor{isomorphism}
@deffn {Function} isomorphism (@var{gr1}, @var{gr2})

Returns a an isomorphism between graphs/digraphs @var{gr1} and
@var{gr2}. If @var{gr1} and @var{gr2} are not isomorphic, it returns
an empty list.

Example:
@c ===beg===
@c load ("graphs")$
@c clk5:complement_graph(line_graph(complete_graph(5)))$
@c isomorphism(clk5, petersen_graph());
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) clk5:complement_graph(line_graph(complete_graph(5)))$
(%i3) isomorphism(clk5, petersen_graph());
(%o3) [9 -> 0, 2 -> 1, 6 -> 2, 5 -> 3, 0 -> 4, 1 -> 5, 3 -> 6, 
                                          4 -> 7, 7 -> 8, 8 -> 9]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{in_neighbors}
@deffn {Function} in_neighbors (@var{v}, @var{gr})
Returns the list of in-neighbors of the vertex @var{v} in the directed
graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p : path_digraph(3)$
@c in_neighbors(2, p);
@c out_neighbors(2, p);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : path_digraph(3)$
(%i3) in_neighbors(2, p);
(%o3)                          [1]
(%i4) out_neighbors(2, p);
(%o4)                          []
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_biconnected}
@deffn {Function} is_biconnected (@var{gr})
Returns @code{true} if @var{gr} is 2-connected and @code{false} otherwise.

Example:
@c ===beg===
@c load ("graphs")$
@c is_biconnected(cycle_graph(5));
@c is_biconnected(path_graph(5));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) is_biconnected(cycle_graph(5));
(%o2)                         true
(%i3) is_biconnected(path_graph(5));
(%o3)                         false
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_bipartite}
@deffn {Function} is_bipartite (@var{gr})
Returns @code{true} if @var{gr} is bipartite (2-colorable) and @code{false} otherwise.

Example:
@c ===beg===
@c load ("graphs")$
@c is_bipartite(petersen_graph());
@c is_bipartite(heawood_graph());
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) is_bipartite(petersen_graph());
(%o2)                         false
(%i3) is_bipartite(heawood_graph());
(%o3)                         true
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_connected}
@deffn {Function} is_connected (@var{gr})
Returns @code{true} if the graph @var{gr} is connected and @code{false} otherwise.

Example:
@c ===beg===
@c load ("graphs")$
@c is_connected(graph_union(cycle_graph(4), path_graph(3)));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) is_connected(graph_union(cycle_graph(4), path_graph(3)));
(%o2)                         false
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_digraph}
@deffn {Function} is_digraph (@var{gr})
Returns @code{true} if @var{gr} is a directed graph and @code{false} otherwise.

Example:
@c ===beg===
@c load ("graphs")$
@c is_digraph(path_graph(5));
@c is_digraph(path_digraph(5));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) is_digraph(path_graph(5));
(%o2)                         false
(%i3) is_digraph(path_digraph(5));
(%o3)                         true
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_edge_in_graph}
@deffn {Function} is_edge_in_graph (@var{e}, @var{gr})
Returns @code{true} if @var{e} is an edge (arc) in the (directed) graph @var{g}
and @code{false} otherwise.

Example:
@c ===beg===
@c load ("graphs")$
@c c4 : cycle_graph(4)$
@c is_edge_in_graph([2,3], c4);
@c is_edge_in_graph([3,2], c4);
@c is_edge_in_graph([2,4], c4);
@c is_edge_in_graph([3,2], cycle_digraph(4));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) c4 : cycle_graph(4)$
(%i3) is_edge_in_graph([2,3], c4);
(%o3)                         true
(%i4) is_edge_in_graph([3,2], c4);
(%o4)                         true
(%i5) is_edge_in_graph([2,4], c4);
(%o5)                         false
(%i6) is_edge_in_graph([3,2], cycle_digraph(4));
(%o6)                         false
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_graph}
@deffn {Function} is_graph (@var{gr})
Returns @code{true} if @var{gr} is a graph and @code{false} otherwise.

Example:
@c ===beg===
@c load ("graphs")$
@c is_graph(path_graph(5));
@c is_graph(path_digraph(5));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) is_graph(path_graph(5));
(%o2)                         true
(%i3) is_graph(path_digraph(5));
(%o3)                         false
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_graph_or_digraph}
@deffn {Function} is_graph_or_digraph (@var{gr})
Returns @code{true} if @var{gr} is a graph or a directed graph and @code{false} otherwise.

Example:
@c ===beg===
@c load ("graphs")$
@c is_graph_or_digraph(path_graph(5));
@c is_graph_or_digraph(path_digraph(5));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) is_graph_or_digraph(path_graph(5));
(%o2)                         true
(%i3) is_graph_or_digraph(path_digraph(5));
(%o3)                         true
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_isomorphic}
@deffn {Function} is_isomorphic (@var{gr1}, @var{gr2})

Returns @code{true} if graphs/digraphs @var{gr1} and @var{gr2} are isomorphic
and @code{false} otherwise.

See also @mrefdot{isomorphism}

Example:
@c ===beg===
@c load ("graphs")$
@c clk5:complement_graph(line_graph(complete_graph(5)))$
@c is_isomorphic(clk5, petersen_graph());
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) clk5:complement_graph(line_graph(complete_graph(5)))$
(%i3) is_isomorphic(clk5, petersen_graph());
(%o3)                         true
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_planar}
@deffn {Function} is_planar (@var{gr})

Returns @code{true} if @var{gr} is a planar graph and @code{false} otherwise.

The algorithm used is the Demoucron's algorithm, which is a quadratic time
algorithm.

Example:
@c ===beg===
@c load ("graphs")$
@c is_planar(dodecahedron_graph());
@c is_planar(petersen_graph());
@c is_planar(petersen_graph(10,2));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) is_planar(dodecahedron_graph());
(%o2)                         true
(%i3) is_planar(petersen_graph());
(%o3)                         false
(%i4) is_planar(petersen_graph(10,2));
(%o4)                         true
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_sconnected}
@deffn {Function} is_sconnected (@var{gr})
Returns @code{true} if the directed graph @var{gr} is strongly connected and
@code{false} otherwise.

Example:
@c ===beg===
@c load ("graphs")$
@c is_sconnected(cycle_digraph(5));
@c is_sconnected(path_digraph(5));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) is_sconnected(cycle_digraph(5));
(%o2)                         true
(%i3) is_sconnected(path_digraph(5));
(%o3)                         false
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_vertex_in_graph}
@deffn {Function} is_vertex_in_graph (@var{v}, @var{gr})
Returns @code{true} if @var{v} is a vertex in the graph @var{g} and @code{false}  otherwise.

Example:
@c ===beg===
@c load ("graphs")$
@c c4 : cycle_graph(4)$
@c is_vertex_in_graph(0, c4);
@c is_vertex_in_graph(6, c4);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) c4 : cycle_graph(4)$
(%i3) is_vertex_in_graph(0, c4);
(%o3)                         true
(%i4) is_vertex_in_graph(6, c4);
(%o4)                         false
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{is_tree}
@deffn {Function} is_tree (@var{gr})
Returns @code{true} if @var{gr} is a tree and @code{false}  otherwise.

Example:
@c ===beg===
@c load ("graphs")$
@c is_tree(random_tree(4));
@c is_tree(graph_union(random_tree(4), random_tree(5)));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) is_tree(random_tree(4));
(%o2)                         true
(%i3) is_tree(graph_union(random_tree(4), random_tree(5)));
(%o3)                         false
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{laplacian_matrix}
@deffn {Function} laplacian_matrix (@var{gr})
Returns the laplacian matrix of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c laplacian_matrix(cycle_graph(5));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) laplacian_matrix(cycle_graph(5));
                   [  2   - 1   0    0   - 1 ]
                   [                         ]
                   [ - 1   2   - 1   0    0  ]
                   [                         ]
(%o2)              [  0   - 1   2   - 1   0  ]
                   [                         ]
                   [  0    0   - 1   2   - 1 ]
                   [                         ]
                   [ - 1   0    0   - 1   2  ]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{max_clique}
@deffn {Function} max_clique (@var{gr})
Returns a maximum clique of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : random_graph(100, 0.5)$
@c max_clique(g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : random_graph(100, 0.5)$
(%i3) max_clique(g);
(%o3)          [6, 12, 31, 36, 52, 59, 62, 63, 80]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{max_degree}
@deffn {Function} max_degree (@var{gr})
Returns the maximal degree of vertices of the graph @var{gr} and a
vertex of maximal degree.

Example:
@c ===beg===
@c load ("graphs")$
@c g : random_graph(100, 0.02)$
@c max_degree(g);
@c vertex_degree(95, g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : random_graph(100, 0.02)$
(%i3) max_degree(g);
(%o3)                        [6, 79]
(%i4) vertex_degree(95, g);
(%o4)                           2
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{max_flow}
@deffn {Function} max_flow (@var{net}, @var{s}, @var{t})
Returns a maximum flow through the network @var{net} with the source
@var{s} and the sink @var{t}.

The function returns the value of the maximal flow and a list
representing the weights of the arcs in the optimal flow.

Example:
@c ===beg===
@c load ("graphs")$
@c net : create_graph(
@c   [1,2,3,4,5,6],
@c   [[[1,2], 1.0],
@c    [[1,3], 0.3],
@c    [[2,4], 0.2],
@c    [[2,5], 0.3],
@c    [[3,4], 0.1],
@c    [[3,5], 0.1],
@c    [[4,6], 1.0],
@c    [[5,6], 1.0]],
@c   directed=true)$
@c [flow_value, flow] : max_flow(net, 1, 6);
@c fl : 0$
@c for u in out_neighbors(1, net) 
@c      do fl : fl + assoc([1, u], flow)$
@c fl;
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) net : create_graph(
  [1,2,3,4,5,6],
  [[[1,2], 1.0],
   [[1,3], 0.3],
   [[2,4], 0.2],
   [[2,5], 0.3],
   [[3,4], 0.1],
   [[3,5], 0.1],
   [[4,6], 1.0],
   [[5,6], 1.0]],
  directed=true)$
(%i3) [flow_value, flow] : max_flow(net, 1, 6);
(%o3) [0.7, [[[1, 2], 0.5], [[1, 3], 0.2], [[2, 4], 0.2], 
[[2, 5], 0.3], [[3, 4], 0.1], [[3, 5], 0.1], [[4, 6], 0.3], 
[[5, 6], 0.4]]]
(%i4) fl : 0$
(%i5) for u in out_neighbors(1, net)
     do fl : fl + assoc([1, u], flow)$
(%i6) fl;
(%o6)                          0.7
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{max_independent_set}
@deffn {Function} max_independent_set (@var{gr})
Returns a maximum independent set of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c d : dodecahedron_graph()$
@c mi : max_independent_set(d);
@c draw_graph(d, show_vertices=mi)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) d : dodecahedron_graph()$
(%i3) mi : max_independent_set(d);
(%o3)             [0, 3, 5, 9, 10, 11, 18, 19]
(%i4) draw_graph(d, show_vertices=mi)$
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@ifhtml
@image{figures/graphs05,6cm}
@end ifhtml

@anchor{max_matching}
@deffn {Function} max_matching (@var{gr})
Returns a maximum matching of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c d : dodecahedron_graph()$
@c m : max_matching(d);
@c draw_graph(d, show_edges=m)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) d : dodecahedron_graph()$
(%i3) m : max_matching(d);
(%o3) [[5, 7], [8, 9], [6, 10], [14, 19], [13, 18], [12, 17], 
                               [11, 16], [0, 15], [3, 4], [1, 2]]
(%i4) draw_graph(d, show_edges=m)$
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@ifhtml
@image{figures/graphs06,6cm}
@end ifhtml

@anchor{min_degree}
@deffn {Function} min_degree (@var{gr})
Returns the minimum degree of vertices of the graph @var{gr} and a
vertex of minimum degree.

Example:
@c ===beg===
@c load ("graphs")$
@c g : random_graph(100, 0.1)$
@c min_degree(g);
@c vertex_degree(21, g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : random_graph(100, 0.1)$
(%i3) min_degree(g);
(%o3)                        [3, 49]
(%i4) vertex_degree(21, g);
(%o4)                           9
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{min_edge_cut}
@deffn {Function} min_edge_cut (@var{gr})
Returns the minimum edge cut in the graph @var{gr}.

See also @mrefdot{edge_connectivity}

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{min_vertex_cover}
@deffn {Function} min_vertex_cover (@var{gr})
Returns the minimum vertex cover of the graph @var{gr}.

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{min_vertex_cut}
@deffn {Function} min_vertex_cut (@var{gr})
Returns the minimum vertex cut in the graph @var{gr}.

See also @mrefdot{vertex_connectivity}

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{minimum_spanning_tree}
@deffn {Function} minimum_spanning_tree (@var{gr})
Returns the minimum spanning tree of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : graph_product(path_graph(10), path_graph(10))$
@c t : minimum_spanning_tree(g)$
@c draw_graph(g, show_edges=edges(t))$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : graph_product(path_graph(10), path_graph(10))$
(%i3) t : minimum_spanning_tree(g)$
(%i4) draw_graph(g, show_edges=edges(t))$
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@ifhtml
@image{figures/graphs07,6cm}
@end ifhtml

@anchor{neighbors}
@deffn {Function} neighbors (@var{v}, @var{gr})
Returns the list of neighbors of the vertex @var{v} in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p : petersen_graph()$
@c neighbors(3, p);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : petersen_graph()$
(%i3) neighbors(3, p);
(%o3)                       [4, 8, 2]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{odd_girth}
@deffn {Function} odd_girth (@var{gr})
Returns the length of the shortest odd cycle in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : graph_product(cycle_graph(4), cycle_graph(7))$
@c girth(g);
@c odd_girth(g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : graph_product(cycle_graph(4), cycle_graph(7))$
(%i3) girth(g);
(%o3)                           4
(%i4) odd_girth(g);
(%o4)                           7
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{out_neighbors}
@deffn {Function} out_neighbors (@var{v}, @var{gr})
Returns the list of out-neighbors of the vertex @var{v} in the directed
graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p : path_digraph(3)$
@c in_neighbors(2, p);
@c out_neighbors(2, p);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : path_digraph(3)$
(%i3) in_neighbors(2, p);
(%o3)                          [1]
(%i4) out_neighbors(2, p);
(%o4)                          []
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{planar_embedding}
@deffn {Function} planar_embedding (@var{gr})

Returns the list of facial walks in a planar embedding of @var{gr} and
@code{false} if @var{gr} is not a planar graph.

The graph @var{gr} must be biconnected.

The algorithm used is the Demoucron's algorithm, which is a quadratic time
algorithm.

Example:
@c ===beg===
@c load ("graphs")$
@c planar_embedding(grid_graph(3,3));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) planar_embedding(grid_graph(3,3));
(%o2) [[3, 6, 7, 8, 5, 2, 1, 0], [4, 3, 0, 1], [3, 4, 7, 6], 
                                      [8, 7, 4, 5], [1, 2, 5, 4]]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{print_graph}
@deffn {Function} print_graph (@var{gr})
Prints some information about the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c c5 : cycle_graph(5)$
@c print_graph(c5)$
@c dc5 : cycle_digraph(5)$
@c print_graph(dc5)$
@c out_neighbors(0, dc5);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) c5 : cycle_graph(5)$
(%i3) print_graph(c5)$
Graph on 5 vertices with 5 edges.
Adjacencies:
  4 :  0  3
  3 :  4  2
  2 :  3  1
  1 :  2  0
  0 :  4  1
(%i4) dc5 : cycle_digraph(5)$
(%i5) print_graph(dc5)$
Digraph on 5 vertices with 5 arcs.
Adjacencies:
  4 :  0
  3 :  4
  2 :  3
  1 :  2
  0 :  1
(%i6) out_neighbors(0, dc5);
(%o6)                          [1]
@end example

@opencatbox
@category{Package graphs}
@closecatbox
@end deffn

@anchor{radius}
@deffn {Function} radius (@var{gr})
Returns the radius of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c radius(dodecahedron_graph());
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) radius(dodecahedron_graph());
(%o2)                           5
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{set_edge_weight}
@deffn {Function} set_edge_weight (@var{e}, @var{w}, @var{gr})
Assigns the weight @var{w} to the edge @var{e} in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : create_graph([1, 2], [[[1,2], 1.2]])$
@c get_edge_weight([1,2], g);
@c set_edge_weight([1,2], 2.1, g);
@c get_edge_weight([1,2], g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : create_graph([1, 2], [[[1,2], 1.2]])$
(%i3) get_edge_weight([1,2], g);
(%o3)                          1.2
(%i4) set_edge_weight([1,2], 2.1, g);
(%o4)                         done
(%i5) get_edge_weight([1,2], g);
(%o5)                          2.1
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{set_vertex_label}
@deffn {Function} set_vertex_label (@var{v}, @var{l}, @var{gr})
Assigns the label @var{l} to the vertex @var{v} in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : create_graph([[1, "One"], [2, "Two"]], [[1,2]])$
@c get_vertex_label(1, g);
@c set_vertex_label(1, "oNE", g);
@c get_vertex_label(1, g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : create_graph([[1, "One"], [2, "Two"]], [[1,2]])$
(%i3) get_vertex_label(1, g);
(%o3)                          One
(%i4) set_vertex_label(1, "oNE", g);
(%o4)                         done
(%i5) get_vertex_label(1, g);
(%o5)                          oNE
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{shortest_path}
@deffn {Function} shortest_path (@var{u}, @var{v}, @var{gr})
Returns the shortest path from @var{u} to @var{v} in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c d : dodecahedron_graph()$
@c path : shortest_path(0, 7, d);
@c draw_graph(d, show_edges=vertices_to_path(path))$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) d : dodecahedron_graph()$
(%i3) path : shortest_path(0, 7, d);
(%o3)                   [0, 1, 19, 13, 7]
(%i4) draw_graph(d, show_edges=vertices_to_path(path))$
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@ifhtml
@image{figures/graphs08,6cm}
@end ifhtml

@anchor{shortest_weighted_path}
@deffn {Function} shortest_weighted_path (@var{u}, @var{v}, @var{gr})
Returns the length of the shortest weighted path and the shortest
weighted path from @var{u} to @var{v} in the graph @var{gr}.

The length of a weighted path is the sum of edge weights of edges in the
path. If an edge has no weight, then it has a default weight 1.

Example:

@c ===beg===
@c load ("graphs")$
@c g: petersen_graph(20, 2)$
@c for e in edges(g) do set_edge_weight(e, random(1.0), g)$
@c shortest_weighted_path(0, 10, g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g: petersen_graph(20, 2)$
(%i3) for e in edges(g) do set_edge_weight(e, random(1.0), g)$
(%i4) shortest_weighted_path(0, 10, g);
(%o4) [2.575143920268482, [0, 20, 38, 36, 34, 32, 30, 10]]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{strong_components}
@deffn {Function} strong_components (@var{gr})
Returns the strong components of a directed graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c t : random_tournament(4)$
@c strong_components(t);
@c vertex_out_degree(3, t);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) t : random_tournament(4)$
(%i3) strong_components(t);
(%o3)                 [[1], [0], [2], [3]]
(%i4) vertex_out_degree(3, t);
(%o4)                           3
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{topological_sort}
@deffn {Function} topological_sort (@var{dag})

Returns a topological sorting of the vertices of a directed graph
@var{dag} or an empty list if @var{dag} is not a directed acyclic graph.

Example:
@c ===beg===
@c load ("graphs")$
@c g:create_graph(
@c          [1,2,3,4,5],
@c          [
@c           [1,2], [2,5], [5,3],
@c           [5,4], [3,4], [1,3]
@c          ],
@c          directed=true)$
@c topological_sort(g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g:create_graph(
         [1,2,3,4,5],
         [
          [1,2], [2,5], [5,3],
          [5,4], [3,4], [1,3]
         ],
         directed=true)$
(%i3) topological_sort(g);
(%o3)                    [1, 2, 5, 3, 4]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{vertex_connectivity}
@deffn {Function} vertex_connectivity (@var{g})
Returns the vertex connectivity of the graph @var{g}.

See also @mrefdot{min_vertex_cut}

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{vertex_degree}
@deffn {Function} vertex_degree (@var{v}, @var{gr})
Returns the degree of the vertex @var{v} in the graph @var{gr}.

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{vertex_distance}
@deffn {Function} vertex_distance (@var{u}, @var{v}, @var{gr})
Returns the length of the shortest path between @var{u} and @var{v} in
the (directed) graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c d : dodecahedron_graph()$
@c vertex_distance(0, 7, d);
@c shortest_path(0, 7, d);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) d : dodecahedron_graph()$
(%i3) vertex_distance(0, 7, d);
(%o3)                           4
(%i4) shortest_path(0, 7, d);
(%o4)                   [0, 1, 19, 13, 7]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{vertex_eccentricity}
@deffn {Function} vertex_eccentricity (@var{v}, @var{gr})

Returns the eccentricity of the vertex @var{v} in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g:cycle_graph(7)$
@c vertex_eccentricity(0, g);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g:cycle_graph(7)$
(%i3) vertex_eccentricity(0, g);
(%o3)                           3
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{vertex_in_degree}
@deffn {Function} vertex_in_degree (@var{v}, @var{gr})
Returns the in-degree of the vertex @var{v} in the directed graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p5 : path_digraph(5)$
@c print_graph(p5)$
@c vertex_in_degree(4, p5);
@c in_neighbors(4, p5);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p5 : path_digraph(5)$
(%i3) print_graph(p5)$
Digraph on 5 vertices with 4 arcs.
Adjacencies:
  4 :
  3 :  4
  2 :  3
  1 :  2
  0 :  1
(%i4) vertex_in_degree(4, p5);
(%o4)                           1
(%i5) in_neighbors(4, p5);
(%o5)                          [3]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{vertex_out_degree}
@deffn {Function} vertex_out_degree (@var{v}, @var{gr})
Returns the out-degree of the vertex @var{v} in the directed graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c t : random_tournament(10)$
@c vertex_out_degree(0, t);
@c out_neighbors(0, t);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) t : random_tournament(10)$
(%i3) vertex_out_degree(0, t);
(%o3)                           2
(%i4) out_neighbors(0, t);
(%o4)                        [7, 1]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{vertices}
@deffn {Function} vertices (@var{gr})
Returns the list of vertices in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c vertices(complete_graph(4));
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) vertices(complete_graph(4));
(%o2)                     [3, 2, 1, 0]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{vertex_coloring}
@deffn {Function} vertex_coloring (@var{gr})
Returns an optimal coloring of the vertices of the graph @var{gr}.

The function returns the chromatic number and a list representing the
coloring of the vertices of @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p:petersen_graph()$
@c vertex_coloring(p);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p:petersen_graph()$
(%i3) vertex_coloring(p);
(%o3) [3, [[0, 2], [1, 3], [2, 2], [3, 3], [4, 1], [5, 3], 
                                 [6, 1], [7, 1], [8, 2], [9, 2]]]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@anchor{wiener_index}
@deffn {Function} wiener_index (@var{gr})
Returns the Wiener index of the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c wiener_index(dodecahedron_graph());
@c ===end===
@example
(%i2) wiener_index(dodecahedron_graph());
(%o2)                          500
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - properties}
@closecatbox
@end deffn

@subsection Modifying graphs

@anchor{add_edge}
@deffn {Function} add_edge (@var{e}, @var{gr})
Adds the edge @var{e} to the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c p : path_graph(4)$
@c neighbors(0, p);
@c add_edge([0,3], p);
@c neighbors(0, p);
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) p : path_graph(4)$
(%i3) neighbors(0, p);
(%o3)                          [1]
(%i4) add_edge([0,3], p);
(%o4)                         done
(%i5) neighbors(0, p);
(%o5)                        [3, 1]
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - modifications}
@closecatbox
@end deffn

@anchor{add_edges}
@deffn {Function} add_edges (@var{e_list}, @var{gr})
Adds all edges in the list @var{e_list} to the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : empty_graph(3)$
@c add_edges([[0,1],[1,2]], g)$
@c print_graph(g)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : empty_graph(3)$
(%i3) add_edges([[0,1],[1,2]], g)$
(%i4) print_graph(g)$
Graph on 3 vertices with 2 edges.
Adjacencies:
  2 :  1
  1 :  2  0
  0 :  1
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - modifications}
@closecatbox
@end deffn

@anchor{add_vertex}
@deffn {Function} add_vertex (@var{v}, @var{gr})
Adds the vertex @var{v} to the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g : path_graph(2)$
@c add_vertex(2, g)$
@c print_graph(g)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : path_graph(2)$
(%i3) add_vertex(2, g)$
(%i4) print_graph(g)$
Graph on 3 vertices with 1 edges.
Adjacencies:
  2 :
  1 :  0
  0 :  1
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - modifications}
@closecatbox
@end deffn

@anchor{add_vertices}
@deffn {Function} add_vertices (@var{v_list}, @var{gr})
Adds all vertices in the list @var{v_list} to the graph @var{gr}.

@opencatbox
@category{Package graphs} @category{Package graphs - modifications}
@closecatbox
@end deffn

@anchor{connect_vertices}
@deffn {Function} connect_vertices (@var{v_list}, @var{u_list}, @var{gr})
Connects all vertices from the list @var{v_list} with the vertices in
the list @var{u_list} in the graph @var{gr}.

@var{v_list} and @var{u_list} can be single vertices or lists of
vertices.

Example:
@c ===beg===
@c load ("graphs")$
@c g : empty_graph(4)$
@c connect_vertices(0, [1,2,3], g)$
@c print_graph(g)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g : empty_graph(4)$
(%i3) connect_vertices(0, [1,2,3], g)$
(%i4) print_graph(g)$
Graph on 4 vertices with 3 edges.
Adjacencies:
  3 :  0
  2 :  0
  1 :  0
  0 :  3  2  1
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - modifications}
@closecatbox
@end deffn

@anchor{contract_edge}
@deffn {Function} contract_edge (@var{e}, @var{gr})
Contracts the edge @var{e} in the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c g: create_graph(
@c       8, [[0,3],[1,3],[2,3],[3,4],[4,5],[4,6],[4,7]])$
@c print_graph(g)$
@c contract_edge([3,4], g)$
@c print_graph(g)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g: create_graph(
      8, [[0,3],[1,3],[2,3],[3,4],[4,5],[4,6],[4,7]])$
(%i3) print_graph(g)$
Graph on 8 vertices with 7 edges.
Adjacencies:
  7 :  4
  6 :  4
  5 :  4
  4 :  7  6  5  3
  3 :  4  2  1  0
  2 :  3
  1 :  3
  0 :  3
(%i4) contract_edge([3,4], g)$
(%i5) print_graph(g)$
Graph on 7 vertices with 6 edges.
Adjacencies:
  7 :  3
  6 :  3
  5 :  3
  3 :  5  6  7  2  1  0
  2 :  3
  1 :  3
  0 :  3
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - modifications}
@closecatbox
@end deffn

@anchor{remove_edge}
@deffn {Function} remove_edge (@var{e}, @var{gr})
Removes the edge @var{e} from the graph @var{gr}.

Example:
@c ===beg===
@c load ("graphs")$
@c c3 : cycle_graph(3)$
@c remove_edge([0,1], c3)$
@c print_graph(c3)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) c3 : cycle_graph(3)$
(%i3) remove_edge([0,1], c3)$
(%i4) print_graph(c3)$
Graph on 3 vertices with 2 edges.
Adjacencies:
  2 :  0  1
  1 :  2
  0 :  2
@end example

@opencatbox
@category{Package graphs} @category{Package graphs - modifications}
@closecatbox
@end deffn

@anchor{remove_vertex}
@deffn {Function} remove_vertex (@var{v}, @var{gr})
Removes the vertex @var{v} from the graph @var{gr}.

@opencatbox
@category{Package graphs}
@closecatbox
@end deffn

@subsection Reading and writing to files

@anchor{dimacs_export}
@deffn {Function} dimacs_export @
@fname{dimacs_export} (@var{gr}, @var{fl}) @
@fname{dimacs_export} (@var{gr}, @var{fl}, @var{comment1}, ..., @var{commentn})

Exports the graph into the file @var{fl} in the DIMACS format. Optional
comments will be added to the top of the file.

@opencatbox
@category{Package graphs} @category{Package graphs - io}
@closecatbox
@end deffn

@anchor{dimacs_import}
@deffn {Function} dimacs_import (@var{fl})

Returns the graph from file @var{fl} in the DIMACS format.

@opencatbox
@category{Package graphs} @category{Package graphs - io}
@closecatbox
@end deffn

@anchor{graph6_decode}
@deffn {Function} graph6_decode (@var{str})

Returns the graph encoded in the graph6 format in the string @var{str}.

@opencatbox
@category{Package graphs} @category{Package graphs - io}
@closecatbox
@end deffn

@anchor{graph6_encode}
@deffn {Function} graph6_encode (@var{gr})

Returns a string which encodes the graph @var{gr} in the graph6 format.

@opencatbox
@category{Package graphs} @category{Package graphs - io}
@closecatbox
@end deffn

@anchor{graph6_export}
@deffn {Function} graph6_export (@var{gr_list}, @var{fl})

Exports graphs in the list @var{gr_list} to the file @var{fl} in the
graph6 format.

@opencatbox
@category{Package graphs} @category{Package graphs - io}
@closecatbox
@end deffn

@anchor{graph6_import}
@deffn {Function} graph6_import (@var{fl})

Returns a list of graphs from the file @var{fl} in the graph6 format.

@opencatbox
@category{Package graphs} @category{Package graphs - io}
@closecatbox
@end deffn

@anchor{sparse6_decode}
@deffn {Function} sparse6_decode (@var{str})

Returns the graph encoded in the sparse6 format in the string @var{str}.

@opencatbox
@category{Package graphs} @category{Package graphs - io}
@closecatbox
@end deffn

@anchor{sparse6_encode}
@deffn {Function} sparse6_encode (@var{gr})

Returns a string which encodes the graph @var{gr} in the sparse6 format.

@opencatbox
@category{Package graphs} @category{Package graphs - io}
@closecatbox
@end deffn

@anchor{sparse6_export}
@deffn {Function} sparse6_export (@var{gr_list}, @var{fl})

Exports graphs in the list @var{gr_list} to the file @var{fl} in the
sparse6 format.

@opencatbox
@category{Package graphs} @category{Package graphs - io}
@closecatbox
@end deffn

@anchor{sparse6_import}
@deffn {Function} sparse6_import (@var{fl})

Returns a list of graphs from the file @var{fl} in the sparse6 format.

@opencatbox
@category{Package graphs} @category{Package graphs - io}
@closecatbox
@end deffn

@subsection Visualization

@anchor{draw_graph}
@deffn {Function} draw_graph @
@fname{draw_graph} (@var{graph}) @
@fname{draw_graph} (@var{graph}, @var{option1}, ..., @var{optionk})

Draws the graph using the @ref{draw-pkg} package.

The algorithm used to position vertices is specified by the optional
argument @var{program}. The default value is
@code{program=spring_embedding}. @var{draw_graph} can also use the
graphviz programs for positioning vertices, but graphviz must be
installed separately.

Example 1:

@c ===beg===
@c load ("graphs")$
@c g:grid_graph(10,10)$
@c m:max_matching(g)$
@c draw_graph(g,
@c    spring_embedding_depth=100,
@c    show_edges=m, edge_type=dots,
@c    vertex_size=0)$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g:grid_graph(10,10)$
(%i3) m:max_matching(g)$
(%i4) draw_graph(g,
   spring_embedding_depth=100,
   show_edges=m, edge_type=dots,
   vertex_size=0)$
@end example

@ifhtml
@image{figures/graphs09,6cm}
@end ifhtml

Example 2:

@c ===beg===
@c load ("graphs")$
@c g:create_graph(16,
@c     [
@c      [0,1],[1,3],[2,3],[0,2],[3,4],[2,4],
@c      [5,6],[6,4],[4,7],[6,7],[7,8],[7,10],[7,11],
@c      [8,10],[11,10],[8,9],[11,12],[9,15],[12,13],
@c      [10,14],[15,14],[13,14]
@c     ])$
@c t:minimum_spanning_tree(g)$
@c draw_graph(
@c     g,
@c     show_edges=edges(t),
@c     show_edge_width=4,
@c     show_edge_color=green,
@c     vertex_type=filled_square,
@c     vertex_size=2
@c     )$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g:create_graph(16,
    [
     [0,1],[1,3],[2,3],[0,2],[3,4],[2,4],
     [5,6],[6,4],[4,7],[6,7],[7,8],[7,10],[7,11],
     [8,10],[11,10],[8,9],[11,12],[9,15],[12,13],
     [10,14],[15,14],[13,14]
    ])$
(%i3) t:minimum_spanning_tree(g)$
(%i4) draw_graph(
    g,
    show_edges=edges(t),
    show_edge_width=4,
    show_edge_color=green,
    vertex_type=filled_square,
    vertex_size=2
    )$
@end example

@ifhtml
@image{figures/graphs10,6cm}
@end ifhtml

Example 3:

@c ===beg===
@c load ("graphs")$
@c g:create_graph(16,
@c     [
@c      [0,1],[1,3],[2,3],[0,2],[3,4],[2,4],
@c      [5,6],[6,4],[4,7],[6,7],[7,8],[7,10],[7,11],
@c      [8,10],[11,10],[8,9],[11,12],[9,15],[12,13],
@c      [10,14],[15,14],[13,14]
@c     ])$
@c mi : max_independent_set(g)$
@c draw_graph(
@c     g,
@c     show_vertices=mi,
@c     show_vertex_type=filled_up_triangle,
@c     show_vertex_size=2,
@c     edge_color=cyan,
@c     edge_width=3,
@c     show_id=true,
@c     text_color=brown
@c     )$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) g:create_graph(16,
    [
     [0,1],[1,3],[2,3],[0,2],[3,4],[2,4],
     [5,6],[6,4],[4,7],[6,7],[7,8],[7,10],[7,11],
     [8,10],[11,10],[8,9],[11,12],[9,15],[12,13],
     [10,14],[15,14],[13,14]
    ])$
(%i3) mi : max_independent_set(g)$
(%i4) draw_graph(
    g,
    show_vertices=mi,
    show_vertex_type=filled_up_triangle,
    show_vertex_size=2,
    edge_color=cyan,
    edge_width=3,
    show_id=true,
    text_color=brown
    )$
@end example

@ifhtml
@image{figures/graphs11,6cm}
@end ifhtml

Example 4:

@c ===beg===
@c load ("graphs")$
@c net : create_graph(
@c     [0,1,2,3,4,5],
@c     [
@c      [[0,1], 3], [[0,2], 2],
@c      [[1,3], 1], [[1,4], 3],
@c      [[2,3], 2], [[2,4], 2],
@c      [[4,5], 2], [[3,5], 2]
@c     ],
@c     directed=true
@c     )$
@c draw_graph(
@c     net,
@c     show_weight=true,
@c     vertex_size=0,
@c     show_vertices=[0,5],
@c     show_vertex_type=filled_square,
@c     head_length=0.2,
@c     head_angle=10,
@c     edge_color="dark-green",
@c     text_color=blue
@c     )$
@c ===end===
@example
(%i1) load ("graphs")$
(%i2) net : create_graph(
    [0,1,2,3,4,5],
    [
     [[0,1], 3], [[0,2], 2],
     [[1,3], 1], [[1,4], 3],
     [[2,3], 2], [[2,4], 2],
     [[4,5], 2], [[3,5], 2]
    ],
    directed=true
    )$
(%i3) draw_graph(
    net,
    show_weight=true,
    vertex_size=0,
    show_vertices=[0,5],
    show_vertex_type=filled_square,
    head_length=0.2,
    head_angle=10,
    edge_color="dark-green",
    text_color=blue
    )$
@end example

@ifhtml
@image{figures/graphs12,6cm}
@end ifhtml

Example 5:

@c ===beg===
@c load("graphs")$
@c g: petersen_graph(20, 2);
@c draw_graph(g, redraw=true, program=planar_embedding);
@c ===end===
@example
(%i1) load("graphs")$
(%i2) g: petersen_graph(20, 2);
(%o2)                         GRAPH
(%i3) draw_graph(g, redraw=true, program=planar_embedding);
(%o3)                         done
@end example

@ifhtml
@image{figures/graphs14,6cm}
@end ifhtml

Example 6:

@c ===beg===
@c load("graphs")$
@c t: tutte_graph();
@c draw_graph(t, redraw=true, 
@c               fixed_vertices=[1,2,3,4,5,6,7,8,9]);
@c ===end===
@example
(%i1) load("graphs")$
(%i2) t: tutte_graph();
(%o2)                         GRAPH
(%i3) draw_graph(t, redraw=true, 
                    fixed_vertices=[1,2,3,4,5,6,7,8,9]);
(%o3)                         done
@end example

@ifhtml
@image{figures/graphs15,6cm}
@end ifhtml

@opencatbox
@category{Package graphs}
@closecatbox
@end deffn

@anchor{draw_graph_program}
@defvr {Option variable} draw_graph_program
Default value: @var{spring_embedding}

The default value for the program used to position vertices in
@code{draw_graph} program.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_id}
@defvr {draw_graph option} show_id
Default value: @var{false}

If @var{true} then ids of the vertices are displayed.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_label}
@defvr {draw_graph option} show_label
Default value: @var{false}

If @var{true} then labels of the vertices are displayed.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{label_alignment_graphs}
@defvr {draw_graph option} label_alignment
Default value: @var{center}

Determines how to align the labels/ids of the vertices. Can
be @code{left}, @code{center} or @code{right}.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_weight }
@defvr {draw_graph option} show_weight 
Default value: @var{false}

If @var{true} then weights of the edges are displayed.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{vertex_type}
@defvr {draw_graph option} vertex_type
Default value: @var{circle}

Defines how vertices are displayed. See the @var{point_type} option for
the @code{draw} package for possible values.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{vertex_size}
@defvr {draw_graph option} vertex_size
The size of vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{vertex_color }
@defvr {draw_graph option} vertex_color 
The color used for displaying vertices.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_vertices}
@defvr {draw_graph option} show_vertices
Default value: []

Display selected vertices in the using a different color.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_vertex_type}
@defvr {draw_graph option} show_vertex_type
Defines how vertices specified in @var{show_vertices} are displayed.
See the @var{point_type} option for the @code{draw} package for possible
values.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_vertex_size}
@defvr {draw_graph option} show_vertex_size
The size of vertices in @var{show_vertices}.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_vertex_color }
@defvr {draw_graph option} show_vertex_color 
The color used for displaying vertices in the @var{show_vertices} list.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{vertex_partition}
@defvr {draw_graph option} vertex_partition
Default value: []

A partition @code{[[v1,v2,...],...,[vk,...,vn]]} of the vertices of the
graph. The vertices of each list in the partition will be drawn in a
different color.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{vertex_coloring_variable}
@defvr {draw_graph option} vertex_coloring
Specifies coloring of the vertices. The coloring @var{col} must be
specified in the format as returned by @var{vertex_coloring}.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{edge_color }
@defvr {draw_graph option} edge_color 
The color used for displaying edges.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{edge_width}
@defvr {draw_graph option} edge_width
The width of edges.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{edge_type}
@defvr {draw_graph option} edge_type
Defines how edges are displayed. See the @var{line_type} option for the
@code{draw} package.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_edges}
@defvr {draw_graph option} show_edges
Display edges specified in the list @var{e_list} using a different
color.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_edge_color}
@defvr {draw_graph option} show_edge_color
The color used for displaying edges in the @var{show_edges} list.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_edge_width}
@defvr {draw_graph option} show_edge_width
The width of edges in @var{show_edges}.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{show_edge_type}
@defvr {draw_graph option} show_edge_type
Defines how edges in @var{show_edges} are displayed. See the
@var{line_type} option for the @code{draw} package.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{edge_partition}
@defvr {draw_graph option} edge_partition
A partition @code{[[e1,e2,...],...,[ek,...,em]]} of edges of the
graph. The edges of each list in the partition will be drawn using a
different color.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{edge_coloring_variable}
@defvr {draw_graph option} edge_coloring
The coloring of edges. The coloring must be specified in the
format as returned by the function @var{edge_coloring}.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{redraw }
@defvr {draw_graph option} redraw 
Default value: @var{false}

If @code{true}, vertex positions are recomputed even if the positions
have been saved from a previous drawing of the graph.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{head_angle_graphs}
@defvr {draw_graph option} head_angle
Default value: 15

The angle for the arrows displayed on arcs (in directed graphs).

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{head_length_graphs}
@defvr {draw_graph option} head_length
Default value: 0.1

The length for the arrows displayed on arcs (in directed graphs).

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{spring_embedding_depth}
@defvr {draw_graph option} spring_embedding_depth
Default value: 50

The number of iterations in the spring embedding graph drawing
algorithm.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{terminal_graphs}
@defvr {draw_graph option} terminal
The terminal used for drawing (see the @var{terminal} option in the
@code{draw} package).

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{file_name_graphs}
@defvr {draw_graph option} file_name
The filename of the drawing if terminal is not screen.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{program}
@defvr {draw_graph option} program
Defines the program used for positioning vertices of the graph. Can be
one of the graphviz programs (dot, neato, twopi, circ, fdp),
@var{circular}, @var{spring_embedding} or
@var{planar_embedding}. @var{planar_embedding} is only available for
2-connected planar graphs. When @code{program=spring_embedding}, a set
of vertices with fixed position can be specified with the
@var{fixed_vertices} option.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{fixed_vertices}
@defvr {draw_graph option} fixed_vertices
Specifies a list of vertices which will have positions fixed along a regular polygon.
Can be used when @code{program=spring_embedding}.

@opencatbox
@category{Package graphs} @category{Package graphs - draw_graphs options}
@closecatbox
@end defvr

@anchor{vertices_to_path}
@deffn {Function} vertices_to_path (@var{v_list})
Converts a list @var{v_list} of vertices to a list of edges of the path
defined by @var{v_list}.

@opencatbox
@category{Package graphs}
@closecatbox
@end deffn

@anchor{vertices_to_cycle}
@deffn {Function} vertices_to_cycle (@var{v_list})
Converts a list @var{v_list} of vertices to a list of edges of the cycle
defined by @var{v_list}.

@opencatbox
@category{Package graphs}
@closecatbox
@end deffn
