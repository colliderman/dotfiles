# Dotfiles

Just a place for keeping my dotfiles accessible and versioned.

### GNU Stow

GNU Stow makes it easy to store all of my dotfiles in a single directory for easy versioning, and then simply run the `stow` command 
to create symbolic links in the correct places.

For example, I want my `.ideavimrc` in my user home dir. So I create a `ideaVim/` directory inside my dotfiles directory and put my `.ideavimrc` inside it.

Then all I need to do is run the following comman and Stow will create the sym link to my `.ideavimrc` file for me.

```shell
$ cd ~/.dotfiles
$ stow ideaVim
```

Et voila.
