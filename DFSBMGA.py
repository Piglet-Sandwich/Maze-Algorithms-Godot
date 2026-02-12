import random
class Maze:
    
    tiles1 = [
        ["⬜⬛⬜", "⬛🟩⬛", "⬜⬛⬜"],
        ["⬜⬜⬜", "⬛🟦⬛", "⬜⬛⬜"],
        ["⬜⬛⬜", "⬛🟦⬜", "⬜⬛⬜"],
        ["⬜⬜⬜", "⬛🟨⬜", "⬜⬛⬜"],
        ["⬜⬛⬜", "⬛🟦⬛", "⬜⬜⬜"],
        ["⬜⬜⬜", "⬛🟨⬛", "⬜⬜⬜"],
        ["⬜⬛⬜", "⬛🟨⬜", "⬜⬜⬜"],
        ["⬜⬜⬜", "⬛🟥⬜", "⬜⬜⬜"],
        ["⬜⬛⬜", "⬜🟦⬛", "⬜⬛⬜"],
        ["⬜⬜⬜", "⬜🟨⬛", "⬜⬛⬜"],
        ["⬜⬛⬜", "⬜🟨⬜", "⬜⬛⬜"],
        ["⬜⬜⬜", "⬜🟥⬜", "⬜⬛⬜"],
        ["⬜⬛⬜", "⬜🟨⬛", "⬜⬜⬜"],
        ["⬜⬜⬜", "⬜🟥⬛", "⬜⬜⬜"],
        ["⬜⬛⬜", "⬜🟥⬜", "⬜⬜⬜"],
        ["⬜⬜⬜", "⬜⬜⬜", "⬜⬜⬜"],
    ]
    tiles2 = [
        ["⬜⬛⬜", "⬛⬛⬛", "⬜⬛⬜"],
        ["⬜⬜⬜", "⬛⬛⬛", "⬜⬛⬜"],
        ["⬜⬛⬜", "⬛⬛⬜", "⬜⬛⬜"],
        ["⬜⬜⬜", "⬛⬛⬜", "⬜⬛⬜"],
        ["⬜⬛⬜", "⬛⬛⬛", "⬜⬜⬜"],
        ["⬜⬜⬜", "⬛⬛⬛", "⬜⬜⬜"],
        ["⬜⬛⬜", "⬛⬛⬜", "⬜⬜⬜"],
        ["⬜⬜⬜", "⬛⬛⬜", "⬜⬜⬜"],
        ["⬜⬛⬜", "⬜⬛⬛", "⬜⬛⬜"],
        ["⬜⬜⬜", "⬜⬛⬛", "⬜⬛⬜"],
        ["⬜⬛⬜", "⬜⬛⬜", "⬜⬛⬜"],
        ["⬜⬜⬜", "⬜⬛⬜", "⬜⬛⬜"],
        ["⬜⬛⬜", "⬜⬛⬛", "⬜⬜⬜"],
        ["⬜⬜⬜", "⬜⬛⬛", "⬜⬜⬜"],
        ["⬜⬛⬜", "⬜⬛⬜", "⬜⬜⬜"],
        ["⬜⬜⬜", "⬜⬜⬜", "⬜⬜⬜"],
    ]
    tiles3 = [
        ["⬜🟩⬜", "🟩🟩🟩", "⬜🟩⬜"],
        ["⬜⬜⬜", "🟦🟦🟦", "⬜🟦⬜"],
        ["⬜🟦⬜", "🟦🟦⬜", "⬜🟦⬜"],
        ["⬜⬜⬜", "🟨🟨⬜", "⬜🟨⬜"],
        ["⬜🟦⬜", "🟦🟦🟦", "⬜⬜⬜"],
        ["⬜⬜⬜", "🟨🟨🟨", "⬜⬜⬜"],
        ["⬜🟨⬜", "🟨🟨⬜", "⬜⬜⬜"],
        ["⬜⬜⬜", "🟥🟥⬜", "⬜⬜⬜"],
        ["⬜🟦⬜", "⬜🟦🟦", "⬜🟦⬜"],
        ["⬜⬜⬜", "⬜🟨🟨", "⬜🟨⬜"],
        ["⬜🟨⬜", "⬜🟨⬜", "⬜🟨⬜"],
        ["⬜⬜⬜", "⬜🟥⬜", "⬜🟥⬜"],
        ["⬜🟨⬜", "⬜🟨🟨", "⬜⬜⬜"],
        ["⬜⬜⬜", "⬜🟥🟥", "⬜⬜⬜"],
        ["⬜🟥⬜", "⬜🟥⬜", "⬜⬜⬜"],
        ["⬜⬜⬜", "⬜⬜⬜", "⬜⬜⬜"],
    ]
    tiles = tiles1
    sides = {
	str([0, 1]): 2, #1,  0
	str([0, -1]): 8,#-1, 0
	str([1, 0]): 4, #0,  1
	str([-1,0]): 1, #0, -1
	}

    #🟩 ⬜ ⬛ 🟥 🟧 🟦 🟨 🟪 🟫 🔳 🔲
    
    def __init__(self, size:int):
        self.size = size
        self.maze =  [[ "⬜⬜⬜" for a in range(size)] for b in range(size*3)]

    def print_maze(self):
        for i in range(self.size*3):
            for j in range(self.size):
                print(self.maze[i][j], end="")
            print()

    def print_tile(self, tile:list):
        for i in tile:
            print(i)

    def place_tile(self, typ: list, pos: list):
        r, c = pos
        for i, v in enumerate(typ):
            self.maze[r*3+i][c] = v

    def generate_maze(self):
        stack = []
        unvisited = []
        for r in range(self.size):
            for c in range(self.size):
                self.place_tile(self.tiles[15], [r, c])
                unvisited.append(self.get_tile([r, c]))
        current = self.get_tile([0, 0])
        while unvisited:
            """
            print("----------")
            print("Current: ", current)
            print("len(stack): ", len(stack), " stack: ", stack)
            print("len(unvisited): " , len(unvisited), " unvisited: ", unvisited)
            #Gets all the neighbors that are unvisited
            """
            neighbors = self.get_neighbors(current[2], unvisited)
            for i in unvisited:
                if current[2] in i:
                    unvisited.remove(i)
            if len(neighbors) > 0:
                stack.append(current)
                nex = neighbors[random.randint(0, len(neighbors)-1)]
                direction = [nex[2][0] - current[2][0], nex[2][1] - current[2][1]]
                self.place_tile(self.tiles[current[0]-self.sides[str(direction)]], current[2])
                current[0] = current[0]-self.sides[str(direction)]
                self.place_tile(self.tiles[nex[0]-self.sides[str([-1*e for e in direction])]], nex[2])
                nex[0] = nex[0]-self.sides[str([-1*e for e in direction])]
                current = nex
                """
                print(" Neighbors found: ", neighbors)
                print("  next tile: ", nex)
                print("  direction: ", direction, " = ", self.sides[str(direction)])
                print(f"current tile new tile {current[0]} - {self.sides[str(direction)]} = {current[0]-self.sides[str(direction)]}: ")
                self.print_tile(self.tiles[current[0]-self.sides[str(direction)]])
                print(f"next tile new tiles {nex[0]} - {self.sides[str([-1*e for e in direction])]} = {nex[0]-self.sides[str([-1*e for e in direction])]}: ")
                self.print_tile(self.tiles[nex[0]-self.sides[str([-1*e for e in direction])]])
                print("---")
                self.print_maze()
                """
            elif len(stack) > 0:
                current = stack.pop()
                """
                self.print_maze()
                print(" No Neighbors, going back in stack")
                """

    def get_tile(self,  pos: list):
        r, c = pos
        tile = []
        for i in range(3):
            tile.append(self.maze[r*3+i][c])
        return [self.tiles.index(tile), tile, [r, c]]
    
    def get_neighbors(self, pos: list, unvisited: list):
        r, c = pos
        N = self.get_tile([r-1, c]) if r > 0 else None
        S = self.get_tile([r+1, c]) if r < self.size-1 else None
        E = self.get_tile([r, c+1]) if c < self.size-1 else None
        W = self.get_tile([r, c-1]) if c > 0 else None
        neighbors = []
        for i in [N, S, E, W]:
            if i and i in unvisited:
                neighbors.append(i)
        return neighbors

maze_1 = Maze(int(input()))
maze_1.generate_maze()
maze_1.print_maze()
