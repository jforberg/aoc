{-# LANGUAGE LambdaCase, OverloadedStrings #-}
import Control.Monad
import Data.Foldable
import Data.List.Extra
import Data.Map.Strict (Map)
import Data.Map.Strict qualified as Map
import System.IO.Unsafe
import Data.Text qualified as Text
import Data.Text.IO qualified as Text
import Control.Monad.State.Lazy
import Data.Traversable

input = Text.lines $ unsafePerformIO $ Text.readFile "input.txt"

designs = drop 2 input

pats = Text.splitOn ", " $ input !! 0

make :: MonadState (Map Text.Text Int) f => Text.Text -> f Int
make "" = pure (1 :: Int)
make des = (Map.!? des) <$> get >>= \case
    Just c -> pure c
    Nothing -> do
        c <- fmap sum . for pats $ \p -> if p `Text.isPrefixOf` des then
            make $ Text.drop (Text.length p) des else
            pure 0
        modify' (Map.insert des c)
        pure c

sol = evalState (sum <$> mapM make designs) Map.empty

main = print sol
