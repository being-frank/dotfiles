ROOT_PATH = File.dirname(__FILE__)

Dir.glob(File.expand_path('lib/**/*.rb', ROOT_PATH), &method(:require))

include Dotfiles

task install: ['dotfiles:install']

namespace :dotfiles do
  task :install do
    newline
    system('sudo -v')

    %w[zsh homebrew symlinks asdf macos_defaults].each do |t|
      Rake::Task["dotfiles:#{t}"].invoke
      newline
    end
  end

  task :asdf do
    Dotfiles::Asdf.run
  end

  task :homebrew do
    Dotfiles::Homebrew.run
  end

  task :macos_defaults do
    # Dotfiles::MacosDefaults.run
  end

  task :symlinks do
    Dotfiles::Symlinks.run
  end

  task :zsh do
    Dotfiles::Zsh.run
  end

end
