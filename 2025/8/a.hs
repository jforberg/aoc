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

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

juncList = Vec.fromList $ inp <&> splitOn "," <&> fmap (read :: String -> Int) <&> \[a, b, c] -> (a, b, c)

juncDist = Map.fromList $ do
    i <- [0..Vec.length juncList - 1]
    j <- [i + 1.. Vec.length juncList - 1]
    pure ((i, j), dist (juncList Vec.! i) (juncList Vec.! j))

dist (x0, y0, z0) (x1, y1, z1) =
    sqrt $ fromIntegral ((x0 - x1)^2) + fromIntegral ((y0 - y1)^2) + fromIntegral ((z0 - z1)^2)

sortedPairs = sortOn (juncDist Map.!) $ Map.keys juncDist

connect (a, b) s = go (a, b) (Set.fromList [a, b]) s
  where
    go p c [] = [c]
    go (a, b) c (s:rest)
      | a `Set.member` s || b `Set.member` s = go (a, b) (c `Set.union` s) rest
      | otherwise = s : go (a, b) c rest

connectSteps = go [] sortedPairs
  where
    go s (p:ps) = s : go (connect p s) ps

finalCircs = connectSteps !! 10

solution = product $ take 3 $ sortOn negate $ Set.size <$> finalCircs

main = print solution
