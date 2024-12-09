import Control.Monad
import Data.Foldable
import Data.List.Extra
import Data.List.Split
import Data.Map.Strict (Map)
import Data.Map.Strict qualified as Map
import Data.Set (Set)
import Data.Set qualified as Set
import Debug.Trace
import System.IO.Unsafe

input = unsafePerformIO $ readFile "input.txt"

sol = 0

main = print sol
