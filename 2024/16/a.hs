import Control.Monad
import Data.Foldable
import Data.List.Extra
import System.IO.Unsafe
import Data.Array.IArray qualified as Arr
import Data.Array.IArray (Array)

import Dijkstra

input = lines $ unsafePerformIO $ readFile "input.txt"

w = length $ input !! 0
h = length input

grid = Arr.listArray ((0, 0), (h - 1, w - 1)) $ concat input :: Array (Int, Int) Char

Just start = find (\idx -> grid Arr.! idx == 'S') $ Arr.indices grid
Just goal = find (\idx -> grid Arr.! idx == 'E') $ Arr.indices grid

newtype N = N ((Int, Int), (Int, Int))
    deriving (Eq, Ord, Show)

instance Node N where
    isGoal (N (idx, _)) = idx == goal
    adjacent (N ((x, y), (dx, dy))) = rot <> move
      where
        rot = do
            (dx', dy') <- [(1, 0), (-1, 0), (0, 1), (0, -1)]
            guard $ dx /= dx' || dy /= dy'
            guard $ dx /= -dx' || dy /= -dy'
            pure $ (1000, N ((x, y), (dx', dy')))

        move = let (x', y') = (x + dx, y + dy) in case grid Arr.!? (x', y') of
            Nothing -> mempty
            Just '#' -> mempty
            _ -> pure (1, N ((x', y'), (dx, dy)))

(path, cost) = dijkstra $ N (start, (0, 1))

main = print cost
