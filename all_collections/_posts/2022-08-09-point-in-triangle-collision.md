---
layout: post
title: Point -> Triangle Collision
date: 2022-08-09 10:18:00
categories: [Math]
---

# Detect collsion between Point (e.g. Mouse) with a Triangle (3 Points)

![Point to Triangle Collision](/assets/img/Point-in-Triangle-collision.png)

To detect a collision between an point and a triangle we need to calculate some areas

## Area of a Triangle

First we need to calculate the area of the original triangle with the Heron's Formula

```pseudo
F = sqrt(s(s-a)(s-b)(s-c))
s = (a+b+c)/2
```

where a,b,c are the sides of the triangle and s is the semiperimeter

## Area of each Triangle with the Point

Now we calculate the 3 areas with the Point and the Triangle. The Area's are: ABP, ACP and BCP.

```pseudo
BCP = abs((Bx-Px)*(Cy-Py) - (By-Py)*(Cx-Px))
ACP = abs((Ax-Px)*(Cy-Py) - (Ay-Py)*(Cx-Px))
ABP = abs((Ax-Px)*(By-Py) - (Ay-Py)*(Bx-Px))
```

## Check if the Point is inside the Triangle

Now we check if the Point is inside the Triangle by checking if the sum of the 3 areas is equal to the area of the original triangle.

```python
if (ABP + ACP + BCP) == F:
return True
else:
return False
```
