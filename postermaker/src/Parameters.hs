module Parameters
  ( Params(..)
  , defaultParams
  ) where

import Prelude hiding (readFile)

import Data.ByteString.Lazy (readFile)
import Data.Csv (decodeByName, FromNamedRecord)
import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Data.Vector (Vector)
import qualified Data.Vector as V

import System.Exit (die)

import Options (Options(..))
import Types

data Params = Params
  { pFormat :: Text
  , pName :: FileName
  , pColor :: Color
  , pSize :: Size
  , pImages :: Vector ImageEntry
  , pTexts :: Vector TextEntry
  }

defaultParams :: Options -> IO Params
defaultParams Options{..} = do
  images <- toEntry optImagesConf
  texts <- toEntry optTextConf
  return $ Params
    { pFormat = fromMaybe "png" optFormat
    , pName = optName
    , pColor = fromMaybe (255,255,255) optColor
    , pSize = optSize
    , pImages = images
    , pTexts = texts
    }

toEntry :: FromNamedRecord a => Maybe FilePath -> IO (Vector a)
toEntry Nothing = return V.empty
toEntry (Just path) = do
  toDecode <- readFile path
  case decodeByName toDecode of
    Left err -> die err
    Right (_header, entries) -> return entries
  
