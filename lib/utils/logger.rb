class Utils::Logger

  def debug(message)
    puts "[DEBUG] #{message}" if should_log(:debug)
  end

  def info(message)
    puts " [INFO] #{message}" if should_log(:info)
  end

  def warn(message)
    puts " [WARN] #{message}" if should_log(:warn)
  end

  private

  def should_log(level)
    log_level = LOG_LEVEL
    case log_level
    when :debug
      [:debug, :info, :warn].include? level
    when :info
      [:info, :warn].include? level
    when :warn
      [:warn].include? level
    else
      raise "unknown log level #{level}"
    end
  end
end
