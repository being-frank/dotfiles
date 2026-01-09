# frozen_string_literal: true

module Dotfiles
  class MacosDefaults
    class << self

    def run
      if RUBY_PLATFORM.include? 'darwin'
        message('macOS Defaults:'.bold, indent: 0)
        start
        write_defaults
        restart_apps
      else
        message('Skipped'.blue, indent: 0)
      end
    end

    private

      # https://macos-defaults.com/
      def settings
        [
          'General UI/UX',
          {
            desc: 'Set sidebar icon size to medium',
            cmds: [
              'defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2'
            ]
          },
          {
            desc: 'Expand save panel by default',
            cmds: [
              'defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true',
              'defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true'
            ]
          },
          {
            desc: 'Deactivate Apple Intelligence',
            cmds: [
              'defaults write com.apple.CloudSubscriptionFeatures.optIn "545129924" -bool "false"'
            ]
          },
          'Mouse, Keyboard, Bluetooth accessories, and Input',
          {
            desc: 'Increase sound quality for Bluetooth headphones/headsets',
            cmds: [
              'defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40'
            ]
          },
          {
            desc: 'Enable full keyboard access for all controls',
            cmds: [
              'defaults write NSGlobalDomain AppleKeyboardUIMode -int 3'
            ]
          },
          {
            desc: 'Disable press-and-hold for keys in favor of key repeat',
            cmds: [
              'defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false'
            ],
            skip: true
          },
          {
            desc: 'Set a blazingly fast keyboard repeat rate',
            cmds: [
              'defaults write NSGlobalDomain KeyRepeat -int 1',
              'defaults write NSGlobalDomain InitialKeyRepeat -int 10'
            ]
          },
          {
            desc: 'Set language and text formats',
            cmds: [
              'defaults write NSGlobalDomain AppleLanguages -array "en"',
              'defaults write NSGlobalDomain AppleLocale -string "en_ZA@currency=ZAR"',
              'defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"',
              'defaults write NSGlobalDomain AppleMetricUnits -bool true'
            ]
          },
          {
            desc: 'Disable automatic capitalization',
            cmds: [
              'defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false'
            ]
          },
          {
            desc: 'Disable smart dashes',
            cmds: [
              'defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false'
            ]
          },
          {
            desc: 'Disable automatic period substitution',
            cmds: [
              'defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false'
            ]
          },
          {
            desc: 'Disable smart quotes',
            cmds: [
              'defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false'
            ]
          },
          {
            desc: 'Disable auto-correct',
            cmds: [
              'defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false'
            ]
          },
          'Energy Saving',
          {
            desc: 'Sleep the display after 30 minutes',
            cmds: [
              'sudo pmset -a displaysleep 30'
            ]
          },
          {
            desc: 'Disable machine sleep while charging',
            cmds: [
              'sudo pmset -c sleep 0'
            ]
          },
          {
            desc: 'Set machine sleep to 30 minutes on battery',
            cmds: [
              'sudo pmset -b sleep 30'
            ]
          },
          {
            desc: 'Set standby delay to 24 hours (default is 1 hour)',
            cmds: [
              'sudo pmset -a standbydelay 86400'
            ]
          },
          {
            desc: 'Hibernation mode. 0: Disable hibernation (speeds up entering sleep mode)',
            cmds: [
              'sudo pmset -a hibernatemode 0'
            ]
          },
          'Screen',
          {
            desc: 'Require password immediately after sleep or screen saver begins',
            cmds: [
              'defaults write com.apple.screensaver askForPassword -int 1',
              'defaults write com.apple.screensaver askForPasswordDelay -int 0'
            ]
          },
          {
            desc: 'Save screenshots to Pictures',
            cmds: [
              'defaults write com.apple.screencapture location -string "${HOME}/Pictures"'
            ]
          },
          {
            desc: 'Save screenshots in PNG format',
            cmds: [
              'defaults write com.apple.screencapture type -string "png"'
            ]
          },
          {
            desc: 'Disable shadow in screenshots',
            cmds: [
              'defaults write com.apple.screencapture disable-shadow -bool true'
            ]
          },
          {
            desc: 'Enable subpixel font rendering on non-Apple LCDs',
            cmds: [
              'defaults write NSGlobalDomain AppleFontSmoothing -int 1'
            ]
          },
          {
            desc: 'Enable HiDPI display modes (requires restart)',
            cmds: [
              'sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true'
            ]
          },
          'Finder',
          {
            desc: 'Allow quitting via ⌘ + Q; doing so will also hide desktop icons',
            cmds: [
              'defaults write com.apple.finder QuitMenuItem -bool true'
            ]
          },
          {
            desc: 'Show icons for hard drives, servers, and removable media on the desktop',
            cmds: [
              'defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true',
              'defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true',
              'defaults write com.apple.finder ShowMountedServersOnDesktop -bool true',
              'defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true'
            ]
          },
          {
            desc: 'Show hidden files by default',
            cmds: [
              'defaults write com.apple.finder AppleShowAllFiles -bool true'
            ]
          },
          {
            desc: 'Show all filename extensions',
            cmds: [
              'defaults write NSGlobalDomain AppleShowAllExtensions -bool true'
            ]
          },
          {
            desc: 'Show status bar',
            cmds: [
              'defaults write com.apple.finder ShowStatusBar -bool true'
            ]
          },
          {
            desc: 'Show path bar',
            cmds: [
              'defaults write com.apple.finder ShowPathbar -bool true'
            ]
          },
          {
            desc: 'Display full POSIX path as Finder window title',
            cmds: [
              'defaults write com.apple.finder _FXShowPosixPathInTitle -bool true'
            ]
          },
          {
            desc: 'Keep folders on top when sorting by name',
            cmds: [
              'defaults write com.apple.finder _FXSortFoldersFirst -bool true'
            ]
          },
          {
            desc: 'When performing a search, search the current folder by default',
            cmds: [
              'defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"'
            ]
          },
          {
            desc: 'Disable the warning when changing a file extension',
            cmds: [
              'defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false'
            ]
          },
          {
            desc: 'Enable spring loading for directories',
            cmds: [
              'defaults write NSGlobalDomain com.apple.springing.enabled -bool true'
            ]
          },
          {
            desc: 'Remove the spring loading delay for directories',
            cmds: [
              'defaults write NSGlobalDomain com.apple.springing.delay -float 0'
            ]
          },
          {
            desc: 'Avoid creating .DS_Store files on network or USB volumes',
            cmds: [
              'defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true',
              'defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true'
            ]
          },
          {
            desc: 'Disable disk image verification',
            cmds: [
              'defaults write com.apple.frameworks.diskimages skip-verify -bool true',
              'defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true',
              'defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true'
            ],
            skip: true
          },
          {
            desc: 'Automatically open a new Finder window when a volume is mounted',
            cmds: [
              'defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true',
              'defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true',
              'defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true'
            ]
          },
          {
            desc: 'Show item info near icons on the desktop and in other icon views',
            cmds: [
              '/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist',
              '/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist'
            ]
          },
          {
            desc: 'Enable dateModified for icons on the desktop and in other icon views',
            cmds: [
              '/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy dateModified" ~/Library/Preferences/com.apple.finder.plist',
              '/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy dateModified" ~/Library/Preferences/com.apple.finder.plist'
            ]
          },
          {
            desc: 'Increase grid spacing for icons on the desktop and in other icon views',
            cmds: [
              '/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 124" ~/Library/Preferences/com.apple.finder.plist',
              '/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 124" ~/Library/Preferences/com.apple.finder.plist'
            ]
          },
          {
            desc: 'Increase the size of icons on the desktop and in other icon views',
            cmds: [
              '/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist',
              '/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist'
            ]
          },
          {
            desc: 'Use icon view in all Finder windows by default',
            cmds: [
              'defaults write com.apple.finder "FXPreferredViewStyle" -string "icnv"'
            ]
          },
          {
            desc: 'Disable the warning before emptying the Trash',
            cmds: [
              'defaults write com.apple.finder WarnOnEmptyTrash -bool false'
            ]
          },
          {
            desc: 'Show the ~/Library folder',
            cmds: [
              'chflags nohidden ~/Library'
            ]
          },
          {
            desc: 'Show the /Volumes folder',
            cmds: [
              'sudo chflags nohidden /Volumes'
            ]
          },
          'Dock, Dashboard, and Hot Corners',
          {
            desc: 'Enable highlight hover effect for the grid view of a stack (Dock)',
            cmds: [
              'defaults write com.apple.dock mouse-over-hilite-stack -bool true'
            ]
          },
          {
            desc: 'Set the icon size of Dock items to 32 pixels',
            cmds: [
              'defaults write com.apple.dock tilesize -int 32'
            ]
          },
          {
            desc: 'Change minimize/maximize window effect',
            cmds: [
              'defaults write com.apple.dock mineffect -string "scale"'
            ]
          },
          {
            desc: 'Minimize windows into their application’s icon',
            cmds: [
              'defaults write com.apple.dock minimize-to-application -bool true'
            ]
          },
          {
            desc: 'Enable spring loading for all Dock items',
            cmds: [
              'defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true'
            ]
          },
          {
            desc: 'Show indicator lights for open applications in the Dock',
            cmds: [
              'defaults write com.apple.dock show-process-indicators -bool true'
            ]
          },
          {
            desc: 'Disable Dashboard',
            cmds: [
              'defaults write com.apple.dashboard mcx-disabled -bool true'
            ]
          },
          {
            desc: "Don't show Dashboard as a Space",
            cmds: [
              'defaults write com.apple.dock dashboard-in-overlay -bool true'
            ]
          },
          {
            desc: "Don't automatically rearrange Spaces based on most recent use",
            cmds: [
              'defaults write com.apple.dock mru-spaces -bool false'
            ]
          },
          {
            desc: 'Remove the auto-hiding Dock delay and hide/show animation',
            cmds: [
              'defaults write com.apple.dock autohide-delay -float 0',
              'defaults write com.apple.dock autohide-time-modifier -float 0'
            ]
          },
          {
            desc: 'Automatically hide and show the Dock',
            cmds: [
              'defaults write com.apple.dock autohide -bool true'
            ]
          },
          {
            desc: 'Make Dock icons of hidden applications translucent',
            cmds: [
              'defaults write com.apple.dock showhidden -bool true'
            ]
          },
          {
            desc: "Don't show recent applications in Dock",
            cmds: [
              'defaults write com.apple.dock show-recents -bool false'
            ]
          },
          {
            desc: 'Hot corners: Top right screen corner → Start screen saver',
            cmds: [
              # Possible values:
              #   0: no-op
              #   2: Mission Control
              #   3: Show application windows
              #   4: Desktop
              #   5: Start screen saver
              #   6: Disable screen saver
              #   7: Dashboard
              #  10: Put display to sleep
              #  11: Launchpad
              #  12: Notification Center
              #  13: Lock Screen
              # Corner values:
              #  tl: Top left
              #  tr: Top right
              #  bl: Bottom left
              #  br: Bottom right
              'defaults write com.apple.dock wvous-tr-corner -int 5',
              'defaults write com.apple.dock wvous-tr-modifier -int 0'
            ]
          }
        ]
      end

      def start
        system(%q|osascript -e 'tell application "System Preferences" to quit'|)
        message('Closed any open System Preferences panes'.green, indent: 2)

        system('sudo -v')
      end

      def write_defaults
        settings.each do |setting|
          if setting.is_a?(String)
            message("\n==> #{setting}".bold, indent: 0)
            next
          end

          desc = setting[:desc]
          cmds = setting[:cmds]
          skip = setting[:skip] || false

          if skip
            message("[Skipped] #{desc}".blue, indent: 2)
            next
          end

          message(desc.green, indent: 2)

          cmds.each do |cmd|
            system(cmd)
            # message("==> #{cmd}", indent: 4)
          end
        end
      end

      def restart_apps
        newline
        message("==> Restarting Apps".bold, indent: 0)
        %w[
          cfprefsd
          Finder
          Dock
          SystemUIServer
        ].each do |app|
          system("killall #{app} &> /dev/null")
        end
      end

    end
  end
end
