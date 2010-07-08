require File.dirname(__FILE__) + "/lib/marlene.rb"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "marlene"
    gemspec.version = Marlene::VERSION
    gemspec.summary = "Bookmarklet Generator from a local or remote JavaScript file"
    gemspec.description = "Marlene generates bookmarklet files or bookmarklet-pages from existing local javascript files or from remote javascript files represented by a URL."
    gemspec.email = "thomduerr@gmail.com"
    gemspec.homepage = "http://github.com/thomd/marlene/"
    gemspec.authors = ["Thomas Duerr"]
    gemspec.add_dependency "yui-compressor", ">= 0.9.1"
    gemspec.add_dependency "mustache", ">= 0.11.2"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
