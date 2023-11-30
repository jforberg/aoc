data State = State !Int !Int !Int !Int
    deriving (Show)

--(tx0, tx1, ty0, ty1) = (20, 30, -10, -5)
(tx0, tx1, ty0, ty1) = (48, 70, -189, -148)

step (State vx vy x y) = State (vx - signum vx) (vy - 1) (x + vx) (y + vy)

check (State _ _ x y) = x >= tx0 && x <= tx1 && y >= ty0 && y <= ty1

below (State _ vy _ y) = vy <= 0 && y < ty0

evaluate is = select (minBound :: Int) $ iterate step is
  where
    select acc (s@(State _ _ _ y):rest)
      | check s     = acc
      | below s     = (minBound :: Int)
      | otherwise   = select (max acc y) rest

-- Good old-fashioned exhaustive search with hand-tuned bounds. Not very beautiful but the problem
-- really invites such a solution.
search = maximum $ do
    vx <- [0..50]
    vy <- [0..200]
    pure $ evaluate $ State vx vy 0 0

main = do
    _ <- getContents
    print $ search
