module Seed (separate, readPlot, readSeed, seedPlots) where

import Life

-- separate (==',') "3,5,"  => ["3","5",""]
separate :: (a -> Bool) -> [a] -> [[a]]
separate sep [] = [[]]
separate sep (h:t)
    | sep h = []: separate sep t
    | otherwise = ((h:w):rest)
                where w:rest = separate sep t

-- readPlot "plot3.txt" => [["0","1","0"],["1","0","1"],["0","1","0"]]
readPlot :: FilePath -> IO [[String]]
readPlot filename =
    do
        file <- readFile filename
        return [separate (==' ') line| line <- separate (=='\n') file]

-- readSeed "plot3.txt" =>  [(1,0),(0,1),(2,1),(1,2)]
readSeed :: String -> IO AliveBoard
readSeed filename =
    do
        matrix <- readPlot filename
        h <- return (sum [1 | _ <- matrix] - 1)
        w <- return (sum [1 | _ <- (matrix)!!0] - 1)
        return [(toInteger x, toInteger y) |  y <- [0..h], x <- [0..w], ((matrix)!!y)!!x == "1"]

seedPlots :: IO AliveBoard
seedPlots = do
    putStrLn "Greetings. Which of the following seeds would you like to use?"
    putStrLn "BeaconSeed, BlinkerSeed, DieHardSeed, GliderSeed, LWSSSeed, RandomSeed, ToadSeed"
    file <- getLine
    (readSeed ("./seeds/" ++ file ++ ".txt"))
