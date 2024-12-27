{-# LANGUAGE RecordWildCards #-}
import Control.Monad
import Data.Foldable
import Data.Function
import Data.List.Extra
import Data.Map.Strict (Map)
import Data.Map.Strict qualified as Map
import Data.Set (Set)
import Data.Set qualified as Set
import Debug.Trace
import System.IO.Unsafe
import Data.Vector.Unboxed qualified as Vec
import Data.Vector.Unboxed (Vector)
import Data.Bits

input = lines $ unsafePerformIO $ readFile "input.txt"

a0 = input !! 0 & words & last & read :: Int
b0 = input !! 1 & words & last & read :: Int
c0 = input !! 2 & words & last & read :: Int

program = input !! 4 & words & last & split (==',') & fmap read & Vec.fromList :: Vector Int

data Cpu = Cpu { a :: !Int , b :: !Int , c :: !Int , ip :: !Int , out :: [Int] }
    deriving (Show)

initCpu = Cpu a0 b0 c0 0 []

exec cpu@Cpu { .. } = case (program Vec.!? ip, program Vec.!? (ip + 1)) of
    (Nothing, _) -> out
    (Just instr, Just op) -> exec $ case instr of
        0 -> cpu' { a = a `div` (2 ^ combo op) }
        1 -> cpu' { b = b `xor` op }
        2 -> cpu' { b = combo op `mod` 8 }
        3 -> if a == 0 then cpu' else cpu { ip = op }
        4 -> cpu' { b = b `xor` c }
        5 -> cpu' { out = out <> [combo op `mod` 8] }
        6 -> cpu' { b = a `div` (2^ combo op) }
        7 -> cpu' { c = a `div` (2^ combo op) }
  where
    cpu' = cpu { ip = ip + 2 }
    combo op = case op of
        x | x < 4 -> x
        4 -> a
        5 -> b
        6 -> c

result = exec initCpu

resultA a = exec $ initCpu { a = a }

sol = intercalate "," $ show <$> result

main = putStrLn sol
