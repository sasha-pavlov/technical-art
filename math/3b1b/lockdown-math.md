# 3Blue1Brown's Lockdown Math

Notes from [3Blue1Brown's Lockdown Math](https://www.youtube.com/playlist?list=PLZHQObOWTQDP5CVelJJ1bNDouqrAhVPev) YouTube live lectures.

Uses `Markdown + Math` VSCode extension.

Resource: LATEX Math [cheatsheet](http://tug.ctan.org/info/undergradmath/undergradmath.pdf).

- [3Blue1Brown's Lockdown Math](#3blue1browns-lockdown-math)
  - [Key takeaways](#key-takeaways)
  - [1: The simpler quadratic formula](#1-the-simpler-quadratic-formula)
    - [The product as a difference of squares](#the-product-as-a-difference-of-squares)
    - [Factoring quadratics](#factoring-quadratics)
    - [Sum of squares](#sum-of-squares)
  - [2: Trigonometry fundamentals](#2-trigonometry-fundamentals)
    - [Walking around the unit circle](#walking-around-the-unit-circle)
    - [Converting between Triangle-trig and Circle-trig](#converting-between-triangle-trig-and-circle-trig)
      - [Tangent](#tangent)
    - [Pythagorean theorem](#pythagorean-theorem)
    - [Squared (co)sines](#squared-cosines)


## Key takeaways

1. There are different ways to represent the same data. Learn connections between different representations to solve problems efficiently.
2. When faced with a new formula, try graphing it (ex. [Desmos](https://www.desmos.com/calculator)).
3. When faced with trig, try drawing various circles and triangles.

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

## 2: Trigonometry fundamentals

### Walking around the unit circle
Starting at $(1,0)$ on the unit circle, with a tether tied to the center of the circle forming an angle $\theta$ relative to the start-position, and walking counter-clockwise:
- $\sin(\theta)$ is the distance from the $x$-axis
- $\cos(\theta)$ is the distance from the $y$-axis
- One full circuit is $2\pi$ long

### Converting between Triangle-trig and Circle-trig
Triangle trigonometry: `SOH CAH TOA`
- $\sin(\theta)=o/h$
- $\cos(\theta)=a/h$
- $\tan(\theta)=o/a$

To instead work with the unit circle, scale the length of each side of the triangle by $\frac{1}{h}$ so that the hypotenuse is one unit long: $h=1$. Now,
- $y=\sin(\theta)=\frac{1}{h}o$
- $x=\cos(\theta)=\frac{1}{h}a$

#### Tangent
`Projecting new right-angle triangles:` If we set the $1$-magnitude side to be the adjacent, with the hypotenuse lying atop the x-axis, the tangent is the opposite length. The opposite side is perpendicular to the $1$-magnitude adjacent, at the edge of the unit circle, "tangential" to the curve at that point.

Notice that walking around the unit circle, the length of the tangent:
- at $(1,0)$, $\tan(0) = 0$
- at $(0,1)$, $\tan(\frac{\pi}{2}) \approx \inf$

### Pythagorean theorem
From the side lengths of the "unit-hypotenuse triangle" above,
$$
h = x^2 + y^2 \\
1 = \cos^2(\theta) + \sin^2(\theta)
$$

Clearly we can use the Pythagorean theorem to derive the trig identity above, but we can also use basic trig to derive the Pythagorean theorem, as shown below.

### Squared (co)sines
Both sinusoidal and exponential equations (ex. $f(x)=2^x$) have the interesting property of $f(2x) \approx (f(x))^2$.

Ex. the following trig identity:
$$
\cos^2(\theta) = \frac{\cos(2\theta)+1}{2}
$$

`Projecting new right-angle triangles:` For any triangle in the unit circle, take the adjacent and use it as the hypotenuse $h'$. Then,
$$
\cos(\theta) = a'/h' \\
= a'/\cos(\theta) \\
\Rightarrow a'=\cos^2(\theta)
$$

Now take the remaining length of the original hypotenuse $h$: $o'=h-a'$. Use the original opposite as the hypotenuse $h''$.
$$
\sin(\theta) = o'/h'' \\
= a'/\sin(\theta) \\
\Rightarrow o'=\sin^2(\theta)
$$

Proving the Pythagorean theorem: $1=h=a'+o'=\cos^2(\theta)+\sin^2(\theta)=x^2+y^2$.

![https://youtu.be/yBw67Fb31Cs?list=PLZHQObOWTQDP5CVelJJ1bNDouqrAhVPev&t=4181](img/squared-cosines.PNG "Squared (co)sines")