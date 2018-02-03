{-# LANGUAGE FlexibleInstances #-}
module Types where

import Data.ByteString.Char8 (split, ByteString)
import Data.ByteString.UTF8 (toString)
import Data.Csv
import Data.Text (Text)

type FileName = Text

type Color = (Int, Int, Int)

rd :: Read a => ByteString -> a
rd = read . toString

instance (FromField a, Read a) => FromField (a,a) where
  parseField s = return $ inner (split '-' s)
    where
      inner [x,y] = (rd x, rd y)
      -- FIXME: Use more general message.
      inner _ = error "Cannot decode \"coords\" field in csv"

instance (FromField a, Read a) => FromField (a,a,a) where
  parseField s = return $ inner (split '-' s)
    where
      inner [r,g,b] = (rd r, rd g, rd b)
      -- FIXME: Use more general message.
      inner _ = error "Cannot decode \"color\" field in csv"

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
  , textCorner :: Coord
  , textFont :: Text
  , textPointSize :: Text
  , textColor :: Color
  }

instance FromNamedRecord TextEntry where
    parseNamedRecord m = TextEntry <$> m .: "text" <*> m .: "coords" <*> m .: "font" <*> m .: "pointsize" <*> m .: "color"
