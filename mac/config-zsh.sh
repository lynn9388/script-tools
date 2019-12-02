#!/bin/zsh

mkdir -p ~/.zsh
cd ~/.zsh

curl -O https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

curl -O https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/_docker
curl -O https://raw.githubusercontent.com/docker/machine/master/contrib/completion/zsh/_docker-machine
curl -O https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose

git config --global user.name Lynn
git config --global user.email lynn9388@gmail.com
git config --global merge.conflictStyle diff3
git config --global gpg.program gpg2
git config --global user.signingkey EC6618DB26F0A0B2
git config --global commit.gpgsign true
git config --global http.proxy socks5h://localhost:1090
git config --global core.excludesfile ~/.zsh/macOS.gitignore

cat <<'EOT' >> ~/.zshrc
HISTFILE=~/.zsh/.zsh_history

############################## Git ##############################
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh /usr/local/share/zsh/site-functions /usr/share/zsh/site-functions /usr/share/zsh/5.7.1/functions)
autoload -Uz compinit && compinit -d ~/.zsh/.zcompdump

source ~/.zsh/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

autoload -U colors && colors
setopt PROMPT_SUBST ; PS1='%{$fg[red]%}%n%{$fg[green]%}$(__git_ps1 " (%s)") %{$fg[blue]%}%c $%{$reset_color%} '
############################## Git ##############################

export PATH=$PATH:"/Users/lynn/Documents/LaTex/bin:/Users/lynn/Documents/Blog/bin":

alias heroku1="cd /Users/lynn/Documents/Code/heroku/1/;./heroku"
alias heroku2="cd /Users/lynn/Documents/Code/heroku/2/;./heroku"
alias heroku3="cd /Users/lynn/Documents/Code/heroku/3/;./heroku"

alias gitl="git log --oneline --graph"
alias gits="git status"

alias ping2.2="ping 192.168.2.2"
alias ping2.3="ping 192.168.2.3"
alias ping2.4="ping 192.168.2.4"
alias ssh2.2="ssh -D 1091 lynn@192.168.2.2"
alias ssh2.3="ssh lynn@192.168.2.3"

alias dockerlsi="docker image ls"
alias dockerlsc="docker container ls -a"
alias dockerrmi="docker rmi \$(docker images -f \"dangling=true\" -q)"
alias dockerrmc="docker rm \$(docker ps -a -q)"
EOT
