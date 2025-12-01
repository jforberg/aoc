import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Sequence qualified as Seq

inp = fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

lengths = (read :: String -> Int) <$> splitOn "," inp

n = 256

start = Seq.fromList [0..n - 1]

--       i0
-- a..b..c..d..
spl s i0 l = (a, b, c, d)
  where
    ab = Seq.take i0 s
    cd = Seq.drop i0 s
    c = Seq.take l cd
    d = Seq.drop l cd
    a = Seq.take (l - Seq.length c) ab
    b = Seq.drop (Seq.length a) ab

rev s i0 l = a' <> b <> c' <> d
  where
    (a, b, c, d) = spl s i0 l
    ac' = Seq.reverse $ c <> a
    c' = Seq.take (Seq.length c) ac'
    a' = Seq.drop (Seq.length c) ac'

proc s ls = go s ls 0 0
  where
    go s [] _ _ = s
    go s (l:rest) k i0 = go (rev s i0 l) rest (k + 1) ((i0 + l + k) `mod` n)

final = proc start lengths

solution = final `Seq.index` 0 * final `Seq.index` 1

main = print solution
