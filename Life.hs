module Life (AliveBoard, Position, nextGeneration, stuckBoard) where

import Constants

-- Custom type declarations
type Position = (Integer, Integer)
type AliveBoard = [Position]

-- isAlive returns True if position exists within an AliveBoard
isAlive :: AliveBoard -> Position -> Bool
isAlive board position = elem position board

-- isEmpty returns True if position doesn't exists within an AliveBoard
isEmpty :: AliveBoard -> Position -> Bool
isEmpty board position = not (isAlive board position)

-- wrap add element to the list if it is not out of bound
check :: Position -> Bool
check (x,y) = (x > 0) || (x <= width) || (y > 0) || (y <= height)

-- neighbors (x, y) returns all neighbors around position after check
neighbors :: Position -> [Position]
neighbors (x, y) = filter check [(x - 1, y - 1), (x, y - 1), (x + 1, y - 1),
                              (x - 1, y    ),             (x + 1, y    ),
                              (x - 1, y + 1), (x, y + 1), (x + 1, y + 1)]

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

-- stuckBoard checks if current board and the next board is the same
stuckBoard :: AliveBoard -> Bool
stuckBoard board = board == (nextGeneration board)
