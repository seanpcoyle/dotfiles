#!/usr/bin/env bash

# Customized from https://mths.be/dotfiles
# ~/.macos — https://mths.be/macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `macos.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set the sidebar icon size to "small"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

###############################################################################
# Dock                                                                        #
###############################################################################

# Set the dock icon size
defaults write com.apple.dock tilesize -int 64

# Do not show recent apps in the dock
defaults write com.apple.dock show-recents -bool false

# Minimize open apps into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Screen                                                                      #
###############################################################################

# Save screenshots to the clipboard
defaults write com.apple.screencapture target clipboard

###############################################################################
# Status bar                                                                  #
###############################################################################

# Show battery percentage in the status bar
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true

# Show Bluetooth in the status bar
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Bluetooth -int 18

# Show month, day of week, and seconds on status bar clock
defaults write com.apple.menuextra.clock "ShowAMPM" -bool true
defaults write com.apple.menuextra.clock "ShowDayOfMonth" -bool true
defaults write com.apple.menuextra.clock "ShowDayOfWeek" -bool true
defaults write com.apple.menuextra.clock "ShowDate" -bool true
defaults write com.apple.menuextra.clock "ShowSeconds" -bool true

###############################################################################
# Keyboard                                                                    #
###############################################################################

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Mouse                                                                       #
###############################################################################

# Set mouse speed
defaults write -g com.apple.mouse.scaling 2

# Disable "shake to find mouse"
defaults write NSGlobalDomain CGDisableCursorLocationMagnification -bool true

# Enable right click on Apple Mouse
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton

###############################################################################
# System Updates                                                              #
###############################################################################

# Automatically install MacOS updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -boolean true

# Automatically install App Store updates
sudo defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

###############################################################################
# Misc                                                                        #
###############################################################################

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Start Unsplash on startup and update all screens, updating daily
defaults write com.unsplash.Wallpapers LaunchOnStartup -bool true
defaults write com.unsplash.Wallpapers UpdateAllScreensEnabled -bool true
defaults write com.unsplash.Wallpapers UpdateFrequency -int 0

echo "Done. Note that some of these changes require a logout/restart to take effect."
