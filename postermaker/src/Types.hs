module Types where

import Data.Csv
import Data.Monoid ((<>))
import qualified Data.Text as T
import Data.Text (Text)

type FileName = Text

type Color = (Int, Int, Int)

type Size = (Double, Double)

type Coord = Size

data ImageEntry = ImageEntry
  { imagePath :: Text
  , imageCorner :: Coord
  }

instance FromNamedRecord ImageEntry where
    parseNamedRecord m = ImageEntry <$> m .: "image" <*> m .: "coords"

data TextEntry = TextEntry
  { textText :: Text
  , textFont :: Text
  , textPointSize :: Text
  , textColor :: Color
  }

instance FromNamedRecord TextEntry where
    parseNamedRecord m = TextEntry <$> m .: "text" <*> m .: "font" <*> m .: "pointsize" <*> m .: "color"
