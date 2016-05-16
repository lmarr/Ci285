{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}

import       Data.Text (Text, unpack)
import       Yesod

data App = App

mkYesod "App" [parseRoutes|
/home          HomeR GET
/add/#Int/#Int AddR GET
/sub/#Int/#Int SubR GET
/mul/#Int/#Int MultR GET
/div/#Int/#Int DivR GET

|]

instance Yesod App

getHomeR :: Handler TypedContent
getHomeR = selectRep $ do
    provideRep $ defaultLayout $ do
     	      [shamlet|
<p>This is my Haskell Calculator|]
 
getAddR :: Int -> Int -> Handler TypedContent
getAddR x y = selectRep $ do
     provideRep $ return
         [shamlet|
               <p>#{res}
         |]
     provideJson res
   where
     res = x + y

getSubR :: Int -> Int -> Handler TypedContent
getSubR x y = selectRep $ do
     provideRep $ return
         [shamlet|
               <p>#{res}
         |]
     provideJson res
   where
     res = x - y

getMultR :: Int -> Int -> Handler TypedContent
getMultR x y = selectRep $ do
     provideRep $ return
         [shamlet|
               <p>#{res}
         |]
     provideJson res
   where
     res = x * y

getDivR :: Int -> Int -> Handler TypedContent
getDivR x y = selectRep $ do
     provideRep $ return
         [shamlet|
               <p>#{res}
         |]
     provideJson res
   where
     res = x `div` y
     
     main :: IO ()
     main = warp 3000 App
