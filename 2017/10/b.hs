import System.IO.Unsafe
import Data.List.Extra
import Data.Foldable
import Data.Maybe
import Data.Sequence qualified as Seq
import Data.Char
import Data.Semigroup
import Data.Bits
import Text.Printf

inp = fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

lengths = (ord <$> inp) <> [17, 31, 73, 47, 23]

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

sparse = toList $ proc start $ stimes 64 lengths

dense = foldl' xor 0 <$> chunksOf 16 sparse

hash = mconcat $ (printf "%02x" :: Int -> String) <$> dense

main = putStrLn hash
