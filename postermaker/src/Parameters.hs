{-# LANGUAGE ScopedTypeVariables #-}
module Parameters
  ( Params(..)
  , defaultParams
  ) where

import Control.Exception (catch)

import qualified Data.ByteString.Lazy as BSL
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
  images <- catch (toEntry optImagesConf) (\(e :: IOError) -> do print e; return V.empty)
  texts <- catch (toEntry optTextConf) (\(e :: IOError) -> do print e; return V.empty)
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
  toDecode <- BSL.readFile path
  case decodeByName toDecode of
    Left err -> die err
    Right (_header, entries) -> return entries
  
