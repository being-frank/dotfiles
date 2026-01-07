module Dotfiles
  class Nodenv
    class << self

    def run
      message('==> nodenv'.bold)
      nodenv
      node_build
    end

    private

      def nodenv
        directory = "#{ENV['HOME']}/.nodenv"

        if Dir.exist?(directory)
          Dir.chdir(directory)
          system('git pull')
          message("[Updated] nodenv => #{directory}".blue)
        else
          system("git clone git@github.com:nodenv/nodenv.git #{directory}")
          message("[Installed] nodenv => #{directory}".green)
        end
      end

      def node_build
        directory = "#{ENV['HOME']}/.nodenv/plugins/node-build"

        if Dir.exist?(directory)
          Dir.chdir(directory)
          system('git pull')
          message("[Updated] node-build => #{directory}".blue)
        else
          system("git clone git@github.com:nodenv/node-build.git #{directory}")
          message("[Installed] node-build => #{directory}".green)
        end
      end

    end
  end
end
