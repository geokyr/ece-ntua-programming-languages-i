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

print(equal_list(a, b))
print(equal_list(a, c))
print(equal_list(a, d))
print(equal_list(a, e))
print(equal_list(a, f))
print(equal_list(a, g))
print(equal_list(b, c))
print(equal_list(b, d))
print(equal_list(d, e))
print(equal_list(f, g))

# https://stackoverflow.com/questions/38924421/is-there-a-standard-way-to-partition-an-interable-into-equivalence-classes-given

def partition(a, equiv):
    partitions = [] # Found partitions
    for e in a: # Loop over each element
        found = False # Note it is not yet part of a know partition
        for p in partitions:
            if equiv(e, p[0]): # Found a partition for it!
                p.append(e)
                found = True
                break
        if not found: # Make a new partition for it.
            partitions.append([e])
    return partitions

k = [[1,2,3], [1,4,2], [2,3,1]]
l = [[1, 2, 3], [2, 3, 1], [3, 1, 2], [1, 2, 4], [1, 4, 2], 
     [1, 3, 1, 2], [1, 2, 3, 1, 2, 3]]
m = [[1, 2, 3], [2, 3, 1], [3, 1, 2], [1, 2, 4], [1, 4, 2], 
     [1, 3, 1, 2], [1, 2, 3, 1, 2, 3], [5, 6, 7], [6, 5, 7], [5, 6, 5],
     [1, 4, 1], [1, 4, 4, 3], [3, 1, 4, 4]]
n  = [[1, 2, 3], [2, 3, 1], [3, 1, 2], [1, 2, 4], [1, 4, 2], 
     [1, 3, 1, 2], [1, 2, 3, 1, 2, 3], [5, 6, 7], [6, 5, 7], [5, 6, 5],
     [1, 4, 1], [1, 4, 4, 6], [3, 1, 4, 5]]

print(len(partition(k, equal_list)), len(partition(l, equal_list)),
      len(partition(m, equal_list)), len(partition(n, equal_list)))
