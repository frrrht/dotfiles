#!/bin/sh

# <frrrht-helpers command>
dev() {
	if [ -z "$1" ] || [ "$1" = 'help' ] || [ "$1" = '' ]; then
		# Help command
		echo -e "       📄 \e[1mfrrrht-helpers"
		echo -e "  \e[1mhttps://github.com/frrrht/dotfiles\e[0m\n"

		echo -e "\e[33mUsage:\e[0m"
		echo -e "  'dev [command]'\n"

		echo -e "\e[33mAvailable commands:\e[0m"
		echo -e "  \e[32mhelp\e[0m\t\t\tShows this help screen"

		echo -e "\n\e[33mGlobal shell helpers:\e[0m"
		echo -e "  \e[32mreloadshell\e[0m\t\tReload the shell configuration."
		echo -e "  \e[32meditshell\e[0m\t\tEdit the shell configuration and reload it when closing."
		echo -e "  \e[32mdotfiles\e[0m\t\tNavigate to the dotfiles directory, pull the latest changes and reload the shell."

		echo -e "\n\e[33mMacOS helpers:\e[0m"
		echo -e "  \e[32mcat\e[0m\t\t\tConcatenate and print files (on steroids). Plain text, no paging, no line numbers"
		echo -e "  \e[32mcatt\e[0m\t\t\tConcatenate and print files (on steroids) without paging and with line numbers."
		echo -e "  \e[32mcattt\e[0m\t\t\tConcatenate and print files (on steroids) with scrollable paging and line numbers."
		echo -e "  \e[32mvim\e[0m\t\t\tNeoVIM, hyperextensible Vim-based text editor. (hint: ^c + :qa! & ^c + :wq)"
		echo -e "  \e[32mzipfix\e[0m\t\tRemove .DS_Store files for all .zip archives in the current working directory."
		echo -e "  \e[32mcd\e[0m\t\t\tZioxide's efficient directory browser."
		echo -e "  \e[32mfinder\e[0m\t\tOpen the current working directory in Finder."
		echo -e "  \e[32mno_ds\e[0m\t\t\tRemove all .DS_Store files in the current working directory, recursively."
		echo -e "  \e[32mcopy\e[0m\t\t\tCopy the content of a given file to the clipboard."

		echo -e "\n\e[33mDevelopment helpers:\e[0m"
		echo -e "  \e[32msubl\e[0m\t\t\tOpen the specified directory or file in Sublime Text."
		echo -e "  \e[32mwip\e[0m\t\t\tQuick commit and push with 'wip' message. Accepts a custom message."
		echo -e "  \e[32mrepo\e[0m\t\t\tOpens the current git repository in the browser"
		echo -e "  \e[32msite\e[0m\t\t\tOpens the current directory in the browser (http://{dir}.test/)"
		echo -e "  \e[32mclean\e[0m\t\t\tClean stale git branches and .DS_Store files."
		echo -e "  \e[32mnr\e[0m\t\t\tShortcut for 'npm run [script]'."

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
		echo -e "  \e[32mmfs\e[0m\t\t\tRuns 'php artisan migrate:fresh --seed'"
		echo -e "  \e[32mdusk\e[0m\t\t\tRuns Dusk in the current context"
	else
		error_msg "Unknown command: '\e[91m$1\e[0m'. Use 'dev help' to list all available commands."
	fi
}
# </frrrht-helpers command>

# <Formatters>
usage_msg() {
  echo -e "  \n\e[33mUsage: \e[0m$1\e[0m\n"
}
error_msg() {
  echo -e "  \n\e[91mError: \e[0m$1\e[0m\n"
}
success_msg() {
  echo -e "  \n\e[32mSuccess: \e[0m$1\e[0m\n"
}
info_msg() {
  echo -e "  \n\e[33m$1\e[0m\n"
}
# </Formatters>

# <Global shell helpers>
alias reloadshell="source $HOME/.zshrc"
alias editshell="vim $HOME/.zshrc && reloadshell"
# <Global shell helpers>

# <MacOS helpers>
alias cat='bat -P -p'
alias catt='bat --paging=never'
alias cattt='bat'
alias vim='nvim'
alias zipfix='for f in *.zip; do zip -d "$f" "__MACOSX/*"; done; for f in *.zip; do zip -d "$f" "*/.DS_Store"; done;'
alias cd='z'
alias finder='open .'
copy() {
  if [ -z "$1" ]; then
    usage_msg "copy [file]"
  else
    if [ ! -f "$1" ]; then
      error_msg "File not found: \e[32m$1\e[0m"
      return
    fi

    pbcopy < "$1"
    success_msg "Copied content of \e[33m$1\e[0m to clipboard."
  fi
}
# </MacOS helpers>

# <Development helpers>
alias subl='sublime'
alias site='open "http://$(basename $PWD).test/"'
sublime() {
	open "$1" -a 'Sublime Text'
}
wip() {
    if [ $# -eq 0 ]; then
        git add .
        git commit -m 'wip'
    else
        git add .
        git commit -m "$*"
    fi
    git push
}
repo() {
  if [[ $(git config --get remote.origin.url) == "https://"* ]]; then
    URL=$(git config --get remote.origin.url | sed -E 's/\.git$//')
  else
    URL=$(git config --get remote.origin.url | sed -E 's/.*@//;s/:/\//;s/\.git$//')
  fi

  if [ -z "$URL" ]; then
     error_msg "No remote origin URL found."
  else
    open "https://$URL"
  fi
}
no_ds() {
  info_msg "Cleaning .DS_Store files..."
	find . -type f -name '.DS_Store' -delete
  success_msg "Cleaned .DS_Store files."
}
clean() {
	if [ -d .git ]; then
		info_msg "Cleaning stale git branches..."
		git branch --merged | grep -v "\* \| main\|master\|develop" | xargs -n 1 git branch -d
	fi

	no_ds
}
nr() {
  if [ -z "$1" ]; then
    npm run
  else
    npm run $*
  fi
}
# </Development helpers>

# <Laravel/PHP specific helpers>
alias sail='vendor/bin/sail'
alias phpunit='vendor/bin/phpunit'
alias pest='clear;vendor/bin/pest'
alias pestp='clear;vendor/bin/pest --parallel'
alias pint='clear;vendor/bin/pint'
alias duster='vendor/bin/duster'
alias phpstan='vendor/bin/phpstan'
alias mfs='ar migrate:fresh --seed'
alias dusk='clear;ar dusk'

ar() {
  if [ $# -eq 0 ]; then
    php artisan
  else
    php artisan $*
  fi
}
pestf() {
  clear
  info_msg "Running Pest tests with filter: $*"
  vendor/bin/pest --filter="$*"
}
pestpf() {
  clear
  vendor/bin/pest --parallel --filter="$*"
}
pintf() {
  clear
  vendor/bin/pint --filter="$*"
}
# </Laravel/PHP specific helpers>

# <Self-update>
alias dotfiles="cd $HOME/dotfiles; git pull; reloadshell"
# </Self-update>