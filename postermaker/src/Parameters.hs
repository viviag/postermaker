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
  images <- toEntry $ fromMaybe "images.csv" optImagesConf
  texts <- toEntry $ fromMaybe "texts.csv" optTextConf
  return $ Params
    { pFormat = fromMaybe "png" optFormat
    , pName = optName
    , pColor = fromMaybe (255,255,255) optColor
    , pSize = optSize
    , pImages = images
    , pTexts = texts
    }

toEntry :: FromNamedRecord a => FilePath -> IO (Vector a)
toEntry path = do
  toDecode <- readFile path
  case decodeByName toDecode of
    Left err -> die err
    Right (_header, entries) -> return entries
  
