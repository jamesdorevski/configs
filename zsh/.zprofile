export PATH=$PATH:$HOME/.dotnet

export PYENV_ROOT=$HOME/.pyenv
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias cd=z
eval "$(zoxide init zsh)"

eval "$(/opt/homebrew/bin/brew shellenv)"
