def equal_list(a, b):
    if len(a) != len(b):
        return False

    s = set()
    for i in a:
        s.add(i)
    for i in b:
        if i not in s:
            return False
    return True

a = [1, 2, 3]
b = [2, 3, 1]
c = [3, 1, 2]
d = [1, 2, 4]
e = [1, 4, 2]
f = [1, 3, 1, 2]
g = [1, 2, 3, 1, 2, 3]

print(equal_list(a, b),
      equal_list(a, c),
      equal_list(a, d),
      equal_list(a, e),
      equal_list(a, f),
      equal_list(a, g),
      equal_list(b, c),
      equal_list(b, d),
      equal_list(d, e),
      equal_list(f, g))

# https://stackoverflow.com/questions/38924421/is-there-a-standard-way-to-partition-an-interable-into-equivalence-classes-given

def partition(a):
    partitions = [] # Found partitions
    for e in a: # Loop over each element
        found = False # Note it is not yet part of a know partition
        for p in partitions:
            if equal_list(e, p[0]): # Found a partition for it!
                p.append(e)
                found = True
                break
        if not found: # Make a new partition for it.
            partitions.append([e])
    return partitions

k = [[1,2,3], [1,4,2], [2,3,1]]
l = [[1, 2, 3], [2, 3, 1], [3, 1, 2],
     [1, 2, 4], [1, 4, 2], [1, 3, 1, 2],
     [1, 2, 3, 1, 2, 3]]
m = [[1, 2, 3], [2, 3, 1], [3, 1, 2],
     [1, 2, 4], [1, 4, 2], [1, 3, 1, 2],
     [1, 2, 3, 1, 2, 3], [5, 6, 7],
     [6, 5, 7], [5, 6, 5], [1, 4, 1],
     [1, 4, 4, 3], [3, 1, 4, 4]]
n = [[1, 2, 3], [2, 3, 1], [3, 1, 2],
     [1, 2, 4], [1, 4, 2], [1, 3, 1, 2],
     [1, 2, 3, 1, 2, 3], [5, 6, 7], 
     [6, 5, 7], [5, 6, 5], [1, 4, 1],
     [1, 4, 4, 6], [3, 1, 4, 5]]

print(len(partition(k)),
      len(partition(l)),
      len(partition(m)),
      len(partition(n)))