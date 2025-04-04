import heapq

graph = {
    "Pulpar Mosjid (Home)": [("Sankar Bus Stand", 0.7), ("Mohammadpur Bus Stand", 1.1)],
    "Sankar Bus Stand": [("Rapa Plaza", 1.2), ("Dhanmondi 32 Mirpur Road", 1.8), ("City College", 2.3)],
    "Mohammadpur Bus Stand": [("Rapa Plaza", 2.2), ("Asad Gate Police Box", 2.6)],
    "Rapa Plaza": [("Panthapath Signal", 1.6), ("Khamar Bari Gol Chattar", 1.5)],
    "Dhanmondi 32 Mirpur Road": [("Panthapath Signal", 1.1), ("Khamar Bari Gol Chattar", 1.5)],
    "City College": [("Panthapath Signal", 1.4)],
    "Asad Gate Police Box": [("Khamar Bari Gol Chattar", 1.2)],
    "Panthapath Signal": [("UAP", 0.5)],
    "Khamar Bari Gol Chattar": [("UAP", 2.9)],
    "UAP": []
}

# Updated admissible and consistent heuristics
heuristics = {
    "Pulpar Mosjid (Home)": 4,
    "Sankar Bus Stand": 3.3,
    "Mohammadpur Bus Stand": 5,
    "Rapa Plaza": 2.1,
    "Dhanmondi 32 Mirpur Road": 2.5,
    "City College": 2.5,
    "Asad Gate Police Box": 4,
    "Panthapath Signal": 0.5,
    "Khamar Bari Gol Chattar": 3,
    "UAP": 0
}

def a_star(start, goal):
    pq = []
    heapq.heappush(pq, (heuristics[start], 0, start, []))  # (f = g + h, g, node, path)
    visited = {}

    while pq:
        f, g, node, path = heapq.heappop(pq)

        if node == goal:
            return path + [node], g

        if node in visited and visited[node] <= g:
            continue

        visited[node] = g

        for neighbor, cost in graph[node]:
            g_new = g + cost
            f_new = g_new + heuristics[neighbor]
            heapq.heappush(pq, (f_new, g_new, neighbor, path + [node]))

    return None, float('inf')

# Run the algorithm
path, cost = a_star("Pulpar Mosjid (Home)", "UAP")
print("Optimal Path:", " -> ".join(path))
print("Optimal Path Cost:", cost)
