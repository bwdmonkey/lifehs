module Life (AliveBoard, Position, nextGeneration) where

-- Default width and height
width, height :: Integer
(width, height) = (20, 20)

-- Custom type declarations
type Position = (Integer, Integer)
type AliveBoard = [Position]

-- isAlive returns True if position exists within an AliveBoard
isAlive :: AliveBoard -> Position -> Bool
isAlive board position = elem position board

-- isEmpty returns True if position doesn't exists within an AliveBoard
isEmpty :: AliveBoard -> Position -> Bool
isEmpty board position = not (isAlive board position)

-- wrap (x, y) returns a new position wrapped around maximum height and width
wrap :: Position -> Position
wrap (x, y) = (((x - 1) `mod`  width) + 1,
               ((y - 1) `mod` height) + 1)

-- neighbors (x, y) returns all neighbors around position after wrap
neighbors :: Position -> [Position]
neighbors (x, y) = map wrap [(x - 1, y - 1), (x, y - 1), (x + 1, y - 1),
                             (x - 1, y    ),             (x + 1, y    ),
                             (x + 1, y + 1), (x, y + 1), (x + 1, y + 1)]

-- liveNeighborCount (x, y) returns the number of alive neighbors
liveNeighborCount :: AliveBoard -> Position -> Integer
liveNeighborCount board = toInteger . length . filter (isAlive board) . neighbors

-- survivors board returns a new board with just the survivors (Has 2 or 3 alive neighbors)
survivors :: AliveBoard -> [Position]
survivors board = [position | position <- board, (liveNeighborCount board position) `elem` [2,3]]

-- births board returns a new board with all reproduction considered
births :: AliveBoard -> [Position]
births board = [(x, y) | x <- [1..width],
                         y <- [1..height],
                         isEmpty board (x, y),
                         liveNeighborCount board (x,y) == 3]

-- nextGeneration board returns the next time loop of the board
nextGeneration :: AliveBoard -> AliveBoard
nextGeneration board = survivors board ++ births board
