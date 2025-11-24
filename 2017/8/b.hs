import System.IO.Unsafe
import Data.List.Extra
import Debug.Trace
import Data.Foldable
import Data.Set qualified as Set
import Data.Maybe
import Text.Regex
import Data.Map.Strict qualified as Map

inp = lines . unsafePerformIO $ readFile "input.txt"

re = mkRegex "([^ ]+) ([^ ]+) ([^ ]+) if ([^ ]+) ([^ ]+) ([^ ]+)"

parse s = let Just [a, b, c, d, e, f] = matchRegex re s in
    (a, b, read c :: Int, d, e, read f :: Int)

program = parse <$> inp

exec = foldl f (0, Map.empty) program
  where
    f (m, reg) (t, op, v, q, cond, e)
      | doCond cond (get q) e = let tv = doOp op (get t) v in
            (max m tv, Map.insert t tv reg)
      | otherwise = (m, reg)
        where
          get r = Map.findWithDefault 0 r reg

doCond ">" = (>)
doCond "<" = (<)
doCond ">=" = (>=)
doCond "<=" = (<=)
doCond "==" = (==)
doCond "!=" = (/=)

doOp "inc" = (+)
doOp "dec" = (-)

solution = fst exec

main = print solution
