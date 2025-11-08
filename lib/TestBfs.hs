import Data.Array.IArray as A

import Bfs

data N = N (Int, Int)
    deriving (Show, Eq, Ord)

mazeStr = "..XX.X.X\
          \X...X.XX\
          \XXX.XXXX\
          \X.....XX\
          \XXXX.XXX\
          \XXXX...X\
          \........\
          \X.X.X.X."

maze :: A.Array (Int, Int) Char
maze = A.listArray ((0, 0), (7, 7)) $ concat $ lines mazeStr

instance Node N where
    isGoal (N (x, y)) = x == (8 - 1) && y == (8 - 1)
    adjacent (N (x, y)) = [(0, 1), (0, -1), (1, 0), (-1, 0)] >>= \(dx, dy) ->
        let idx = (x + dx, y + dy) in
        case maze A.!? idx of
            Just '.' -> [N idx]
            Just 'X' -> []
            Nothing -> []

start = N (0, 0)

main = print $ bfs start
