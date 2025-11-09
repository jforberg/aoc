import Data.Array.IArray qualified as A
import System.IO.Unsafe
import Data.Maybe
import Data.List
import Data.List.Extra
import Data.Functor
import Data.Map qualified as M
import Data.Int
import Data.Char
import Data.Bits

nextSecret :: Word -> Word
nextSecret x = let
    x1 = prune $ (64 * x) `xor` x
    x2 = prune $ (x1 `div` 32) `xor` x1
    x3 = prune $ (x2 * 2048) `xor` x2
    in x3
  where
    prune = (`mod` 16777216)

secrets = iterate nextSecret

finalSecret x0 = secrets x0 !! 2000

initialSecrets = (read :: String -> Word) <$> (lines $ unsafePerformIO $ readFile "input.txt")

solution = sum $ finalSecret <$> initialSecrets

main = print solution
