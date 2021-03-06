echo "Set setting: System Preferences > Security & Privacy > General > Allow apps to be downloaded from: Anywhere"
read

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
killall Finder

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Hide Spotlight icon from menu bar
sudo mv /System/Library/CoreServices/Search.bundle /System/Library/CoreServices/Search.bundle.bak
killall SystemUIServer

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Turn off keyboard illumination when computer is not used for 10 seconds
defaults write com.apple.BezelServices kDimTime -int 10

# Don't create .DS_Store files on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

for app in "SystemUIServer"; do
  killall "$app" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."

# Prevent error from having too many files open
launchctl limit maxfiles 2048 2048
