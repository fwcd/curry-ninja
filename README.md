# Ninja Generator for Curry

A small library for generating [Ninja](https://ninja-build.org/) build files in Curry.

## Background

Ninja is a modern, lightweight, low-level alternative to Make that encourages users to generate its `build.ninja` files rather than writing them by hand. The advantage of this approach is speed, simplicity and debuggability: Ninja can quickly parse the entire dependency graph without having to run through expensive shell calls/globs/etc and the user can easily see what the generated graph expands to. Additionally Ninja offers some conveniences over Make such as automatic folder creation, a nice progress line and better defaults (parallelism, immutable variables, ...). This makes it a great fit for large projects with heavily customized build setups, especially when they involve compiling multiple languages with different compilers and tools.

This Curry library came up as a byproduct from experimenting with a Ninja-based build system for use in [the KiCS2 Curry compiler](https://git.ps.informatik.uni-kiel.de/curry/kics2), mostly to see whether creating an expressive DSL for this purpose was possible.

## Example

The following is an example of how a simple Ninja file can be expressed in Curry using the `NinjaBuilder` monad:

```curry
import Language.Ninja.Builder
import Language.Ninja.Pretty
import Language.Ninja.Types

main :: IO ()
main = writeFile "build.ninja" $ ppNinja $ execNinjaBuilder $ do
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
```

generates

```ninja
# Flags
cflags = -Wall

# Rules
rule cc
  command = gcc $cflags -c $in -o $out

# Builds
build foo.o: cc foo.c
```

> Note: Since a transformer version of the monad is available too (`NinjaBuilderT`), it is easy to create a monad that supports IO (`NinjaBuilderT IO`) and e.g. generate build files depending on source files in a directory.

<!-- TODO: Add an example of NinjaBuilderT IO used this way -->
