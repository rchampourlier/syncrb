require 'sync_rb/plugin'

class SyncRb::PluginsLoader
  include Enumerable

  def each
    active_plugins.each do |plugin|
      yield(plugin)
    end
  end

  private

  def active_plugins
    @active_plugins ||= (
      active_plugin_names.collect do |name|
        SyncRb::Plugin.new name
      end
    )
  end

  def active_plugin_names
    @active_plugin_names ||= (
      if PLUGINS == :all
        Dir[File.join(PLUGINS_DIR, '*')].collect do |file|
          File.basename(file)
        end
      else
        PLUGINS
      end
    )
  end
end