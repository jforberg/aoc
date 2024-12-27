import Control.Monad
import Data.Foldable
import Data.List.Extra
import Data.Map.Strict (Map)
import Data.Map.Strict qualified as Map
import Data.Set (Set)
import Data.Set qualified as Set
import Debug.Trace
import System.IO.Unsafe

input = lines $ unsafePerformIO $ readFile "input.txt"

designs = drop 2 input

pats = splitOn ", " $ input !! 0

make des = any id $ go des
  where
    go [] = pure True
    go des = do
        p <- pats
        guard $ p `isPrefixOf` des
        go $ drop (length p) des

sol = length $ filter make designs

main = print sol
