require 'mercenary'

module Octopress
  require 'octopress/ext/hash'
  require 'octopress/ext/titlecase'
  require 'octopress/configuration'
  require 'octopress/command'
  require 'octopress/version'
  require 'octopress/commands/new'
  require 'octopress/commands/init'
  require 'octopress/commands/publish'
  require 'octopress/commands/build'
  require 'octopress/commands/serve'
  require 'octopress/commands/doctor'

  autoload :Page, 'octopress/page'
  autoload :Post, 'octopress/post'
  autoload :Draft, 'octopress/draft'
  autoload :Scaffold, 'octopress/scaffold'

  BLESSED_GEMS = %w[
    octopress-deploy
    octopress-ink
    octopress-docs
  ]

  def self.logger
    @logger ||= Mercenary::Command.logger
    @logger.level = Logger::DEBUG
    @logger
  end

  def self.config(options={})
    @config ||= Configuration.config(options)
  end

  def self.expand_gem_path(dir='')
    File.expand_path(File.join(File.dirname(__FILE__), '../', dir))
  end

  def self.require_blessed_gems
    BLESSED_GEMS.each do |gem|
      begin
        require gem
      rescue LoadError
      end
    end
  end
end

if defined? Octopress::Ink
  require 'octopress/docs'
  Octopress::Ink.register_plugin(Octopress::CLIDocs)
end
