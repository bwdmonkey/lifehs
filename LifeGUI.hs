import Control.Concurrent
import Text.Regex.Posix

import Constants
import Life
import LifeHelper
import Seed

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
    putStrLn "Press ^C in order to finish"
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
    "1" -> do plots <- customPlots; simulate plots
    "2" -> do plots <- seedPlots; simulate plots
    _ -> putStrLn ("Something went wrong. Please restart the program.")

-- clearScreen clears the screen and sets the cursor to home using ANSI
clearScreen :: IO ()
clearScreen = do
    putStr "\ESC[2J"                     -- ANSI escape sequence to clear screen
    putStr "\ESC[H"                      -- ANSI escape sequence to go to home

-- customPlots prints the custom plot screen and asks for custom positions
customPlots = do
  putStrLn "Please provide a cell position you like to add in format of x, y"
  putStrLn "or \"quit\" to quit:"
  plots <- getPositions []
  return plots

-- getPositions asks for valid positions until user types "quit"
getPositions :: [Position] -> IO [Position]
getPositions lst = do
  input <- getLineWithFilter isPositionFormatOrQuit "Invalid format. Please input in the format of x,y or type \"quit\" to quit."
  if input == "quit" then do
    return lst
  else do
    let position = translateToPosition input
    return (getPositions (lst ++ [position]))()

-- translateToPosition translates a string format of "1,1" into a Position of (1,1)
translateToPosition :: String -> Position
translateToPosition str = arrayToPosition (split ',' str)
    where
      arrayToPosition :: [String] -> Position
      arrayToPosition (a:b:r) = (read a, read b)

-- isPositionFormatOrQuit returns True if the string is true or in the format of "Num,Num"
isPositionFormatOrQuit :: String -> Bool
isPositionFormatOrQuit str
    | str == "quit" = True
    | isPresent (getAllTextMatches $ str =~ "^[1-9][0-9]*,[1-9][0-9]*$" :: [String]) = True
    | otherwise = False

-- main
main :: IO ()
main = startScreen
