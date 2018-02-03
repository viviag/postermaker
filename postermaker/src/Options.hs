module Options
  ( Options(..)
  , parser
  , welcome
  , options
  ) where

import Control.Applicative (optional)

import Data.Monoid ((<>))
import Data.Text
import Turtle.Options
import Turtle (options)

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
                 -- FIXME: Custom Read instances.
                 <*> optional (optRead "color" 'c' "Background color in \"(r,g,b)\" format. White by default.")
                 <*> optRead "size" 's' "Image size in \"(x,y)\" format."
                 <*> optional (unpack <$> optText "images" 'i' "Path to images configuration file.")
                 <*> optional (unpack <$> optText "texts" 't' "Path to texts configuration file.")

welcome :: Description
welcome = Description $ "---\n"
  <> "Create poster or collage based on options and given mappings.\n"
  <> "Coords and colors in mappings are formatted as x-y and r-g-b correspondingly.\n"
  <> "Uses ImageMagick inside."
