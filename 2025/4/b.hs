{-# LANGUAGE LambdaCase #-}
import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Array.Unboxed qualified as Arr
import Data.Map.Strict qualified as Map
import Control.Monad

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

(h, w) = (length inp, length $ inp !! 0)

initGrid = Map.fromList . mapMaybe (\case (idx, '@') -> Just (idx, True); _ -> Nothing) $ full
  where
    full = zip [(i, j) | i <- [0..h - 1], j <- [0.. w - 1]] (mconcat inp)

adj grid (i, j) = length $ do
    dy <- [-1, 0, 1]
    dx <- [-1, 0, 1]
    guard $ dy /= 0 || dx /= 0
    case grid Map.!? (i + dy, j + dx) of
        Nothing -> mempty
        Just x -> pure x

accessible grid idx = adj grid idx < 4

accessibleIxs grid = filter (accessible grid) $ Map.keys grid

iteration grid = foldr Map.delete grid $ accessibleIxs grid

allIterations = go initGrid
  where
    go g
      | d == 0 = [0]
      | otherwise = d : go g'
      where
        g' = iteration g
        d = Map.size g - Map.size g'

solution = sum allIterations

main = print solution
