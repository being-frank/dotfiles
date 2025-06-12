ROOT_PATH = File.dirname(__FILE__)

Dir.glob(File.expand_path('lib/**/*.rb', ROOT_PATH), &method(:require))

include Dotfiles

task install: ['dotfiles:install']

namespace :dotfiles do
  task :install do
    newline
    system('sudo -v')

    # %w[zsh ruby symlinks macos_defaults config_files homebrew code].each do |t|
    %w[homebrew symlinks].each do |t|
      Rake::Task["dotfiles:#{t}"].invoke
      newline
    end
  end

  task :zsh do
    Dotfiles::Zsh.run
  end

  task :python do
    Dotfiles::Python.run
  end

  task :ruby do
    Dotfiles::Ruby.run
  end

  task :symlinks do
    Dotfiles::Symlinks.run
  end

  task :macos_defaults do
    Dotfiles::MacosDefaults.run
  end

  task :config_files do
    Dotfiles::ConfigFiles.run
  end

  task :homebrew do
    Dotfiles::Homebrew.run
  end

  task :code do
    Dotfiles::Code.run
  end

end
