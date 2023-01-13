#!/usr/bin/env bash
# Id$ nonnax 2022-08-28 11:36:23
ctags -f - --fields=n '%s'|fzf --layout=reverse|tr ':' '\n'|tail -1
