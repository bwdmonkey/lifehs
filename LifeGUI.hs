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
    clearScreen
    printBoard (generateBoard board)
    putStrLn "Press ^c in order to finish"
    threadDelay 500000                   -- Sleep for 0.5 second
    simulate (nextGeneration board)

-- startScreen prints the start screen for the game
startScreen :: IO ()
startScreen = do
  clearScreen
  putStrLn "Welcome to Conway's Game of Life!"
  putStrLn "What would you like to do?"
  putStrLn "1) Use custom plots"
  putStrLn "2) Use seeds"
  input <- getLineWithFilter (\x -> x == "1" || x == "2") "Invalid option. Please choose from the options"
  case input of
    "1" -> simulate [(1,2), (1,1), (2,2)] -- TODO: Implement custom plot picker #4
    "2" -> putStrLn ("TODO: Implement seed picker #3")
    _ -> putStrLn ("Something went wrong.")

-- clearScreen clears the screen and sets the cursor to home using ANSI
clearScreen :: IO ()
clearScreen = do
    putStr "\ESC[2J"                     -- ANSI escape sequence to clear screen
    putStr "\ESC[H"                      -- ANSI escape sequence to go to home

-- getLineWithFilter gets IO input with filter until the conditions are met
getLineWithFilter :: (String -> Bool) -> String -> IO String
getLineWithFilter cond err = do
  putStr ("> ")
  input <- getLine
  if cond input then do
    return input
  else do
    putStrLn (err)
    return (getLineWithFilter cond err)()

-- main
main :: IO ()
main = startScreen
