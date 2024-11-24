import Bfs
import Data.Hash.MD5 qualified as Md5

seed = "pvhmgsws"

newtype Pos = Pos (Int, Int, String)
    deriving (Show, Eq, Ord)

instance Node Pos where
    isGoal (Pos (x, y, _)) = (x, y) == (3, 3)

    adjacent (Pos (x, y, s)) = let u:d:l:r:_ = hashify s in
        (if u && y > 0 then [Pos (x, y - 1, s <> "U")] else []) <>
        (if d && y < 3 then [Pos (x, y + 1, s <> "D")] else []) <>
        (if l && x > 0 then [Pos (x - 1, y, s <> "L")] else []) <>
        (if r && x < 3 then [Pos (x + 1, y, s <> "R")] else [])

hashify s = f <$> take 4 (Md5.md5s (Md5.Str s))
  where
    f = (`elem` ['b', 'c', 'd', 'e', 'f'])

path = bfs $ Pos (0, 0, seed)

sol = let Pos (_, _, s):_ = path in drop (length seed) s

main = putStrLn sol
