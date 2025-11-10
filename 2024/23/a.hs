import Data.Array.IArray qualified as A
import System.IO.Unsafe
import Data.Maybe
import Data.List
import Data.List.Extra
import Data.Functor
import Data.Map qualified as M
import Data.Int
import Data.Char
import Data.Bits
import Data.Bimap qualified as BM
import Data.Text qualified as T
import Data.Text.IO qualified as T
import Data.Set qualified as S
import Control.Monad

inp = T.lines $ unsafePerformIO $ T.readFile "input.txt"

rawConn = (\[a, b] -> (a, b)) . T.splitOn (T.pack "-") <$> inp

connections = foldr f M.empty rawConn
  where
    f (n1, n2) m = M.insertWith S.union n1 (S.singleton n2) $
        M.insertWith S.union n2 (S.singleton n1) $ m

threeCycles = do
    n0 <- M.keys connections
    let ns = S.toList $ connections M.! n0
    n1 <- ns
    guard $ n0 < n1
    n2 <- ns
    guard $ n1 /= n2 && n1 < n2
    guard $ S.member n2 $ connections M.! n1
    guard $ any (\s -> T.head s == 't') [n0, n1, n2]
    pure (n0, n1, n2)

main = print . length $ threeCycles
