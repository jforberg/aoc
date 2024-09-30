import Bfs2 qualified as Bfs
import Data.Bits

newtype Node = Node (Int, Int)
    deriving (Eq, Ord, Show)

start = Node (1, 1)
goal = Node (39, 31)
passable (Node (y, x)) = let
    n = x * x + 3 * x + 2 * x * y + y + y * y + 1358
    pc = popCount n
    in y >= 0 && x >= 0 && pc `rem` 2 == 0

instance Bfs.Node Node where
    adjacent (Node (y, x)) = filter passable $
        [Node (y + 1, x), Node (y - 1, x), Node (y, x + 1), Node (y, x - 1)]

main = print $ length $ Bfs.bfs start
