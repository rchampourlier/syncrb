require 'sync_rb/git_automator'
require 'sync_rb/plugins_loader'
require 'sync_rb/preparator'

module SyncRb::Base
  include Utils

  private

  def git
    @git_automator ||= SyncRb::GitAutomator.new
  end

  def command(command_to_run)
    log.info command_to_run
    system command_to_run
  end

  def make_dir(path)
    path = escape_path(path)
    command "mkdir -p \"#{path}\"" unless $dry_run
  end

  def escape_path(path)
    path.gsub('$', '\$')
  end

  def copy(source, destination)
    command "cp -p \"#{source}\" \"#{destination}\""
  end

  def paths
    @paths ||= plugins.collect(&:paths).flatten
  end

  def plugins
    @plugins ||= SyncRb::PluginsLoader.new
  end

  def prepare
    @preparator ||= SyncRb::Preparator.new
  end
end