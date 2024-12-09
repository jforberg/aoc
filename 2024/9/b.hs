import Control.Monad
import Data.Foldable
import Data.Map.Strict qualified as Map
import Data.Map.Strict (Map)
import System.IO.Unsafe
import Data.List.Split

newtype Id = Id Int
    deriving (Show, Eq, Enum, Num, Ord)

data Item = File !Id !Int | Free !Int
    deriving (Show, Eq)

input = head . lines <$> unsafePerformIO $ readFile "input.txt"

initState = do
    (idx, p) <- zip [0..] $ pairs input
    case p of
        Right (a, b) -> [File idx $ read [a], Free $ read [b]]
        Left (a) -> [File idx $ read [a]]

table = Map.fromList $ do
    (idx, it) <- zip [0..] $ toList initState
    case it of
        f@(File id _) -> pure (id, f)
        _ -> mempty

pairs (a:b:cs) = Right (a, b) : pairs cs
pairs (a:_) = [Left a]

maxId = let File id _ = last initState in id

mergeFree (Free 0:rest) = mergeFree rest
mergeFree (Free a:Free b:rest) = mergeFree (Free (a + b):rest)
mergeFree (x:xs) = x : mergeFree xs
mergeFree [] = []

compact state id = mergeFree $ go state False
  where
    go [] _ = []
    go (x@(File id' _):rest) rm
      | id' == id = if rm then Free size : rest else (x:rest)
      | otherwise = x : go rest rm
    go (x@(Free fr):rest) False
      | fr >= size = File id size : Free (fr - size) : go rest True
      | otherwise = x : go rest False
    go (x:xs) rm = x : go xs rm

    File _ size = table Map.! id

finalState = foldl' compact initState (reverse [Id 0..maxId])

checksum :: [Item] -> Int
checksum state = go 0 state
  where
    go idx (File (Id i) s:rest) = subsum idx i s + go (idx + s) rest
    go idx (Free s:rest) = go (idx + s) rest
    go _ [] = 0

    subsum idx i s = sum $ (i *) <$> [idx..idx + s - 1]

sol = checksum finalState

main = print sol
