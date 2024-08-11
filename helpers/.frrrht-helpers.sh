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
		echo -e "  \e[32mcat\e[0m\t\t\tConcatenate and print files (on steroids). Plain text, no paging, no line numbers"
		echo -e "  \e[32mcatt\e[0m\t\t\tConcatenate and print files (on steroids) without paging and with line numbers."
		echo -e "  \e[32mcatt\e[0m\t\t\tConcatenate and print files (on steroids) with scrollable paging and line numbers."
		echo -e "  \e[32mvim\e[0m\t\t\tNeoVIM, hyperextensible Vim-based text editor. (hint: ^c + :qa! & ^c + :wq)"
		echo -e "  \e[32mzipfix\e[0m\t\tRemove .DS_Store files for all .zip archives in the current working directory."
		echo -e "  \e[32mcd\e[0m\t\t\tZioxide's efficient directory browser."
		echo -e "  \e[32mfinder\e[0m\t\tOpen the current working directory in Finder."

		echo -e "\n\e[33mDevelopment helpers:\e[0m"
		echo -e "  \e[32msubl\e[0m\t\t\tOpen the specified directory or file in Sublime Text."
		echo -e "  \e[32mwip\e[0m\t\t\tQuick commit and push with 'wip' message. Accepts a custom message."
		echo -e "  \e[32mrepo\e[0m\t\t\tOpens the current git repository in the browser"
		echo -e "  \e[32msite\e[0m\t\t\tOpens the current directory in the browser (http://{dir}.test/)"
		echo -e "  \e[32mclean\e[0m\t\t\tClean stale git branches and .DS_Store files."

		echo -e "\n\e[33mLaravel helpers:\e[0m"
		echo -e "  \e[32mar\e[0m\t\t\tRuns Laravel Artisan commands in the current context."
		echo -e "  \e[32msail\e[0m\t\t\tRuns Laravel Sail commands in the current context."
		echo -e "  \e[32mphpunit\e[0m\t\tRuns PHPUnit tests in the current context."
		echo -e "  \e[32mpest\e[0m\t\t\tRuns Pest tests in the current context"
		echo -e "  \e[32mpestf\e[0m\t\t\tRuns Pest tests in the current context with a filter"
		echo -e "  \e[32mpestp\e[0m\t\t\tRuns Pest tests in the current context in parallel"
		echo -e "  \e[32mpestpf\e[0m\t\tRuns Pest tests in the current context in parallel with a filter"
		echo -e "  \e[32mpint\e[0m\t\t\tRuns Pint in the current context"
		echo -e "  \e[32mpintf\e[0m\t\t\tRuns Pint in the current context with a filter"
		echo -e "  \e[32mduster\e[0m\t\tRuns Duster in the current context"
		echo -e "  \e[32mphpstan\e[0m\t\tRuns PHPStan in the current context"
		echo -e "  \e[32mmfs\e[0m\t\t\tRuns php artisan migrate:fresh --seed"
	else
		echo -e "\e[91mUnknown command, use 'frr help' to list all available commands."
	fi
}

# Global shell helpers
alias reloadshell="source $HOME/.zshrc"
alias editshell="vim $HOME/.zshrc && reloadshell"

# MacOS helpers
alias cat='bat --plain --paging=never'
alias catt='bat --paging=never'
alias cattt='bat'
alias vim='nvim'
alias zipfix='for f in *.zip; do zip -d "$f" "__MACOSX/*"; done; for f in *.zip; do zip -d "$f" "*/.DS_Store"; done;'
alias cd='z'
alias finder='open .'

# Development helpers
sublime() {
	open "$1" -a "Sublime Text"
}
alias subl="sublime"
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
ar() {
  if [ $# -eq 0 ]; then
    php artisan
  else
    php artisan "$@"
  fi
}
alias sail='vendor/bin/sail'
alias phpunit='vendor/bin/phpunit'
alias pest='clear;vendor/bin/pest'
pestf() {
  clear
  echo "  \n\e[33mRunning Pest tests with filter: \e[0m$1[0m\n"
  vendor/bin/pest --filter="$1"
}
alias pestp='clear;vendor/bin/pest --parallel'
pestpf() {
  clear
  vendor/bin/pest --parallel --filter="$1"
}
alias pint='clear;vendor/bin/pint'
pintf() {
  clear
  vendor/bin/pint --filter="$1"
}
alias duster='vendor/bin/duster'
alias phpstan='vendor/bin/phpstan'
alias mfs='php artisan migrate:fresh --seed'

# Self-update
alias dotfiles="cd $HOME/dotfiles; git pull"