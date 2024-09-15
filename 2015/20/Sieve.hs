{-# LANGUAGE LambdaCase #-}
module Sieve
( Sieve(..)
, mkSieve
, isPrime
, primeNumber
, primeList
, primeCount
, primeFactors
, primeFactorMults
, distinctPrimeFactors
, totient
, intSqrt
)
where

import Control.Exception
import Data.Foldable
import Data.STRef
import Data.Int
import qualified Data.Vector as V
import qualified Data.Vector.Unboxed as VU
import qualified Data.Vector.Unboxed.Mutable as VM
import Control.Monad.Extra
import Control.Monad.ST

data Sieve = Sieve
    { _limit :: Int
    , _primeCount :: Int
    , _sieve :: VU.Vector Bool
    , _primes :: VU.Vector Int32
    , _leastFactor :: VU.Vector Int32
    }

{-# INLINABLE isPrime #-}
isPrime :: Sieve -> Int -> Bool
isPrime Sieve { _sieve } = (_sieve VU.!)

{-# INLINABLE primeNumber #-}
primeNumber :: Sieve -> Int -> Int
primeNumber Sieve { _primes } = fromIntegral . (_primes VU.!)

{-# INLINABLE primeList #-}
primeList :: Sieve -> [Int]
primeList Sieve { _primeCount, _primes } = take _primeCount $ fromIntegral <$> VU.toList _primes

{-# INLINABLE primeCount #-}
primeCount :: Sieve -> Int
primeCount = _primeCount

{-# INLINABLE primeFactors #-}
primeFactors :: Sieve -> Int -> [Int]
primeFactors s@Sieve { _sieve, _leastFactor } n
  | n < 2 = []
  | _sieve VU.! n = [n]
  | otherwise = let f = fromIntegral $ _leastFactor VU.! n in f : primeFactors s (n `div` f)

{-# INLINABLE primeFactorMults #-}
primeFactorMults :: Sieve -> Int -> [(Int, Int)]
primeFactorMults s n = go (0, 0) $ primeFactors s n
  where
    go (p, !k) [] = [(p, k)]
    go (p, !k) (f:fs)
      | p == 0 = go (f, 1) fs
      | f == p = go (p, k + 1) fs
      | otherwise = (p, k) : go (f, 1) fs

{-# INLINABLE distinctPrimeFactors #-}
distinctPrimeFactors :: Sieve -> Int -> [Int]
distinctPrimeFactors s = f . primeFactors s
  where
    f [] = []
    f [x] = [x]
    f (a:b:rest) = if a == b then f (b:rest) else a : f (b:rest)

{-# INLINABLE totient #-}
totient :: Sieve -> Int -> Int
totient s n
  | isPrime s n = n - 1
  | otherwise = foldl' (\acc f -> acc - acc `div` f) n $ distinctPrimeFactors s n

mkSieve :: Int -> Sieve
mkSieve limit = assert (limit >= 2) $ runST $ do
    let m = intSqrt limit

    sieve <- VM.replicate (limit + 1) True
    primes <- VM.replicate (piUpperBound limit) 0
    leastFactor <- VM.replicate (limit + 1) 0

    for_ [0, 1] $ \n ->
        VM.write sieve n False

    sieveIdx <- newSTRef 2
    primeIdx <- newSTRef 0

    -- Mark prime numbers and the least factor of each number
    let loop = do
            si <- readSTRef sieveIdx
            valid <- VM.read sieve si

            when valid $ do
                pi <- readSTRef primeIdx
                VM.write primes pi $ fromIntegral si
                modifySTRef primeIdx (+ 1)

                for_ [si * 2, si * 3 .. limit] $ \j -> do
                    whenM (VM.read sieve j) $
                        VM.write leastFactor j (fromIntegral si)
                    VM.write sieve j False

            when (si < m) $ do
                modifySTRef sieveIdx (+ 1)
                loop
    loop

    -- Fill out the rest of the prime table (√limit and above)
    si <- readSTRef sieveIdx
    for_ [si + 1..limit] $ \i ->
        whenM (VM.read sieve i) $ do
            pi <- readSTRef primeIdx
            VM.write primes pi $ fromIntegral i
            modifySTRef primeIdx (+ 1)

    Sieve limit <$>
        readSTRef primeIdx <*>
        VU.unsafeFreeze sieve <*>
        VU.unsafeFreeze primes <*>
        VU.unsafeFreeze leastFactor

-- Upper bound on the prime-counting function π(n)
piUpperBound n = let x = fromIntegral n in ceiling $ 1.25506 * x / log x

-- ⌈√n⌉
intSqrt = ceiling . (sqrt :: Double -> Double) . fromIntegral
