import sys
from collections import deque

def isSorted(l):
    l = list(map(int, l))
    for i in range(0, len(l) - 1):
        if l[i] > l[i+1]:
            return False
    return True

def next(a):
    for i in range(2):
        if(i == 0 and a[0]):
            q = a[0][1:]
            s = a[1][:] + (a[0][0],)
            p = a[2] + 'Q'
            yield(q, s, p)
        elif(i == 1 and a[1]):
            s = a[1][:-1]
            q = a[0][:] + (a[1][-1],)
            p = a[2] + 'S'
            yield(q, s, p)

file = open(sys.argv[1], 'r')
n = int(file.readline().strip())
queue = tuple(list(map(int, file.readline().split())))
file.close()

stack = ()
init = (queue, stack, '')

Q = deque([init])
visited = {hash((queue, stack))}
solved = False

while Q:
    s = Q.popleft()
    if(isSorted(s[0]) and len(s[0]) == n):
        solved = True
        break
    else:
        for t in next(s):
            h = hash((t[0], t[1]))
            if(h not in visited):
                Q.append(t)
                visited.add(h)

if solved:
    if(s[2]):
        print(s[2])
    else:
        print("empty")