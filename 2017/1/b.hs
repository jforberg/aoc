import System.IO.Unsafe
import Data.Vector qualified as V
import Data.Text qualified as T
import Data.Text.IO qualified as T

inp = unsafePerformIO $ T.strip <$> T.readFile "input.txt"

vec = V.fromList $ toInt <$> T.unpack inp

toInt c = read (c : []) :: Int

circ v i = v V.! (i `mod` V.length v)

strangeSum v = sum $ flip fmap [0..V.length v] $ \i -> if
    v `circ` i == v `circ` (i + (V.length v `div` 2)) then v `circ` i else 0

solution = strangeSum vec

main = print solution
