module Syncer::Utils
  require 'utils/logger'

  def log
    @logger = Logger.new
  end
end