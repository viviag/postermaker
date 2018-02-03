module Magick where

import Control.Applicative (empty)

import Data.Monoid ((<>))
import Data.Text (Text)
import qualified Data.Text as T
import Turtle.Prelude (stdout, inproc)

import Types

createCanvas :: FileName -> Text -> Size -> Color -> IO ()
createCanvas name format size color = stdout $ inproc "convert" ["-size", imSize, "canvas:rgb(" <> imColor <> ")",  path] empty
  where
    imSize = prepareSize size
    imColor = prepareColor color
    path = name <> "." <> format

insertImage :: FileName -> Text -> ImageEntry -> IO ()
insertImage name format ImageEntry{..} = stdout $ inproc "composite" ["-geometry", imCoords, imagePath, path, path] empty
  where
    imCoords = prepareCoords imageCorner
    path = name <> "." <> format

insertText :: FileName -> Text -> TextEntry -> IO ()
insertText name format TextEntry{..} = do
  stdout $ inproc "convert" [path, "-background", "transparent"
                            , "-fill", "rgb(" <> prepareColor textColor <> ")"
                            , "-font", textFont, "-pointsize", textPointSize
                            , "-annotate", prepareCoords textCorner, textText, path] empty
  where
    path = name <> "." <> format

showT :: Show a => a -> Text
showT = T.pack . show

prepareColor :: Color -> Text
prepareColor (r,g,b) = showT r <> "," <> showT g <> "," <> showT b

prepareSize :: Size -> Text
prepareSize (x, y) = showT x <> "x" <> showT y

prepareCoords :: Coord -> Text
prepareCoords (x, y) = "+" <> showT x <> "+" <> showT y
