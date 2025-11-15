-- This is a Haskell program I know this
import Control.Monad
import Control.Monad.ST.Lazy -- <- This is when you know you messed up
import Data.STRef.Lazy

-- Now we just have to redefine the laws of mathematics
instance Semigroup a => Semigroup (ST s a) where
    (<>) = liftM2 (<>)

index :: [(Int, Int)]
index = (0, 0) : runST start
  where
    start = do
      idx <- newSTRef (0, 0)
      go idx 1

    -- Oh no
    go idx l =
      right idx 1 <> up idx l <> left idx (l + 1) <> down idx (l + 1) <> right idx (l + 1) <> go idx (l + 2)

    right idx = move idx (0, 1)
    up idx = move idx (-1, 0)
    down idx = move idx (1, 0)
    left idx = move idx (0, -1)

    move idx d l = replicateM l $ move' idx d

    move' idx (dx, dy) = do
        (x, y) <- readSTRef idx
        -- This strictness annotation actually makes it go slower! But we aren't in any hurry here
        let (!x', !y') = (x + dx, y + dy)
        writeSTRef idx (x', y')
        pure (x', y')

-- The only sane function in this file
manhattan (x, y) = abs x + abs y

steps i = manhattan $ index !! (i - 1)

solution = steps 361527

main = print solution
