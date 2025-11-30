import System.IO.Unsafe
import Data.List.Extra
import Debug.Trace
import Data.Foldable
import Data.Set qualified as Set
import Data.Maybe
import Text.Regex
import Data.Map.Strict qualified as Map

inp = fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

data Group = Group [Group]
    deriving Show

uncancel [] = []
uncancel ('!':_:rest) = uncancel rest
uncancel (x:rest) = x : uncancel rest

ungarbage [] = 0
ungarbage ('<':rest) = trash rest
  where
    trash ('>':rest) = ungarbage rest
    trash (_:rest) = 1 + trash rest
ungarbage (x:rest) =  ungarbage rest

solution = ungarbage . uncancel $ inp

main = print solution
