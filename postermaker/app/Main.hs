module Main where

import qualified Data.Vector as V

import Magick
import Options
import Parameters

act :: Params -> IO ()
act Params{..} = do
  createCanvas pName pSize pColor

  V.mapM_ (insertImage pName) pImages
  V.mapM_ (insertText pName) pTexts

main :: IO ()
main = do
  opts <- options welcome parser

  act $ defaultParams opts
