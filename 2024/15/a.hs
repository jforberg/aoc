import Control.Monad
import Data.Foldable
import Data.List.Extra
import Data.Set (Set)
import Data.Set qualified as Set
import Debug.Trace
import System.IO.Unsafe
import Data.Array.IArray qualified as Arr
import Data.Array.IArray (Array)
import Data.Maybe

input = unsafePerformIO $ readFile "input.txt"

inputParts = split (=="") $ lines input

inputGrid = inputParts !! 0
inputCmds = concat $ inputParts !! 1

h = length inputGrid
w = length $ inputGrid !! 0

grid :: Array (Int, Int) Char
grid = Arr.listArray ((0, 0), (h - 1, w - 1)) $ concat inputGrid

boxes0 = Set.fromList [ idx | idx <- Arr.indices grid, grid Arr.! idx == 'O']

isWall idx = case grid Arr.!? idx of
    Nothing -> True
    Just '#' -> True
    _ -> False

robot0 = let Just x = find (\idx -> grid Arr.! idx == '@') $ Arr.indices grid in x

items0 = robot0 `Set.insert` boxes0

decodeCmd x = case x of
    '>' -> (0, 1)
    '<' -> (0, -1)
    '^' -> (-1, 0)
    'v' -> (1, 0)

cmds = decodeCmd <$> inputCmds

(y0, x0) ~+ (y1, x1) = (y0 + y1, x0 + x1)

exec (items, pos) dir = case exec' (pos `Set.delete` items) pos' dir of
    Nothing -> (items, pos)
    Just items' -> (items', pos')
  where
    pos' = pos ~+ dir

exec' items pos dir
  | isWall pos = Nothing
  | pos `Set.member` items = exec' items (pos ~+ dir) dir
  | otherwise = Just $ pos `Set.insert` items

execAll = foldl' exec (items0, robot0) cmds

gps (items, pos) = sum [ 100 * y + x | idx@(y, x) <- toList items, idx /= pos ]

sol = gps execAll

main = print sol
