# homebrew-tap

Homebrew tap for [CopyHistory](https://github.com/B-PRAVEEN/CopyHistory).

```sh
brew tap B-PRAVEEN/tap
brew trust B-PRAVEEN/tap   # Homebrew 7 only loads casks from taps you trust
brew install --cask copyhistory
```

CopyHistory is not notarised by Apple; see the cask caveats (`brew info --cask copyhistory`) for the one-time first-launch approval.
