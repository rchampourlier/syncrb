module Utils
  require 'utils/logger'
  require 'utils/git_repo'

  def log
    @logger ||= Logger.new
  end
end