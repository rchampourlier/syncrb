class SyncRb::Loader
  require 'sync_rb/base'

  include SyncRb::Base

  def run
    git.load_content_dir
    sync_from_content_dir
  end

  def sync_from_content_dir
    # same as sync_to, using the paths indicated by the
    # plugins (to prevent copy of unwanted files that may
    # have entered the content directory).
    
  end
end