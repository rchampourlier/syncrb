# README

## Getting started

    cd ~
    git clone https://github.com/rchampourlier/syncrb.git
    cd syncrb
    ./sync

This will copy a set of files defined by the plugins in `plugins`
(currently handles Sublime Text 2, some OS X files, the shell login
scripts, OhMyZsh and some Git config files) in `~/.sync_content`, and
create a new commit for these files in a Git repo setup in the
`.sync_content` directory.