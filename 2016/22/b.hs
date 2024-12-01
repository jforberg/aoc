import Control.Monad

import Bfs

mx = 35 :: Int
my = 24 :: Int

--             goal        hole
newtype N = N ((Int, Int), (Int, Int))
    deriving (Show, Eq, Ord)

instance Node N where
    isGoal (N ((0, 0), _)) = True
    isGoal _ = False

    adjacent (N (g@(gx, gy), h@(hx, hy))) = do
        dx <- [-1, 0, 1]
        dy <- if dx == 0 then [-1, 1] else [0]

        let h'@(hx', hy') = (hx + dx, hy + dy)
        guard $ hx' >= 0 && hx' <= mx
        guard $ hy' >= 0 && hy' <= my
        when (hy' == 21) $
            guard $ hx' == 0

        let g' = if h' == g then h else g
        pure $ N (g', h')

sol = bfs $ N ((mx, 0), (17, 22))

main = print $ length sol - 1

