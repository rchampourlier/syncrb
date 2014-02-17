class Syncer
  require 'preparator'
  require 'paths_manager'
  require 'plugins_loader'
  require 'git_automator'
  require 'utils'

  include Utils

  def run
    prepare.base_dir
    sync paths.expand
    git.commit
    #git.push
  end

  def sync(paths)
    paths.each do |path|
      directory_path = File.directory?(path) ? path : File.dirname(path)
      sync_dir directory_path
      unless File.directory?(path)
        sync_file path
      end
    end
  end

  def destination_path(path)
    path.gsub BASE_DIR, CONTENT_DIR
  end

  private

  def command(command_to_run)
    log.info command_to_run
    system command_to_run
  end

  def sync_dir(path)
    unless File.exists? destination_path(path)
      make_dir(destination_path(path))
    end
  end

  def make_dir(path)
    path = escape_path(path)
    command "mkdir -p \"#{path}\""
  end

  def sync_file(path)
    path = escape_path(path)
    source, destination = [path, destination_path(path)]
    if !File.exists?(destination) or File.mtime(source) > File.mtime(destination)
      copy source, destination
    end
  end

  def escape_path(path)
    path.gsub('$', '\$')
  end

  def copy(source, destination)
    command "cp -p \"#{source}\" \"#{destination}\""
  end

  def prepare
    @preparator ||= Preparator.new
  end

  def paths
    @paths ||= PathsManager.new(plugins)
  end

  def plugins
    @plugins ||= PluginsLoader.new
  end

  def git
    @git_automator ||= GitAutomator.new
  end
end