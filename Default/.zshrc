# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

dotpull() {
  git -C ~/.dotfiles fetch origin master && git -C ~/.dotfiles reset --hard origin/master  && ~/.dotfiles/install.sh
}

[[ -r "/opt/homebrew/etc/profile.d/z.sh" ]] && source "/opt/homebrew/etc/profile.d/z.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -e "${HOME}/.secrets" ]] && source "${HOME}/.secrets"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

REACT_EDITOR=idea
