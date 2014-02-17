class Syncer::PluginsLoader
  include Enumerable

  def each
    active_plugins.each do |plugin|
      yield(plugin, paths(plugin))
    end
  end

  private

  def active_plugins
    @plugins ||= (
      load CONF_FILE
      if PLUGINS == :all
        Dir[File.join(PLUGINS_DIR, '*')].collect do |file|
          File.basename(file)
        end
      else
        PLUGINS
      end
    )
  end

  def paths(plugin)
    File.readlines(File.join(PLUGINS_DIR, plugin)).map(&:chomp)
  end
end