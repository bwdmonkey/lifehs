module LifeHelper (isPresent, split, getLineWithFilter) where

-- isPresent returns True if array contains any element
isPresent :: Foldable t => t a -> Bool
isPresent arr = (length arr) > 0

-- split is a single character/digit splitter
split :: Eq a => a -> [a] -> [[a]]
split _ [] = []
split d s = x : split d (drop 1 y) where (x,y) = span (/= d) s

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
