module Dotfiles
  class Rbenv
    class << self

    def run
      message('==> rbenv'.bold)
      rbenv
      ruby_build
    end

    private

      def rbenv
        directory = "#{ENV['HOME']}/.rbenv"

        if Dir.exist?(directory)
          Dir.chdir(directory)
          system('git pull')
          message("[Updated] rbenv => #{directory}".blue)
        else
          system("git clone git@github.com:rbenv/rbenv.git #{directory}")
          message("[Installed] rbenv => #{directory}".green)
        end
      end

      def ruby_build
        directory = "#{ENV['HOME']}/.rbenv/plugins/ruby-build"

        if Dir.exist?(directory)
          Dir.chdir(directory)
          system('git pull')
          message("[Updated] ruby-build => #{directory}".blue)
        else
          system("git clone git@github.com:rbenv/ruby-build.git #{directory}")
          message("[Installed] ruby-build => #{directory}".green)
        end
      end

    end
  end
end
