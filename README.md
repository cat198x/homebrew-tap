# cat198x Homebrew tap

Homebrew formulae for [cat198x](https://github.com/cat198x/cat198x), which catalogues, verifies and reorganises retro software and media collections.

```sh
brew install cat198x/homebrew-tap/cat198x
```

## About this repository

The formulae here are **generated**, not hand-written. Each cat198x release runs
`cargo-dist`, which builds the platform archives, writes the formula from the
release's own manifest, and commits it to this repository.

So changes belong upstream: edit the packaging configuration in
[`cat198x/cat198x`](https://github.com/cat198x/cat198x) rather than the formula, or a
release will overwrite them.
