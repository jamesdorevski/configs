# dotnet
export PATH=$PATH:$HOME/.dotnet
export DOTNET_ROOT=$HOME/.dotnet

# Pyenv
export PYENV_ROOT=$HOME/.pyenv
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Zoxide
alias cd=z
eval "$(zoxide init zsh)"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
[ -s "$HOMEBREW_PREFIX/opt/jabba/jabba.sh" ] && . "$HOMEBREW_PREFIX/opt/jabba/jabba.sh"

# Starship
eval "$(starship init zsh)"

# ZSH plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh