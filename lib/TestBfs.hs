import Data.Array.IArray as A

import Bfs

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

rule (x, y)
  | (x, y) == (7, 7) = Goal
  | otherwise = Adj $ [(0, 1), (0, -1), (1, 0), (-1, 0)] >>= \(dx, dy) ->
        let idx = (x + dx, y + dy) in
        case maze A.!? idx of
            Just '.' -> [idx]
            Just 'X' -> []
            Nothing -> []

main = print $ bfs rule (0, 0)
