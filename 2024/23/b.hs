{-# LANGUAGE OverloadedStrings #-}
import Data.Array.IArray qualified as A
import System.IO.Unsafe
import Data.Maybe
import Data.List
import Data.List.Extra
import Data.Map qualified as M
import Data.Int
import Data.Char
import Data.Bits
import Data.Text qualified as T
import Data.Text.IO qualified as T
import Data.Set qualified as S
import Control.Monad
import Debug.Trace

inp = T.lines $ unsafePerformIO $ T.readFile "input.txt"

rawConn = (\[a, b] -> (a, b)) . T.splitOn "-" <$> inp

connections = foldr f M.empty rawConn
  where
    f (n1, n2) m = M.insertWith S.union n1 (S.singleton n2) $
        M.insertWith S.union n2 (S.singleton n1) $ m

nodes = M.keys connections

-- Basic DFS where we keep track of the size of the largest set found so far
-- Start greedy and only discard nodes when not valid or better
fullyConnected n0 = go 1 (S.singleton n0) (connections M.! n0)
  where
    go t sel ns
      | S.null ns = (S.size sel, sel) -- Termination
      | S.size sel + S.size ns < t = (0, S.empty) -- No hope of beating the target
      | otherwise = let
            (n, ns') = setUncons ns in if
            not (sel `S.isSubsetOf` (connections M.! n)) then
            go t sel ns' else let -- Could not connect, must discard
                (lTake, selTake) = go (max t (S.size sel + 1)) (n `S.insert` sel) ns' -- Take this node
                (lDiscard, selDiscard) = go (max t lTake) sel ns' in if -- Don't take this node
                    lTake > lDiscard then (lTake, selTake) else (lDiscard, selDiscard)

setUncons s = (S.elemAt 0 s, S.deleteAt 0 s)

bestSet = maximumOn fst $ fullyConnected <$> nodes

main = print $ T.intercalate "," $ S.toList $ snd bestSet
