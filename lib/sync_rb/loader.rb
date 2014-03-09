class SyncRb::Loader
  require 'sync_rb/base'
  require 'sync_rb/sync'

  include SyncRb::Base
  include SyncRb::Sync

  def run
    $dry_run = true
    git.load_content_dir
    sync_from_content_dir
  end

  def sync_from_content_dir
    # First we must check the content dir is clear, i.e. after the
    # checkout there is nothing unwanted (no untracked files, no
    # unexpected change).
    # TODO check content_dir is clean
    # TODO traverse the content_dir
    #   - if file, copy it
    #   - if directory, remove the local dir and copy it
    Dir[CONTENT_DIR].each do |file|
      #if file.directory?
      #  drop_dir(file)
      #  load(file)
      #else
    end 
  end

  def destination_path(path)
    path.gsub CONTENT_DIR, BASE_DIR
  end
end