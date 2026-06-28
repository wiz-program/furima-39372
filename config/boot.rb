ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'logger' # Rails 6.1 + concurrent-ruby 1.3.5+ で Logger が未ロードになる問題の回避
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
