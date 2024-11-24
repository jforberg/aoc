import Bfs
import Data.Hash.MD5 qualified as Md5
import Data.List
import Data.Set qualified as Set
import Data.Sequence qualified as Seq

seed = "pvhmgsws"

newtype Pos = Pos (Int, Int, String)
    deriving (Show, Eq, Ord)

instance Node Pos where
    isGoal (Pos (x, y, s)) = (x, y) == (3, 3)

    adjacent (Pos (x, y, s)) = let u:d:l:r:_ = hashify s in
        (if u && y > 0 then [Pos (x, y - 1, s <> "U")] else []) <>
        (if d && y < 3 then [Pos (x, y + 1, s <> "D")] else []) <>
        (if l && x > 0 then [Pos (x - 1, y, s <> "L")] else []) <>
        (if r && x < 3 then [Pos (x + 1, y, s <> "R")] else [])

hashify s = f <$> take 4 (Md5.md5s (Md5.Str s))
  where
    f = (`elem` ['b', 'c', 'd', 'e', 'f'])

search :: Set.Set String -> Set.Set Pos -> Seq.Seq Pos -> Set.Set String
search paths nodes (v@(Pos (_, _, s)) Seq.:<| next)
  | v `Set.member` nodes = search paths nodes next
  | isGoal v = let p = drop (length seed) s in
        search (p `Set.insert` paths) (v `Set.insert` nodes) next
  | otherwise = let new = adjacent v in
        search paths (v `Set.insert` nodes) (next <> Seq.fromList new)
search paths _ _ = paths

allPaths = search Set.empty Set.empty (Seq.singleton (Pos (0, 0, seed)))

main = print $ maximum $ length <$> Set.toList allPaths
