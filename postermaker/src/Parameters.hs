module Parameters
  ( Params{..}
  , defaultParams
  ) where

import Data.ByteString.Lazy (readFile)
import Data.Csv (decode)
import Data.Maybe (fromMaybe)
import Data.Monoid ((<>))
import Data.Vector (Vector)

import Filesystem.Path.CurrentOS (encodeString)
import System.Exit (die)

import Options (Options{..})
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
  images <- toEntry $ fromMaybe ("images" <.> "csv") optImagesConf
  texts <- toEntry $ fromMaybe ("texts" <.> "csv") optTextConf
  return $ Params
    { fromMaybe "png" optFormat
    , optName
    , fromMaybe (255,255,255) optColor
    , optSize
    , images
    , texts
    }

toEntry :: FromNamedRecord a -> FilePath -> IO a
toEntry path = do
  toDecode <- readFile (encodeString path)
  case decodeByName toDecode of
    Left err -> die ("Cannot decode from CSV " <> path)
    Right (_header, entries) -> return entries
  
