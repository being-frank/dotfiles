# frozen_string_literal: true

module Dotfiles
  class Asdf

    class << self

      PLUGINS = {
        ruby:   'https://github.com/asdf-vm/asdf-ruby.git',
        nodejs: 'https://github.com/asdf-vm/asdf-nodejs.git'
      }.freeze

      VERSIONS = {
        ruby:   %w[3.4.4],
        nodejs: %w[22.16.0]
      }.freeze

      def run
        message("==> asdf".bold)

        install_plugins
        install_versions

        system('exec zsh')
      end

      private

        def install_plugins
          PLUGINS.each do |name, repo|
            if !plugin_installed?(name)
              system("asdf plugin add #{name} #{repo}")
              message("[Installed] plugin for #{name}".green)
            else
              message("[Skipped] plugin for #{name} is already installed".blue)
            end
          end
        end

        def install_versions
          VERSIONS.each do |plugin, versions|
            versions.each do |v|
              version = latest_plugin_version(plugin, v)

              if !version_installed?(plugin, version)
                system("asdf install #{plugin} #{version}")
                message("[Installed] version #{version} for #{plugin}".green)
              else
                message("[Skipped] version #{version} for #{plugin} is already installed".blue)
              end
            end
          end
        end

        def latest_plugin_version(plugin, version)
          if version == 'latest'
            `asdf latest #{plugin}`.strip
          else
            version
          end
        end

        def plugin_installed?(plugin)
          plugins = `asdf plugin list`.strip.split("\n")
          plugins.any? { |pl| pl.match?(/\*?#{plugin.to_s}/) }
        end

        def version_installed?(plugin, version)
          versions = `asdf list #{plugin}`.strip.split("\n")
          versions.any? { |v| v.match?(/\*?#{version.to_s}/) }
        end

    end
  end
end
