#!/usr/bin/env bash
git config --global core.editor vim

# aliases
git config --global alias.s "status --short--"

# gpg
git config --global commit.gpgsign true
# git config --global user.signingkey <id>