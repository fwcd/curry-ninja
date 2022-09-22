module Language.Ninja.Example
  ( exampleNinja
  ) where

import Language.Ninja.Builder ( execNinjaBuilder, comment, var, rule, build, whitespace )
import Language.Ninja.Types

exampleNinja :: Ninja
exampleNinja = execNinjaBuilder $ do
  comment "Flags"
  var $ "cflags" =. "-Wall"
  whitespace

  comment "Rules"
  rule $ (emptyRule "cc")
    { ruleCommand = Just "gcc $cflags -c $in -o $out"
    }
  whitespace

  comment "Builds"
  build $ ["foo.o"] :. ("cc", ["foo.c"])
