# Ninja Generator for Curry

A small library for generating [Ninja](https://ninja-build.org/) build files in Curry.

## Background

Ninja is a modern, lightweight, low-level alternative to Make that encourages users to generate its `build.ninja` files rather than writing them by hand. The advantage of this approach is speed, since Ninja can quickly parse the entire dependency graph without having to run through expensive shell calls/globs/etc, simplicity and debuggability as the user can easily see what the generated graph expands to. Additionally Ninja offers some conveniences over Make such as automatically taking care of folder creation, a nice progress output line and better defaults (parallelism, immutable variables, ...). This makes it a great fit for large projects with heavily customized build setups, especially when they involve compiling multiple languages with different compilers and tools.

This Curry library came up as a byproduct from experimenting with a Ninja-based build system for use in [the KiCS2 Curry compiler](https://git.ps.informatik.uni-kiel.de/curry/kics2), mostly to see whether creating an expressive DSL for this purpose was possible.
