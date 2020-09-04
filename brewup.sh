#!/bin/bash -u
export HOMEBREW_INSTALL_CLEANUP=1
echo "===> upgrading all the 🍺"
echo "[+] missing"
brew missing
echo "[+] doctor"
brew doctor
echo "[+] update"
brew update &&
echo "[+] upgrade"
brew upgrade &&
echo "[+] cask upgrade"
for CASK in $(brew ls --cask); do
  if [ $(brew cask info ${CASK} 2>/dev/null | head -3 | grep -v '^http' | sed -e "s/ (auto_updates)$//" -e "s/^.*\/\(.*\) (.*$/${CASK}: \1/" | sort -u | wc -l) != "1" ]; then
    brew reinstall ${CASK}
    echo
  fi
done
