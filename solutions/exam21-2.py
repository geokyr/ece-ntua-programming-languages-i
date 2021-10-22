# {
#     "set": ["sdasda", "dadas"]
# }

def constructor(word):
    s = set()
    for i in word:
        s.add(i)
    return frozenset(s)

input = input("Give input:")
splitted = input.split()
d = {}
for word in splitted:
    if(constructor(word) in d):
        if(word not in d[constructor(word)]):
            d[constructor(word)] += [word]
    else:
        d[constructor(word)] = [word]
        
max = 0 
for entry in d.values():
    if(len(entry) > max):
        print(len(entry), entry)
        max = len(entry)

for entry in d.values():
    if(len(entry) == max):
        print(entry)

print(len(d), max)

# s = set(["a", "b"])
# sn = frozenset(s)
# d = {sn:"Hello"}
# print(s)