import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Array.Unboxed qualified as Arr
import Control.Monad

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

(h, w) = (length inp, length $ inp !! 0)

grid :: Arr.UArray (Int, Int) Char
grid = Arr.listArray ((0, 0), (h - 1, w - 1)) $ mconcat inp

adj (i, j) = length . filter (== '@') $ do
    dy <- [-1, 0, 1]
    dx <- [-1, 0, 1]
    guard $ dy /= 0 || dx /= 0
    case grid Arr.!? (i + dy, j + dx) of
        Nothing -> mempty
        Just x -> pure x

accessible idx
  | grid Arr.! idx /= '@' = False
  | otherwise = adj idx < 4

solution = length $ filter accessible $ [(i, j) | i <- [0..h - 1], j <- [0.. w - 1]]

main = print solution
