from collections import deque
import sys

def search(i, j, n, m, paths, vis):
    while(True):
        if((paths[i][j] == 1) or paths[i][j] == -1):
            return paths[i][j]
        
        elif (paths[i][j]  == 2):
            return -1
        
        else:
            if(paths[i][j] == 'U'):
                if(i == 0):
                    return 1
                else:
                    vis.append(j)
                    vis.append(i)
                    paths[i][j] = 2
                    i = i - 1

            elif(paths[i][j] == 'D'):
                if(i == n-1):
                    return 1
                else:
                    vis.append(j)
                    vis.append(i)
                    paths[i][j] = 2
                    i = i + 1

            elif(paths[i][j] == 'L'):
                if(j == 0):
                    return 1
                else:
                    vis.append(j)
                    vis.append(i)
                    paths[i][j] = 2
                    j = j - 1

            elif(paths[i][j] == 'R'):
                if(j == m - 1):
                    return 1
                else:
                    vis.append(j)
                    vis.append(i)
                    paths[i][j] = 2
                    j = j + 1

def looprooms():
    file = open(sys.argv[1], 'r')
    firstline = file.readline()
    n , m = map(int,firstline.split())
    paths = [list(line.strip()) for line in file]
    file.close()

    counter = 0
    vis = deque([])

    for i in range(0, n):
        for j in range(0, m):
            paths[i][j] = search(i, j, n, m, paths, vis)

            reps = len(vis)//2
            if(paths[i][j] == -1):
                counter = counter + reps
                
            for k in range(reps):
                paths[vis.pop()][vis.pop()] = paths[i][j]

    print(counter)

looprooms()