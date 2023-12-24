--[=[
import numpy as np
import sys

hs = []
for line in sys.stdin.readlines():
  ps, vs = line.rstrip().split(' @ ')
  px, py, pz = list(map(int, ps.split(', ')))
  vx, vy, vz = list(map(int, vs.split(', ')))
  hs.append((np.array([px, py, pz]), np.array([vx, vy, vz])))
n = len(hs)

# condition of A is bad
p1, v1 = hs[2]
p2, v2 = hs[3]
p3, v3 = hs[4]

dv21 = v2 - v1
dp12 = p1 - p2

dv31 = v3 - v1
dp13 = p1 - p3

A = np.array([
  [0, -dv21[2], dv21[1],   0, -dp12[2], dp12[1]],
  [dv21[2], 0, -dv21[0],   dp12[2], 0, -dp12[0]],
  [-dv21[1], dv21[0], 0,   -dp12[1], dp12[0], 0],

  [0, -dv31[2], dv31[1],   0, -dp13[2], dp13[1]],
  [dv31[2], 0, -dv31[0],   dp13[2], 0, -dp13[0]],
  [-dv31[1], dv31[0], 0,   -dp13[1], dp13[0], 0]
])

b1 = np.cross(-v1, p1) + np.cross(v2, p2)
b2 = np.cross(-v1, p1) + np.cross(v3, p3)
b = np.array([b1[0], b1[1], b1[2], b2[0], b2[1], b2[2]])

print(round(sum(np.linalg.solve(A, b)[:3])))
]=]--

