# frozen_string_literal: true

module Dotfiles
  class Zsh
    class << self

      def run
        message('==> Shell'.bold)

        if ENV['SHELL'].match(/zsh/)
          message('$SHELL is zsh'.blue)
        else
          message('Changing $SHELL to zsh'.green)
          system('chsh -s `which zsh`')
        end
      end

    end
  end
end
