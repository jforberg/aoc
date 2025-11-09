import Data.Array.IArray qualified as A
import System.IO.Unsafe
import Data.Maybe
import Data.List
import Data.List.Extra
import Data.Functor
import Data.Map.Strict qualified as M
import Data.Int
import Data.Char
import Data.Bits
import Debug.Trace

data Change = Change !Int !Int !Int !Int
    deriving (Show, Eq, Ord)

nextSecret :: Int -> Int
nextSecret x = let
    x1 = prune $ (64 * x) `xor` x
    x2 = prune $ (x1 `div` 32) `xor` x1
    x3 = prune $ (x2 * 2048) `xor` x2
    in x3
  where
    prune = (`mod` 16777216)

genSecrets = iterate nextSecret

initialSecrets = (read :: String -> Int) <$> (lines $ unsafePerformIO $ readFile "input.txt")

secrets :: Int -> [Int]
secrets x0 = take 2001 $ genSecrets x0

secretsOnes x0 = flip mod 10 <$> secrets x0

diffs x0 = zipWith (-) (drop 1 (secretsOnes x0)) (secretsOnes x0)

windows n xs
  | length w == n = w : windows n (drop 1 xs)
  | otherwise = []
  where
    w = take n xs

toChange [a, b, c, d] = Change a b c d

changes = fmap toChange . windows 4 . diffs

changesPrices x0 = zip (changes x0) (drop 4 $ secretsOnes x0)

changeTable = foldl' f M.empty . changesPrices
  where
    f m (c, p)
      | c `M.member` m = m
      | otherwise = M.insert c p m

mergeTables m1 m2 = M.foldrWithKey f m1 m2
  where
    f c p m = M.alter (g p) c m

    g p Nothing = Just p
    g p (Just p') = Just $ p + p'

allTables = changeTable <$> initialSecrets

combTable = foldr mergeTables M.empty allTables

bestChangePrice = maximumOn snd $ M.toList combTable

main = print $ snd bestChangePrice
