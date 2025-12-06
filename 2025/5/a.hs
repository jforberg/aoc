import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Ix

inp = fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

[inp1, inp2] = lines inp & splitOn [""]

ranges = do
    i <- inp1
    let [a, b] = splitOn "-" i
    pure (read a :: Int, read b :: Int)

ingredients :: [Int] = read <$> inp2

fresh = filter (\i -> any (flip inRange i) ranges) ingredients

solution = length fresh

main = print solution
