import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Set qualified as Set
import Data.Numbers

inp = fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

ranges = splitOn "," inp <&> splitOn "-" <&> \[a, b] -> (read a :: Int, read b :: Int)

fullRanges = concatMap (uncurry enumFromTo) ranges

isDuplicate x
  | length s < 2 = False
  | otherwise = flip any sizes $ \l -> let (c:cs) = chunksOf l s in all (== c) cs
  where
    sizes = fmap fromIntegral . factors . fromIntegral $ length s
    s = show x

solution = sum $ filter isDuplicate fullRanges

main = print solution
