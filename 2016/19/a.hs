import Data.Map qualified as Map
import Data.Map (Map)
import Data.Sequence qualified as Seq
import Data.Sequence (Seq)

iteration (e Seq.:<| rest) pres = case rest of
    Seq.Empty -> e
    f Seq.:<| rest' -> let
        pres' = Map.adjust (+ pres Map.! f) e $
            Map.insert f 0 $ pres
        elves' = rest' Seq.|> e in
            iteration elves' pres'

--n = 5
n = 3012210

initPres = Map.fromList [(i, 1) | i <- [0..n-1]]
initElves = Seq.fromList $ [0..n-1]

sol = iteration initElves initPres + 1

main = print sol
