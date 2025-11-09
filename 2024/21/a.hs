import Data.Array.IArray qualified as A
import System.IO.Unsafe
import Data.Maybe
import Data.List
import Data.List.Extra
import Data.Functor
import Data.Map qualified as M
import Data.Int
import Data.Char
import Data.Bimap qualified as BM

import Bfs

-- y, x
data Coord = Coord !Int8 !Int8
    deriving (Show, Eq, Ord, A.Ix)

-- dirpad 0, 1, numpad, punched digit (or 'x' for none)
data State = State !Coord !Coord !Coord !Char
    deriving (Show, Eq, Ord)

numpad :: A.Array Coord Char
numpad = A.listArray (Coord 0 0, Coord 3 2) $
    [ '7', '8', '9',
    '4', '5', '6',
    '1', '2', '3',
    'x', '0', 'A' ]

numpadBm = BM.fromList $ A.assocs numpad

numpadA = numpadBm BM.!> 'A'

dirpad :: A.Array Coord Char
dirpad = A.listArray (Coord 0 0, Coord 1 2) $
    ['x', '^', 'A',
     '<', 'v', '>']

dirpadBm = BM.fromList $ A.assocs dirpad

dirpadA = dirpadBm BM.!> 'A'

initialState = State dirpadA dirpadA numpadA 'x'

rule g (State dp0 dp1 np d)
  | d == g = Goal
  | d /= 'x' = Adj []
  | otherwise = Adj $ do
        c0 <- ['<', '^', '>', 'v', 'A']
        case resolve dirpad c0 dp0 of
            (Nothing, _) -> []
            (Just dp0', Nothing) -> [State dp0' dp1 np 'x']
            (Just dp0', Just c1) -> case resolve dirpad c1 dp1 of
                (Nothing, _) -> []
                (Just dp1', Nothing) -> [State dp0' dp1' np 'x']
                (Just dp1', Just c2) -> case resolve numpad c2 np of
                    (Nothing, _) -> []
                    (Just np', Nothing) -> [State dp0' dp1' np' 'x']
                    (Just np', Just d) -> [State dp0' dp1' np' d]

resolve pad 'A' idx0 = (Just idx0, Just $ pad A.! idx0)
resolve pad c idx0 = case pad A.!? idx1 of
    Nothing -> (Nothing, Nothing)
    Just 'x' -> (Nothing, Nothing)
    Just c' -> (Just idx1, Nothing)
  where
    idx1 = let (dy, dx) = motion c; Coord y0 x0 = idx0 in Coord (y0 + dy) (x0 + dx)

motion '^' = (-1, 0)
motion 'v' = (1, 0)
motion '<' = (0, -1)
motion '>' = (0, 1)

pathLen = go initialState
  where
    go s [] = 0
    go s (d:ds) = let
        p = bfs (rule d) s
        (State dp0 dp1 np _:_) = p
        s' = State dp0 dp1 np 'x' in
        length p - 1 + go s' ds

numeric = (read :: String -> Int) . filter isDigit

complexity ds = pathLen ds * numeric ds

codes = lines $ unsafePerformIO $ readFile "input.txt"

solution = sum $ complexity <$> codes

main = print solution
