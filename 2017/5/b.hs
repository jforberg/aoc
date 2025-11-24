import System.IO.Unsafe
import Data.List.Extra
import Data.Sequence qualified as Seq
import Debug.Trace

inp = unsafePerformIO $ readFile "input.txt"

program = Seq.fromList $ (read :: String -> Int) <$> lines inp

exec p i = case p Seq.!? i of
    Nothing -> 0
    Just d -> let
        d' = if d >= 3 then d - 1 else d + 1
        p' = Seq.update i d' p in
            1 + exec p' (i + d)

solution = exec program 0

main = print solution
