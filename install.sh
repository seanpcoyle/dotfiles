#!/usr/bin/env bash

set -e
set -o pipefail

# On macOS have coreutils preempt default commands
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:${PATH}"

# Bootstrap the project
if [[ ! -e ~/.dotfiles ]]; then
  git clone git@github.com:seanpcoyle/dotfiles.git ~/.dotfiles
  ~/.dotfiles/install.sh
  exit
fi

if [[ ! -e /opt/homebrew ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

create_links() {
  local dir="${1:?dir is missing}"

  if [[ -d "${dir}" ]]; then
    cp -rsvf "${dir}/." "${HOME}" 2>/dev/null || :
  fi
}

install_script() {
  local source="${1:?source is missing}"
  local target="${2:?target is missing}"

  if ! grep -q "${source}" "${target}"; then
    printf "\n[[ -s \"${source}\" ]] && source \"${source}\"\n" >> "${target}"
  fi
}

if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Symlink platform-agnostic and platform-specific files to home directory
create_links "${HOME}/.dotfiles/Default"
create_links "${HOME}/.dotfiles/$(uname)"

install_script "${HOME}/.dotfiles/bin/zprofile.sh" "${HOME}/.zprofile"

install_script "${HOME}/.aliases" "${HOME}/.zshrc"
install_script "${HOME}/.oh-my-zsh/config" "${HOME}/.zshrc"

brew bundle --file="${HOME}/.Brewfile"

mkdir -p "${HOME}/.oh-my-zsh/themes/powerlevel10k"

if [[ ! -e "${HOME}/.oh-my-zsh/themes/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  ln -s "$(brew --prefix powerlevel10k)/powerlevel10k.zsh-theme" \
    "${HOME}/.oh-my-zsh/themes/powerlevel10k/powerlevel10k.zsh-theme"
fi

[[ ! -e "${HOME}/.secrets" ]] && touch "${HOME}/.secrets"

sh -c "${HOME}/.dotfiles/bin/app_store_apps.sh"
sh -c "${HOME}/.dotfiles/bin/macos.sh"

echo 'Done!'
