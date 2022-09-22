module Language.Ninja.Builder
  ( NinjaBuilder
  , build, rule, var, comment, whitespace
  , execNinjaBuilder
  ) where

import Control.Monad.Trans.Writer ( WriterT, tell, execWriterT )
import Data.Functor.Identity ( Identity (..) )
import Language.Ninja.Types

type NinjaBuilderT = WriterT Ninja

type NinjaBuilder = NinjaBuilderT Identity

build :: Monad m => Build -> NinjaBuilderT m ()
build b = tell $ Ninja [BuildStmt b]

rule :: Monad m => Rule -> NinjaBuilderT m ()
rule r = tell $ Ninja [RuleStmt r]

var :: Monad m => Var String -> NinjaBuilderT m ()
var v = tell $ Ninja [VarStmt v]

comment :: Monad m => String -> NinjaBuilderT m ()
comment c = tell $ Ninja [CommentStmt c]

whitespace :: Monad m => NinjaBuilderT m ()
whitespace = tell $ Ninja [WhitespaceStmt]

execNinjaBuilderT :: Monad m => NinjaBuilderT m a -> m Ninja
execNinjaBuilderT = execWriterT

execNinjaBuilder :: NinjaBuilder a -> Ninja
execNinjaBuilder = runIdentity . execNinjaBuilderT
