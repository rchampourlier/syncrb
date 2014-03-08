class SyncRb::Cli

  def run(arguments)
    case arguments[0]
    when 'save'
      SyncRb::Saver.new.run
    when 'load'
      SyncRb::Loader.new.run
    else
      usage
    end
  end

  private

  def usage
    puts "usage: sync_rb load"
    puts "       sync_rb save"
  end
end