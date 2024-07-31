my dotfiles. Use at your own risk!

TODO: document this better.


## migrating from non-bare repo:

Inspired by using a bare repo pattern: https://www.atlassian.com/git/tutorials/dotfiles

```
git clone --bare <git-repo-url> $HOME/.cfg
cd ~
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME' # set this as a one-off, as it's in ~/.zshrc
config checkout
config config --local status.showUntrackedFiles no

```

if you get an error like:
```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```

move the files into a `.config-backup` dir:

``` sh
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

remove the old `.git` dir, if it exists (`rm -rf .git`)


## tracking the remote branch:
Fix:
https://morgan.cugerone.com/blog/workarounds-to-git-worktree-using-bare-repository-and-cannot-fetch-remote-branches/

To track the remote branch, you have to pull the remote down (not allowed by default on bare repos)

``` sh
cd ~/.cfg
vim config
```

add this:

``` 
[remote "origin"]
    url = …
    fetch = +refs/heads/*:refs/remotes/origin/*
```

Now, any `git fetch origin` or `git worktree add...` command will, when necessary, retrieves the remote branches that are missing locally.
