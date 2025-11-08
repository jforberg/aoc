{-# LANGUAGE MultiWayIf #-}

import Data.Array.IArray qualified as A
import System.IO.Unsafe
import Data.Maybe
import Data.List
import Data.List.Extra
import Data.Functor
import Data.Map qualified as M

import Dfs qualified
import Bfs qualified

mazeStr = lines $ unsafePerformIO $ readFile "input.txt"

w = length (mazeStr !! 0)
h = length mazeStr

maze :: A.Array (Int, Int) Char
maze = A.listArray ((0, 0), (h - 1, w - 1)) (concat mazeStr)

(startIdx, _) = fromJust $ flip find (A.assocs maze) $ \(idx, c) -> c == 'S'

shortestPath = flip Bfs.bfs startIdx $ \idx@(x, y) -> case maze A.! idx of
    'E' -> Bfs.Goal
    _ -> Bfs.Adj $ [(0, 1), (0, -1), (1, 0), (-1, 0)] >>= \(dx, dy) ->
        let idx' = (x + dx, y + dy) in case maze A.!? idx' of
            Just '.' -> [idx']
            Just 'E' -> [idx']
            _ -> []

shortestLength = length shortestPath - 1

minSaving = 100

data Cheat = Uncheated | Cheating !Int | Cheated
    deriving (Show, Eq, Ord)

cheatPaths = Dfs.dfsAll rule fst (startIdx, (Nothing, Nothing, Uncheated))
  where
    rule l (idx0@(x, y), cc@(s, e, c))
      | l > shortestLength - minSaving = Dfs.Adj []
      | otherwise = case maze A.! idx0 of
            'E' -> Dfs.Goal
            _ -> Dfs.Adj $ [(0, 1), (0, -1), (1, 0), (-1, 0)] >>= \(dx, dy) ->
                let idx1 = (x + dx, y + dy)

                    noCheat = case c of
                        Cheating n -> if n == 1 then
                            (s, Just idx1, Cheated) else
                            (s, Nothing, Cheating (n - 1))
                        _ -> cc

                    endCheat = case c of
                        Cheating n -> (s, Just idx1, Cheated)
                        _ -> cc

                    yesCheat = case c of
                        Cheating n -> noCheat
                        Uncheated -> (Just idx0, Nothing, Cheating 1)
                        Cheated -> error "already cheated"

                    canCheat = case c of
                        Cheating n -> n > 1
                        Uncheated -> True
                        Cheated -> False

                in case maze A.!? idx1 of
                    Just '.' -> [(idx1, noCheat)]
                    Just 'E' -> [(idx1, endCheat)]
                    Just '#' -> if canCheat then [(idx1, yesCheat)] else []
                    _ -> []

cheatPathSummaries = flip mapMaybe cheatPaths $ \(l, n) ->
    let d = shortestLength - l in if d <= 0 then Nothing else 
        case n of
            (_, (Just s, Just e, Cheated)) -> Just (d, s, e)
            _ -> Nothing

bestPerCheat = foldl' f M.empty cheatPathSummaries
  where
    f m (d, s, e) = M.alter (g d) (s, e) m

    g d Nothing = Just d
    g d (Just d0) = Just $ max d d0

binned = foldl' f M.empty $ M.elems bestPerCheat
  where
    f m d = M.alter g d m

    g Nothing = Just 1
    g (Just !n) = Just (1 + n)

saving d = flip filter (M.assocs bestPerCheat) $ \(c, d') -> d' == d

savingAtleast d = filter ((>= 100) . snd) $ M.assocs bestPerCheat

solution = length $ savingAtleast 100

main = print solution
