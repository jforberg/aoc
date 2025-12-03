{-# LANGUAGE LambdaCase #-}
import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Array.Unboxed qualified as Arr
import Control.Monad
import Data.Sequence qualified as Seq
import Data.Foldable
import Debug.Trace

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

nums = concatMap (fmap $ \c -> read [c] :: Int) inp

(h, w) = (length inp, length $ inp !! 0)

grid :: Arr.UArray (Int, Int) Int
grid = Arr.listArray ((0, 0), (h - 1, w - 1)) nums

-- Best value we could get from a (possibly incomplete) choice; 0 means not selected
upperBound :: Foldable t => t Int -> Int
upperBound = sum . zipWith (*) tens . fmap (\case 0 -> 9; x -> x) . toList

tens :: [Int]
tens = (10^) <$> [0..]

-- DFS search for best value in row i; number choices as seq in reverse order
dfs i = go 0 (Seq.replicate 12 0) 12 [0..w - 1]
  where
    -- Termination with all choices made
    go _ s 0 _ = upperBound s
    -- Invalid termination, not all choices made
    go _ s _ [] = 0
    -- Recursion with m current best value, l choices left to make, at x-coordinate j
    go m s l (j:js)
      -- Cannot beat m
      | b < m = 0
      -- Best of taking this number and not taking it
      | otherwise = max mYes mNo
      where
        v = grid Arr.! (i, j)
        s' = Seq.update (l - 1) v s
        b =  upperBound s
        -- Best if we take this one; first having tried not taking it
        mYes = go (max m mNo) s' (l - 1) js
        -- Best if we don't take this one, a priori
        mNo = go m s l js

solution = sum $ dfs <$> [0..h - 1]

main = print $ solution
