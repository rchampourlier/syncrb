class SyncRb::Plugin

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def paths
    found_paths = []
    filters = []
    base_paths.each do |base_path|
      unless base_path.start_with? '-'
        found_paths += expand(base_path) 
      else
        filters << base_path[1..-1]
      end
    end
    apply_filters(filters, found_paths)
  end

  def expand(path)
    expanded_path = expand_path(path)
    if File.directory? expanded_path
      glob_directory(expanded_path)
    elsif File.exists? expanded_path
      [expanded_path]
    elsif path =~ /[{}*]/
      glob_pattern(expanded_path)
    else
      error(plugin, path)
    end
  end

  private

  def apply_filters(filters, paths)
    paths.reject do |path|
      matching_filter = filters.find do |filter|
        regexp = regexp_from_filter_string(filter)
        path =~ regexp
      end
      matching_filter ? true : false
    end
  end

  def regexp_from_filter_string(filter)
    Regexp.new filter.gsub('*', '(.*)')
  end

  def base_paths
    File.readlines(File.join(PLUGINS_DIR, @name)).map(&:chomp)
  end

  def plugins
    @plugins_loader.plugins
  end

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
    log.warn "Could not find file at path \"#{path}\" in plugin \"#{plugin.name}\""
    []
  end
end