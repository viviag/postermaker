module Magick where

import Turtle

import Types

createCanvas :: FileName -> Size -> Color -> IO ()

insertImage :: FileName -> ImageEntry -> IO ()

insertText :: FileName -> TextEntry -> IO ()

showT :: Show a => a -> Text
showT = T.pack . show

prepareColor :: Color -> Text
prepareColor (r,g,b) = showT r <> "," <> showT g <> "," <> showT b

prepareSize :: Size -> Text
prepareSize (x, y) = showT x <> "x" <> showT y
