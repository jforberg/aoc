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

ungarbage [] = []
ungarbage ('<':rest) = trash rest
  where
    trash ('>':rest) = ungarbage rest
    trash (_:rest) = trash rest
ungarbage (x:rest) = x : ungarbage rest

prep = ungarbage . uncancel

parse acc ('{':r) = let (v, r') = parse [] r in parse (acc <> [v]) r'
parse acc (',':r) = parse acc r
parse acc ('}':r) = (Group acc, r)
parse [g] [] = (g, [])

parseTop = fst . parse []

score g = go 1 g
  where
    go s (Group []) = s
    go s (Group gs) = s + sum (go (s + 1) <$> gs)

eval = score . parseTop

solution = eval $ prep inp

main = print solution
