<p align="center"><img src=".github/logo.png" width="400"></p>

<p align="center">
  <sup><em>really bad, don't use</em></sup>
</p>

## About
These are my personal [dotfiles](https://www.freecodecamp.org/news/dive-into-dotfiles-part-1-e4eb1003cff6/). I use them to backup, restore, and sync prefs and settings on my MacBook.  
Feel free to use anything you find in this repo. 

## Installing just the helpers
You can choose to only install the helpers.  
- If you already have the helpers installed:
  ```
  musa update
  ```
- First time installing:  
  ```
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/musa11971/dotfiles/master/helpers/install-helpers.sh)"
  ```

## Setting up new mac
Follow these install instructions to setup a new Mac.

1. Update macOS to the latest version with the App Store
2. Install Xcode from the App Store, open it and accept the license agreement
3. Install macOS Command Line Tools by running `xcode-select --install`
4. Clone this repo to `~/.dotfiles`.
5. Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh#getting-started)
6. Run `install.sh` to start the installation
9. Restart your computer to finalize the process

Your Mac is now ready to use!

## Contributing
Contributions are currently not encouraged, as these are my personal dotfiles.  
Pull requests that fix bugs/typos, clean up stuff or improve efficiency/maintainability are welcomed.

## Sources used
- https://dotfiles.github.io/
- https://driesvints.com/blog/getting-started-with-dotfiles/
- https://github.com/driesvints/dotfiles
