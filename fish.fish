#!/usr/bin/env fish

# ln -s <this_file> ~/.config/fish/config.fish
# or in ~/.config/fish/config.fish
# source <this_file>

# Without --global, they'll be universal, and
# will persist in ~/.config/fish/fish_variables after they are removed here
abbr --add --global cp "cp --interactive"  # confirm if overwriting
abbr --add --global g 'git'
abbr --add --global gs 'git status'
abbr --add --global l 'ls -CF'
abbr --add --global mv "mv --interactive"  # confirm if overwriting
abbr --add --global v 'vim'
if string match --quiet '*Windows' < /proc/sys/kernel/osrelease
	abbr --add --global p 'powershell.exe'
	abbr --add --global s 'smerge.exe .'
end