module Main where

import qualified Data.Vector as V

import Magick
import Options
import Parameters

act :: Params -> IO ()
act Params{..} = do
  createCanvas pName pFormat pSize pColor

  V.mapM_ (insertImage pName pFormat) pImages
  V.mapM_ (insertText pName pFormat) pTexts

main :: IO ()
main = do
  opts <- options welcome parser

  params <- defaultParams opts
  act params
