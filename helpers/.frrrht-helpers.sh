#!/bin/sh

# frrrht-helpers command
frr() {
	if [ -z "$1" ] || [ "$1" = 'help' ] || [ "$1" = '' ]; then
		# Help command
		echo -e "       📄 \e[1mfrrrht-helpers"
		echo -e "  \e[1mhttps://github.com/frrrht/dotfiles\e[0m\n"
		echo -e "\e[33mUsage:\e[0m"
		echo -e "  'frr [command]'\n"
		echo -e "\e[33mAvailable commands:\e[0m"
		echo -e "  \e[32mhelp\e[0m\t\t\tShows this help screen"
		echo -e "\n\e[33mGlobal shell helpers:\e[0m"
		echo -e "  \e[32mreloadshell\e[0m\t\tReload the shell configuration."
		echo -e "  \e[32meditshell\e[0m\t\tEdit the shell configuration and reload it when closing."
		echo -e "\n\e[33mMacOS helpers:\e[0m"
		echo -e "  \e[32mcat\e[0m\t\t\tConcatenate and print files (on steroids)."
		echo -e "  \e[32mcatp\e[0m\t\t\tConcatenate and print files (on steroids) with scrollable paging."
		echo -e "  \e[32mvim\e[0m\t\t\tNeoVIM, hyperextensible Vim-based text editor. (hint: ^c + :qa! & ^c + :wq)"
		echo -e "  \e[32mzipfix\e[0m\t\tRemove .DS_Store files for all .zip archives in the current working directory."
		echo -e "  \e[32mcd\e[0m\t\t\tZioxide's efficient directory browser."
		echo -e "  \e[32mfinder\e[0m\t\tOpen the current working directory in Finder."
		echo -e "  \e[32mpint\e[0m\t\t\tRuns Pint in the current context"
		echo -e "  \e[32mpest\e[0m\t\t\tRuns Pest tests in the current context"
		echo -e "  \e[32mpestf\e[0m\t\t\tRuns Pest tests in the current context, with a filter"
		echo -e "  \e[32mmfs\e[0m\t\t\tRuns php artisan migrate:fresh --seed"
		echo -e "  \e[32mfinder\e[0m\t\tOpens the current folder in Finder"
		echo -e "  \e[32mrepo\e[0m\t\t\tOpens the current git repository in the browser"
		echo -e "  \e[32msite\e[0m\t\t\tOpens the current directory in the browser (http://{dir}.test/)"
	else
		echo -e "\e[91mUnknown command, use 'frr help' to list all available commands."
	fi
}

# Global shell helpers
alias reloadshell="source $HOME/.zshrc"
alias editshell="vim $HOME/.zshrc && reloadshell"

# MacOS helpers
alias cat='bat --paging=never'
alias catp='bat'
alias vim='nvim'
alias zipfix='for f in *.zip; do zip -d "$f" "__MACOSX/*"; done; for f in *.zip; do zip -d "$f" "*/.DS_Store"; done;'
alias cd='z'
alias finder='open .'
sublime() {
	open "$1" -a "Sublime Text"
}
alias subl="sublime"

# Development helpers
wip() {
    if [ $# -eq 0 ]; then
        git add .
        git commit -m "wip"
    else
        git add .
        git commit -m "$*"
    fi
    git push
}
alias repo='open "$(git config --get remote.origin.url)"'
alias site='open "http://$(basename $PWD).test/"'
clean() {
	if [ -d .git ]; then
		echo -e "\e[32mCleaning stale git branches..."
		git branch --merged | grep -v "\* \| main\|master\|develop" | xargs -n 1 git branch -d
	fi

	echo -e "\e[32mCleaning .DS_Store files..."
	find . -type f -name '.DS_Store' -delete
}

# Laravel/PHP specific helpers
alias sail='vendor/bin/sail'
alias phpunit='vendor/bin/phpunit'
alias pest='clear;vendor/bin/pest'
alias pestf='clear;vendor/bin/pest --filter='
alias pestp='clear;vendor/bin/pest --parallel'
alias pestpf='clear;vendor/bin/pest --parallel --filter='
alias pint='clear;vendor/bin/pint'
alias pintf='clear;vendor/bin/pint --filter='
alias duster='vendor/bin/duster'
alias phpstan='vendor/bin/phpstan'
alias duster='vendor/bin/duster'
alias mfs='php artisan migrate:fresh --seed'

# Self-update
alias dotfiles="cd $HOME/dotfiles; git pull"