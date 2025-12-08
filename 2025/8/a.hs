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
import Data.PQueue.Min qualified as PQ

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "small.txt"

juncList = Vec.fromList $ inp <&> splitOn "," <&> fmap (read :: String -> Int) <&> \[a, b, c] -> (a, b, c)

juncDist = Map.fromList $ do
    i <- [0..Vec.length juncList - 1]
    j <- [i + 1.. Vec.length juncList - 1]
    pure ((i, j), dist (juncList Vec.! i) (juncList Vec.! j))

dist (x0, y0, z0) (x1, y1, z1) =
    sqrt $ fromIntegral ((x0 - x1)^2) + fromIntegral ((y0 - y1)^2) + fromIntegral ((z0 - z1)^2)

newtype Pair = Pair (Int, Int)
    deriving (Show, Eq)

instance Ord Pair where
    compare = compare `on` (\(Pair p) -> juncDist Map.! p)

pairQueue = PQ.fromList $ Pair <$> Map.keys juncDist
