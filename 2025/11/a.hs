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

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

edges = Map.fromList $ do
    l <- inp
    let [a, b] = splitOn ": " l
    pure (a, words b)

solution = let m = go "you" (Map.singleton "out" 1) in m Map.! "you"
  where
    go n m
      | Map.member n m = m
      | otherwise = let
            adj = edges Map.! n
            m' = foldr go m adj in
                Map.insert n (sum $ (m' Map.!) <$> adj) m'

main = print solution
