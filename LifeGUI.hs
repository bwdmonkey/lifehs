import Control.Concurrent

import Life

-- Default width and height (Must be same as the ones in Life.hs)
width, height :: Integer
(width, height) = (20, 20)

-- Custom type declarations
type Alive = Bool
type Cell = (Position, Alive)
type Board = [Cell]

-- generateBoard positions returns a full board given an alive board
generateBoard :: AliveBoard -> Board
generateBoard positions = [((x, y), elem (x, y) positions) | y <- [1..height],
                                                             x <- [1..width]]

-- printCell cell prints a cell with occassional newline if at maximum
printCell :: Cell -> IO ()
printCell ((x, y), alive)
  | x == width = if alive then putStrLn "■ " else putStrLn ". "
  | otherwise  = if alive then putStr   "■ " else putStr   ". "

-- printBoard board prints the full board
printBoard :: Board -> IO ()
printBoard = mapM_ printCell

-- simulate board prints the full board given alive board and runs the game tick
simulate :: AliveBoard -> IO a
simulate board = do
    putStr "\ESC[2J"                     -- ANSI escape sequence to clear screen
    putStr "\ESC[H"                      -- ANSI escape sequence to go to home
    printBoard (generateBoard board)
    putStrLn "Press ^c in order to finish"
    threadDelay 500000                   -- Sleep for 0.5 second
    simulate (nextGeneration board)

-- Temporary simulation
main = simulate [(5,1), (5,2), (5,3), (6,3), (1,5), (2,5), (3,5), (3,6), (6,5),(7,5), (5,6), (5,7), (6,7), (7, 6)]
