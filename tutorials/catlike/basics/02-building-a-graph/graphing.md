# Graphing

Graphs are visualizations of function behaviour; they which assign input(s) and output(s) to different axes, and then plot points where a function maps input(s) to output(s).

## Scene setup

To view the scene on a notebook-like 2D grid, remove scene effects (ex. skybox) and toggle the view to orthographic. Grid lines are spaced 1 unit apart.

![https://catlikecoding.com/unity/tutorials/basics/building-a-graph/creating-a-line-of-cubes/y-equals-x-squared.png](../img/y-equals-x-squared.png "Grid-like Unity scene view")

## Build a graph

Visualize a function by vertex location ("point coordinates"). The graph is a Csharp script that uses a `point` prefab to graph points:

- $x$-position determined by the `domain` (min/max $x$-values) and `resolution` (density of points)
- $y = f(x,t)$-position is a function of $x$-position and (optionally) time

## Shade a graph

Visualize a function by fragment shading ("point appearance"). The position-controlling script above determines the `world position` of each point. In the shader program, a vertex position vector can be used to set albedo, for example by setting the red-component with $x$ and the green-component with $y$.

![https://catlikecoding.com/unity/tutorials/basics/building-a-graph/animating-the-graph/sin-pix.png](../img/sin-graph.png "Graph of y=sin(x) in Unity")

## Reuse a graph

Behaviour configured in `Update()` can be modified without exiting play mode.

### Serialize behaviour

Make function being graphed a serialized `enum` to swap between functions in Unity's `Inspector` while in play mode.

### Hot reload

Modify code while in play mode to trigger a recompilation of scripts followed by a resumption of the game state.

## Waves

Graph $y = c_{amp} \sin{(c_{freq}(x + t))}$ to animate waves.

Some ways to modify wave form (see `FunctionLibrary.cs` for examples):
| Function              | Effect                                                             |
| :-------------------- | :----------------------------------------------------------------- |
| $y=\sin{x}$           | _stationary_ wave                                                  |
| $y=\sin{2x}$          | stationary wave with twice the _frequency_                         |
| $y=2\sin{x}$          | stationary wave with twice the _amplitude_                         |
| $y=\sin{\mid x \mid}$ | stationary wave _mirrored_ at origin                               |
| $y=x \sin{x}$         | stationary wave increases in _amplitude with distance_ from origin |
| $y=\sin{(x + t)}$     | animated wave flows _rightwards_                                   |
| $y=\sin{(x - t)}$     | animated wave flows _leftwards_                                    |

Waves can also be added together to produce a variety of effects, for example:
- $y = \sin{(x+t)} + \sin{x}$ yields a wave that _bounces_ between high-and low altitude extremes.
- $y = \sin{(x+t)} + \frac{\sin{2(x+t)}}{2}$ yields a consistent, multi-curved wave, like a _heartbeat_, since both components share a frequency.
  - Adding together differentially-frequent waves yields complex, _morphing_ waves with longer periods.