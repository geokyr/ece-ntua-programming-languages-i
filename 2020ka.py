def has_edge_mat(m, u, v):
    return True if m[u][v] else False

def adj_mat_list(m):
    n = len(m)
    g = {}
    for i in range(n):
        s = set()
        for j in range(n):
            if m[i][j]:
                s.add(j)
        g[i] = s
    return g

def has_edge_list(g, u, v):
    return True if (v in g[u]) else False

m = [[0, 0, 1], [0, 0, 1], [1, 1, 0]]
print(adj_mat_list(m))

print(has_edge_list(adj_mat_list(m), 0, 1),
      has_edge_list(adj_mat_list(m), 0, 2),
      has_edge_list(adj_mat_list(m), 1, 0),
      has_edge_list(adj_mat_list(m), 1, 2),
      has_edge_list(adj_mat_list(m), 2, 0),
      has_edge_list(adj_mat_list(m), 2, 1))