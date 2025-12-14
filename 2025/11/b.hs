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

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

edges = Map.fromList $ do
    l <- inp
    let [a, b] = splitOn ": " l
    pure (a, words b)

solution = let m = go v0 m0 in m Map.! v0
  where
    go v@(n, s) m
      | Map.member v m = m
      | otherwise = let
            s' = case n of
                "fft" -> s .|. 1
                "dac" -> s .|. 2
                _ -> s
            adj = (, s') <$> edges Map.! n
            m' = foldr go m adj in
                Map.insert v (sum $ (m' Map.!) <$> adj) m'

    m0 = Map.fromList $ [(("out", 3), 1)] <> [(("out", x), 0) | x <- [0..2]]

    v0 = ("svr", 0)

main = print solution
