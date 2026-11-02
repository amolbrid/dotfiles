#!/usr/bin/env bash

set -Eeuo pipefail

# Rebuild the development environment recorded in the shell history.
# Targets a regular Fedora installation (not Silverblue/Kinoite) and is rerunnable.

readonly NVM_VERSION="${NVM_VERSION:-v0.40.6}"
readonly ZSH_PATINA_VERSION="${ZSH_PATINA_VERSION:-1.9.0}"
readonly LOCAL_BIN="${HOME}/.local/bin"
patina_tmp=""
idea_tmp=""
font_tmp=""

log() {
  printf '\n\033[1;34m==> %s\033[0m\n' "$*"
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

cleanup() {
  local temp_dir
  for temp_dir in "${patina_tmp}" "${idea_tmp}" "${font_tmp}"; do
    if [[ -n "${temp_dir}" && -d "${temp_dir}" ]]; then
      rm -rf -- "${temp_dir}"
    fi
  done
}

trap cleanup EXIT

command -v dnf >/dev/null 2>&1 || die "This installer requires Fedora/dnf."
[[ ${EUID} -ne 0 ]] || die "Run this as your normal user; it invokes sudo when needed."

mkdir -p "${LOCAL_BIN}" "${HOME}/.local/share/applications"

log "Installing Fedora packages"
sudo dnf install -y \
  btop curl fastfetch fontconfig git neovim python3-neovim tar unzip \
  util-linux-user xclip zsh

log "Configuring the Visual Studio Code repository"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo tee /etc/yum.repos.d/vscode.repo >/dev/null <<'REPO'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
REPO
sudo dnf install -y code

log "Installing Kitty"
curl --fail --location --show-error \
  https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
ln -sfn "${HOME}/.local/kitty.app/bin/kitty" "${LOCAL_BIN}/kitty"
ln -sfn "${HOME}/.local/kitty.app/bin/kitten" "${LOCAL_BIN}/kitten"
cp "${HOME}/.local/kitty.app/share/applications/kitty.desktop" \
  "${HOME}/.local/share/applications/kitty.desktop"
sed -i \
  -e "s|Icon=kitty|Icon=${HOME}/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|" \
  -e "s|Exec=kitty|Exec=${HOME}/.local/kitty.app/bin/kitty|" \
  "${HOME}/.local/share/applications/kitty.desktop"

log "Installing SDKMAN and the latest stable Java"
if [[ ! -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]]; then
  curl --fail --silent --show-error https://get.sdkman.io | bash
fi
# shellcheck disable=SC1091
source "${HOME}/.sdkman/bin/sdkman-init.sh"
sdk install java || sdk current java

log "Installing NVM, Node.js LTS, npm, and Codex"
if [[ ! -s "${HOME}/.nvm/nvm.sh" ]]; then
  export PROFILE="${HOME}/.zshrc"
  curl --fail --location --show-error \
    "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
fi
export NVM_DIR="${HOME}/.nvm"
# shellcheck disable=SC1091
source "${NVM_DIR}/nvm.sh"
nvm install --lts
nvm use --lts
npm install --global npm@latest @openai/codex

log "Installing Starship"
curl --fail --silent --show-error https://starship.rs/install.sh | \
  sh -s -- --yes --bin-dir "${LOCAL_BIN}"

log "Installing zsh-patina ${ZSH_PATINA_VERSION}"
case "$(uname -m)" in
  x86_64) patina_arch="x86_64" ;;
  aarch64) patina_arch="aarch64" ;;
  *) die "zsh-patina is not configured for architecture $(uname -m)" ;;
esac
patina_archive="zsh-patina-v${ZSH_PATINA_VERSION}-${patina_arch}-unknown-linux-musl.tar.gz"
patina_tmp="$(mktemp -d)"
curl --fail --location --show-error \
  "https://github.com/michel-kraemer/zsh-patina/releases/download/v${ZSH_PATINA_VERSION}/${patina_archive}" \
  --output "${patina_tmp}/${patina_archive}"
tar -xzf "${patina_tmp}/${patina_archive}" -C "${patina_tmp}"
patina_binary="$(find "${patina_tmp}" -type f -name zsh-patina -print -quit)"
[[ -n "${patina_binary}" ]] || die "zsh-patina binary was not found in its archive"
install -m 0755 "${patina_binary}" "${LOCAL_BIN}/zsh-patina"

log "Installing the current IntelliJ IDEA release"
idea_tmp="$(mktemp -d)"
curl --fail --location --show-error \
  'https://download.jetbrains.com/product?code=IIU&latest&distribution=linux' \
  --output "${idea_tmp}/idea.tar.gz"
tar -xzf "${idea_tmp}/idea.tar.gz" -C "${idea_tmp}"
idea_dir="$(find "${idea_tmp}" -mindepth 1 -maxdepth 1 -type d -name 'idea-*' -print -quit)"
[[ -n "${idea_dir}" ]] || die "IntelliJ IDEA directory was not found in its archive"
mkdir -p "${HOME}/.local/intellij"
idea_name="$(basename "${idea_dir}")"
if [[ ! -d "${HOME}/.local/intellij/${idea_name}" ]]; then
  mv "${idea_dir}" "${HOME}/.local/intellij/${idea_name}"
fi
ln -sfn "${HOME}/.local/intellij/${idea_name}/bin/idea" "${LOCAL_BIN}/idea"

log "Installing Victor Mono fonts"
font_tmp="$(mktemp -d)"
curl --fail --location --show-error \
  https://rubjo.github.io/victor-mono/VictorMonoAll.zip \
  --output "${font_tmp}/VictorMonoAll.zip"
unzip -q "${font_tmp}/VictorMonoAll.zip" -d "${font_tmp}/fonts"
mkdir -p "${HOME}/.local/share/fonts/VictorMono"
find "${font_tmp}/fonts" -type f -name '*.ttf' -exec \
  install -m 0644 -t "${HOME}/.local/share/fonts/VictorMono" {} +
fc-cache -f

if [[ "${SHELL}" != "$(command -v zsh)" ]]; then
  log "Changing the login shell to zsh"
  chsh -s "$(command -v zsh)"
fi

log "Installation complete"
printf '%s\n' \
  "Open a new terminal before using Java, Node.js, Codex, Starship, or zsh-patina." \
  "This script does not overwrite shell/editor configuration or your Git identity."
