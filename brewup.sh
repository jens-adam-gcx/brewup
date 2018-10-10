#!/bin/bash -u
echo "===> upgrading all the 🍺"

echo "[+] missing"
brew missing

echo "[+] doctor"
brew doctor

echo "[+] update"
brew update &&

echo "[+] cleanup, prune"
brew cleanup -s &&
brew prune &&

echo "[+] upgrade"
brew upgrade --cleanup &&

echo "[+] clean cache"
rm -rf $(brew --cache) &&

echo "[+] cask upgrade/reinstall"
brew cask upgrade &&
for CASK in $(brew cask ls); do
  if [ $(brew cask info ${CASK} 2>/dev/null | head -3 | grep -v '^http' | sed -e "s/ (auto_updates)$//" -e "s/^.*\/\(.*\) (.*$/${CASK}: \1/" | sort -u | wc -l) != "1" ]; then
    brew cask reinstall ${CASK}
    echo
  fi
done
