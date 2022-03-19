# 3Blue1Brown's Lockdown Math

Notes from [3Blue1Brown's Lockdown Math](https://www.youtube.com/playlist?list=PLZHQObOWTQDP5CVelJJ1bNDouqrAhVPev) YouTube live lectures.

Uses `Markdown + Math` VSCode extension.

Resource: LATEX Math [cheatsheet](http://tug.ctan.org/info/undergradmath/undergradmath.pdf).

- [3Blue1Brown's Lockdown Math](#3blue1browns-lockdown-math)
  - [1: The simpler quadratic formula](#1-the-simpler-quadratic-formula)
    - [The product as a difference of squares](#the-product-as-a-difference-of-squares)
    - [Factoring quadratics](#factoring-quadratics)
    - [Sum of squares](#sum-of-squares)
    - [Key takeaway](#key-takeaway)

## 1: The simpler quadratic formula

### The product as a difference of squares

Every product of 2 numbers $r, s$ can be represented as a difference of squares.
$$
rs = (m-d)(m+d) \\
   = m^2 - d^2
$$
$m,d$ are the average and standard deviation, respectively.
$$
m = (r+s)/2 \\
d = |m - r| = |m - s|
$$

### Factoring quadratics

Any $f(x) = ax^2 - bx + c$ can be factored into an equivalent representation $f(x) = (x-r)(x-s)$. The roots $r,s$ are the values of x for which $f(x) = y = 0$. Thus they represent coordinates for the intersection of the parabola with the $x$-axis.

Setting $f(x) = 0$:
$$
0 = (x-r)(x-s) \\
= ax^2 - bx + c \\
= x^2 - \frac{b}{a}x + \frac{c}{a} \\
= x^2 - \frac{r+s}{a} + \frac{rs}{a}
$$

From the definition of the average:
$$
r,s = m \pm d = m \pm \sqrt{m^2 - p}
$$
where
$$
m = \frac{r+s}{2} = -\frac{b}{2a} \\
p = rs = \frac{c}{a}
$$

### Sum of squares

Using complex numbers, every sum of squares $m^2 + d^2$ can be expressed as a difference of squares, and thus factored:
$$
m^2 + d^2 \\
= m^2 - (-1)d^2 \\
= m^2 - i^2d^2 \\
= (m + id)(m - id) \\
$$

### Key takeaway

There are different ways to represent the same data. Learn connections between different representations to solve problems efficiently.