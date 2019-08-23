{-# LANGUAGE OverloadedStrings #-}

module Explorer.DB.Error
  ( LookupFail (..)
  , renderLookupFail
  ) where


import           Data.ByteString.Char8 (ByteString)
import qualified Data.ByteString.Base16 as Base16
import qualified Data.Text as Text
import           Data.Text (Text)
import qualified Data.Text.Encoding as Text
import           Data.Word (Word16)


data LookupFail
  = DbLookupBlockHash !ByteString
  | DbLookupTxHash !ByteString
  | DbLookupTxOutPair !ByteString !Word16

renderLookupFail :: LookupFail -> Text
renderLookupFail lf =
  case lf of
    DbLookupBlockHash h -> "block hash " <> base16encode h
    DbLookupTxHash h -> "tx hash " <> base16encode h
    DbLookupTxOutPair h i ->
        Text.concat [ "tx out pair (", base16encode h, ", ", textShow i, ")" ]


base16encode :: ByteString -> Text
base16encode = Text.decodeUtf8 . Base16.encode

textShow :: Show a => a -> Text
textShow = Text.pack . show
