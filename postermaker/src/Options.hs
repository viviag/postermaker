module Options
  ( Options(..)
  , parser
  , welcome
  , Turtle (options)
  ) where

import Prelude hiding (FilePath)

import Control.Applicative (optional)

import Data.Monoid ((<>))
import Data.Text
import Turtle.Options
import Turtle (options, FilePath)

import Types

data Options = Options
  { optFormat :: Maybe Text
  , optName :: FileName
  , optColor :: Maybe Color
  , optSize :: Size
  , optImagesConf :: Maybe FilePath
  , optTextConf :: Maybe FilePath
  }

parser :: Parser Options
parser = Options <$> optional (optText "format" 'f' "Format in which to write output image. PNG by default.")
                 <*> optText "name" 'n' "Name of resulting image."
                 -- FIXME: write another Read instances for these tuples - do not require brackets.
                 <*> optional (optRead "color" 'c' "Background color in \"(r,g,b)\" format. White by default.")
                 <*> optRead "size" 's' "Image size in \"(x,y)\" format."
                 <*> optional (optRead "images" 'i' "Path to images configuration file. ./images.csv by default.")
                 <*> optional (optRead "texts" 't' "Path to texts configuration file. ./texts.csv by default.")

welcome :: Description
welcome = Description $ "---\n"
  <> "Create poster or collage based on options and given mappings.\n"
  <> "Uses ImageMagick inside."
