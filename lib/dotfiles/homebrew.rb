# frozen_string_literal: true

require 'open3'

module Dotfiles
  class Homebrew
    class << self

      def run
        message('==> Homebrew'.bold)
        message = ''

        if !installed?
          system('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')
          message = "[Installed] Homebrew is installed at `#{install_path}`".green
        else
          message = "[Skipped] Homebrew is already installed at `#{install_path}`".blue
        end

        message(message)
        message('[Info] Updating Homebrew and installing dependencies...'.blue)

        system('brew update')
        system('brew bundle')
      end

      private

        def installed?
          which.last.success?
        end

        def install_path
          which.first.strip
        end

        def which
          @_which ||= Open3.capture2('which brew')
        end

    end
  end
end
