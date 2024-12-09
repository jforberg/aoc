import Control.Monad
import Data.Map.Strict qualified as Map
import Data.Map.Strict (Map)
import Data.Set qualified as Set
import Data.Set (Set)
import System.IO.Unsafe
import Data.List.Split
import Data.List.Extra

default (Int)

input = unsafePerformIO $ readFile "input.txt"

sol = 0

main = print sol
