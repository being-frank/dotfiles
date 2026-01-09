ROOT_PATH = File.dirname(__FILE__)

Dir.glob(File.expand_path('lib/**/*.rb', ROOT_PATH), &method(:require))

include Dotfiles

task install: ['dotfiles:install']

namespace :dotfiles do
  task :install do
    newline
    system('sudo -v')

    %w[zsh homebrew symlinks macos_defaults rbenv].each do |t|
      Rake::Task["dotfiles:#{t}"].invoke
      newline
    end
  end

  task :homebrew do
    Dotfiles::Homebrew.run
  end

  task :macos_defaults do
    Dotfiles::MacosDefaults.run
  end

  task :nodenv do
    Dotfiles::Nodenv.run
  end

  task :rbenv do
    Dotfiles::Rbenv.run
  end

  task :symlinks do
    Dotfiles::Symlinks.run
  end

  task :zsh do
    Dotfiles::Zsh.run
  end

end
