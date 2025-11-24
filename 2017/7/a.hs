import System.IO.Unsafe
import Data.List.Extra
import Debug.Trace
import Data.Foldable
import Data.Set qualified as Set
import Data.Maybe
import Text.Regex

inp = lines . unsafePerformIO $ readFile "input.txt"

re = mkRegex "(\\w+) \\((\\w+)\\)( -> (.*))?"

parse s = case matchRegex re s of
    Just [a, b, _, ""] -> (a, b, [])
    Just [a, b, _, c] -> (a, b, splitOn ", " c)

programs = parse <$> inp

names = (\(a, _, _) -> a) <$> programs

supported = Set.fromList $ do
    (_, _, s) <- programs
    s

solution = fromJust $ find (\s -> not $ Set.member s supported) names

main = putStrLn solution
