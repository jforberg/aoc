import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Array.Unboxed qualified as Arr
import Control.Monad
import Data.Set qualified as Set
import Data.Foldable
import Data.Vector qualified as Vec
import Data.Map.Strict qualified as Map
import Debug.Trace
import Data.Bits

import Bfs

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

problems = do
    ws <- words <$> inp
    let lights = parseInd $ ws !! 0
    let buts = parseSet <$> drop 1 ws
    pure (lights, buts)

parseInd s = foldr f (0 :: Int) $ zip [0..] $ drop 1 (init s)
  where
    f (i, '#') = (.|. (1 `shiftL` i))
    f (i, '.') = id

parseSet s = foldr f (0 :: Int) $ splitOn "," $ drop 1 (init s)
  where
    f x = (.|. (1 `shiftL` (read x :: Int)))

solve (target, buttons) = bfs rule (0 :: Int)
  where
    rule l
      | l == target = Goal
      | otherwise = Adj $ xor l <$> buttons

solution = sum $ (subtract 1) <$> length <$> solve <$> problems

main = print solution
