import System.IO.Unsafe
import Data.List.Extra
import Data.Sequence qualified as Seq
import Debug.Trace

inp = unsafePerformIO $ readFile "input.txt"

program = Seq.fromList $ (read :: String -> Int) <$> lines inp

exec p i = case p Seq.!? i of
    Nothing -> 0
    Just d -> let p' = Seq.update i (d + 1) p in
        1 + exec p' (i + d)

solution = exec program 0

main = print solution
