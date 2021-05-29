import sys
from collections import deque

def isSorted(l):
    for i in range(0, len(l) - 1):
        if l[i] > l[i+1]:
            return False
    return True

file = open(sys.argv[1], 'r')
n = int(file.readline().strip())
#queue = file.readline().split() 
queue = list(map(int, file.readline().split()))
file.close()

stack = []
init = (queue, stack, '')

def next(a): #s = (queue, stack, 'path')
    for j in range(2):
        if(j == 0 and a[0]):
            q = a[0][1:]
            s = a[1][:] + [a[0][0]]
            p = a[2] + 'Q'
            yield(q, s, p)
        elif(j == 1 and a[1]):
            s = a[1][:-1]
            q = a[0][:] + [a[1][-1]]
            p = a[2] + 'S'
            yield(q, s, p)

Q = deque([init])
hq = ' '.join(map(str, queue))
hs = ' '.join(map(str, stack))
hq = hash(hq)
hs = hash(hs)
visited = {(hq, hs)}
solved = False

while Q:
    s = Q.popleft()
    if(isSorted(s[0]) and len(s[0]) == n):
        solved = True
        break
    else:
        for t in next(s):
            hq = ' '.join(map(str, t[0]))
            hs = ' '.join(map(str, t[1]))
            hq = hash(hq)
            hs = hash(hs)
            if ((hq, hs) not in visited):
                Q.append(t)
                visited.add((hq, hs))

if solved:
    if(s[2]):
            print(s[2])
    else:
        print("empty")