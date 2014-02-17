require 'utils'

class Syncer::PathsManager
  include Syncer::Utils

  attr_reader :plugins

  def initialize(plugins_loader)
    @plugins = plugins_loader
  end

  def expand
    plugins.collect do |plugin, paths|
      paths.collect do |path|
        expanded_path = expand_path(path)
        if File.directory? expanded_path
          glob_directory(expanded_path)
        elsif File.exists? expanded_path
          expanded_path
        elsif path =~ /[{}*]/
          glob_pattern(expanded_path)
        else
          error(plugin, path)
        end
      end
    end.flatten.compact
  end

  private

  def expand_path(path)
    File.join(BASE_DIR, path)
  end

  def glob_directory(path)
    Dir["#{path}/**/*"]
  end

  def glob_pattern(pattern)
    Dir[pattern]
  end

  def error(plugin, path)
    log.warn "Could not find file at path \"#{path}\" in plugin \"#{plugin}\""
    nil
  end
end