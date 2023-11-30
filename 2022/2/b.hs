win [1, 1] = 3 + 0
win [1, 2] = 1 + 3
win [1, 3] = 2 + 6
win [2, 1] = 1 + 0
win [2, 2] = 2 + 3
win [2, 3] = 3 + 6
win [3, 1] = 2 + 0
win [3, 2] = 3 + 3
win [3, 3] = 1 + 6

parse "A" = 1
parse "B" = 2
parse "C" = 3
parse "X" = 1
parse "Y" = 2
parse "Z" = 3

plays :: [[String]] -> [Int]
plays g = do
    [p1, p2] <- fmap parse <$> g
    let w = win [p1, p2]
    pure w

main = do
    ps <- plays . fmap words . lines <$> getContents
    print $ sum ps
