import System.IO.Unsafe
import Data.List.Extra
import Debug.Trace
import Data.Foldable
import Data.Set qualified as Set
import Data.Maybe
import Text.Regex
import Data.Map.Strict qualified as Map

inp = lines . unsafePerformIO $ readFile "input.txt"

re = mkRegex "(\\w+) \\((\\w+)\\)( -> (.*))?"

parse s = case matchRegex re s of
    Just [a, b, _, ""] -> (a, read b :: Int, [])
    Just [a, b, _, c] -> (a, read b :: Int, splitOn ", " c)

programs = parse <$> inp

names = (\(a, _, _) -> a) <$> programs

weightMap = Map.fromList $ do
    (a, b, _) <- programs
    pure (a, b)

supportsMap = Map.fromList $ do
    (a, _, cs) <- programs
    pure (a, cs)

bottomName = "dgoocsw"

explore n = let
    ss = supportsMap Map.! n
    mw = weightMap Map.! n
    ws = explore <$> ss
    tw = mw + sum ws in if
        allEqual ws then
        tw else
        traceShow (ss, ws) tw

allEqual [] = True
allEqual (x:xs) = go xs
  where
    go [] = True
    go (y:ys) = x == y && go ys

-- ...We realise by staring at the trace prints which progam has the wrong weight
main = print $ explore bottomName
