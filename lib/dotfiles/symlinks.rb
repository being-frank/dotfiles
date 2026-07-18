# frozen_string_literal: true

module Dotfiles
  class Symlinks
    class << self

      HOME_SYMLINKS = "#{ROOT_PATH}/home/symlinks".freeze

      def run
        message('==> Symlinks'.bold)

        symlinks   = all_symlinks
        max_length = symlinks.map { |file| file_basename(file).length }.max

        symlinks.each do |path|
          create_symlink(path, max_length)
        end

        system('exec zsh')
      end

      def unlink
        message('==> Removing symlinks'.bold)

        symlinks   = all_symlinks
        max_length = symlinks.map { |file| file_basename(file).length }.max

        symlinks.each do |path|
          remove_symlink(path, max_length)
        end
      end

      private

        def all_symlinks
          excluded_dirs = %w[. .. .DS_Store]
          Dir.glob("#{HOME_SYMLINKS}/{.,}*").reject { |f| excluded_dirs.include?(file_basename(f)) }.sort
        end

        def file_basename(file)
          file.gsub("#{HOME_SYMLINKS}/", '')
        end

        def create_symlink(file, max_length=0)
          source     = File.expand_path(file, ROOT_PATH)
          target     = File.expand_path("~/#{file_basename(file)}")
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

        def remove_symlink(file, max_length=0)
          source = File.expand_path(file, ROOT_PATH)
          target = File.expand_path("~/#{file_basename(file)}")
          msg    = ''

          if File.symlink?(target) #&& File.readlink(target) == source
            File.unlink(target)
            msg = "[Removed] #{target}".green
          elsif File.symlink?(target) || File.exist?(target)
            msg = "[Skipped] Not our symlink: #{target}".blue
          else
            msg = "[Skipped] No target: #{target}".blue
          end

          message(("%-#{max_length}s %s" % [msg, nil]))
        end

    end
  end
end
