# frozen_string_literal: true

module Dotfiles
  class Symlinks
    class << self

      HOME_SYMLINKS = "#{ROOT_PATH}/home/symlinks".freeze

      def run
        message('==> Symlinks'.bold)

        symlinks   = Dir.glob("#{HOME_SYMLINKS}/**/*").sort
        max_length = symlinks.map { |file| file_basename(file).length }.max

        symlinks.each do |path|
          next if File.directory?(path)

          create_symlink(path, max_length)
        end

        system('exec zsh')
      end

      private

        def file_basename(file)
          file.gsub("#{HOME_SYMLINKS}/", '')
        end

        def create_symlink(file, max_length=0)
          basename   = file_basename(file)
          source     = File.expand_path(file, ROOT_PATH)
          target     = File.expand_path("~/#{file_basename(file).gsub(/^dot_/, '.')}")
          target_dir = File.dirname(target)
          message    = ''

          if !Dir.exist?(target_dir)
            FileUtils.mkdir_p(target_dir)
          end

          if File.exist?(source)
            if File.symlink?(target) || File.exist?(target)
              message = "[Skipped] Target exists: #{target}".blue
            else
              FileUtils.ln_s(source, target)
              message = "[Created] #{target}".green
            end
          else
            message = "[Error] Source missing #{source}".red
          end

          message(("%-#{max_length}s %s" % [message, nil]))
        end

    end
  end
end
