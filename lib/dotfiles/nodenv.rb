module Dotfiles
  class Nodenv
    class << self

    def run
      message('==> nodenv'.bold)
      nodenv
      install_node_plugin('node-build')
      install_node_plugin('nodenv-nvmrc')
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

      def install_node_plugin(plugin)
        directory = "#{ENV['HOME']}/.nodenv/plugins/#{plugin}"

        if Dir.exist?(directory)
          Dir.chdir(directory)
          system('git pull')
          message("[Updated] #{plugin} => #{directory}".blue)
        else
          system("git clone git@github.com:nodenv/#{plugin}.git #{directory}")
          message("[Installed] #{plugin} => #{directory}".green)
        end
      end

    end
  end
end
