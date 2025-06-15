# frozen_string_literal: true

module Dotfiles
  class MacosDefaults

    def self.run
      if RUBY_PLATFORM.include? 'darwin'
        message('macOS Defaults:'.bold, indent: 0)
        # sudo_defaults
        write_defaults
        restart_apps
      else
        message('Skipped'.red, indent: 2)
      end
    end

    private

      def self.sudo_defaults
        system('chflags nohidden ~/Library')
        message('Always show ~/Library'.green, indent: 2)

        system('sudo systemsetup -setcomputersleep Off > /dev/null')
        message('Disable sleep'.green, indent: 2)

        system('sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true')
        message('Enable HiDPI resolution'.green, indent: 2)
      end

      def self.write_defaults
        grouped_defaults.each do |group, defaults|
          message(group.bold, indent: 2)
          max_width = defaults.keys.map { |key| key.length }.max

          defaults.each do |key, value|
            system("defaults write #{key} #{value}")
            set_value = `defaults read #{key}`.strip.to_s.green

            message(("%-#{max_width}s %s" % [key, set_value]), indent: 4)
          end
        end
      end

      def self.restart_apps
        newline
        message('Restarting Apps'.bold, indent: 2)
        %w[Finder Dock SystemUIServer].each do |app|
          system("killall #{app} &> /dev/null")
        end
      end

      # # Adjust toolbar title rollover delay
      # defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

      # Expand save panel by default
      # defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
      # defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

      # Disable smart dashes as they’re annoying when typing code
      # defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

      # Disable automatic period substitution as it’s annoying when typing code
      # defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

      # Disable smart quotes as they’re annoying when typing code
      # defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

      # Require password immediately after sleep or screen saver begins
      # defaults write com.apple.screensaver askForPassword -int 1
      # defaults write com.apple.screensaver askForPasswordDelay -int 0

      # Enable subpixel font rendering on non-Apple LCDs
      # Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
      # defaults write NSGlobalDomain AppleFontSmoothing -int 1


      # New defaults to use
      # defaults write com.apple.dock static-only -bool TRUE; killall Dock # Only show active apps in the Dock
      # defaults write com.apple.dock showhidden -bool TRUE; killall Dock # Show hidden apps in the Dock
      # defaults write com.apple.dock autohide-time-modifier -float 1; killall Dock # Dock hide/show animation speed

      def self.grouped_defaults
        {
          'Finder:' => {
            'com.apple.finder _FXShowPosixPathInTitle'         => '-bool true',
            'com.apple.finder _FXSortFoldersFirst'             => '-bool true',
            'com.apple.finder AppleShowAllFiles'               => '-bool true',
            'com.apple.finder CreateDesktop'                   => '-bool false',
            'com.apple.finder FXDefaultSearchScope'            => '-string "SCcf"',
            'com.apple.finder FXEnableExtensionChangeWarning'  => '-bool true',
            'com.apple.finder FXPreferredViewStyle'            => '-string "icnv"',
            'com.apple.finder NewWindowTarget'                 => '-string "PfDe"',
            'com.apple.finder NewWindowTargetPath'             => '-string "file://${HOME}/Desktop/"',
            'com.apple.finder ShowExternalHardDrivesOnDesktop' => '-bool true',
            'com.apple.finder ShowHardDrivesOnDesktop'         => '-bool true',
            'com.apple.finder ShowMountedServersOnDesktop'     => '-bool true',
            'com.apple.finder ShowPathbar'                     => '-bool true',
            'com.apple.finder ShowRemovableMediaOnDesktop'     => '-bool true',
            'com.apple.finder ShowStatusBar'                   => '-bool true',
            'com.apple.finder WarnOnEmptyTrash'                => '-bool false',
            'NSGlobalDomain AppleShowAllExtensions'            => '-bool true',
            'NSGlobalDomain com.apple.springing.delay'         => '-float 0',
            'NSGlobalDomain com.apple.springing.enabled'       => '-bool true'
          },
          'Dock:' => {
            'com.apple.dashboard mcx-disabled'                  => '-bool true',
            'com.apple.dock autohide-delay'                     => '-float 0',
            'com.apple.dock autohide'                           => '-bool true',
            'com.apple.dock expose-animation-duration'          => '-float 0.12',
            'com.apple.dock minimize-to-application'            => '-bool true',
            'com.apple.dock show-process-indicators'            => '-bool true',
            'com.apple.dock showhidden'                         => '-bool true',
            'com.apple.dock tilesize'                           => '-int 24',
            'com.apple.dock wvous-bl-corner'                    => '-int 5',
            'com.apple.dock wvous-bl-modifier'                  => '-int 0'
          },
          'Screen:' => {
            'com.apple.screensaver askForPassword'              => '-int 1',
            'com.apple.screensaver askForPasswordDelay'         => '-int 300',
            'com.apple.screencapture disable-shadow'            => '-bool true',
            'com.apple.screencapture type'                      => '-string "png"',
          },
          'Tweetbot:' => {
            'com.tapbots.TweetbotMac OpenURLsDirectly'          => '-bool true'
          },
          'Misc:' => {
            'com.apple.LaunchServices LSQuarantine'               => '-bool false',
            'NSGlobalDomain AppleFontSmoothing'                   => '-int 2',
            'NSGlobalDomain AppleKeyboardUIMode'                  => '-int 3',
            'NSGlobalDomain NSAutomaticDashSubstitutionEnabled'   => '-bool false',
            'NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled'  => '-bool false',
            'NSGlobalDomain NSAutomaticSpellingCorrectionEnabled' => '-bool false',
            'NSGlobalDomain NSNavPanelExpandedStateForSaveMode'   => '-bool true',
            'NSGlobalDomain NSTableViewDefaultSizeMode'           => '-int 1',
            'NSGlobalDomain NSUseAnimatedFocusRing'               => '-bool false'
          }
        }
      end

  end
end
