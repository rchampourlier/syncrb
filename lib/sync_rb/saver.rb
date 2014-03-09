class SyncRb::Saver
  require 'sync_rb/base'
  require 'sync_rb/sync'

  include SyncRb::Base
  include SyncRb::Sync

  def run
    prepare.content_dir
    sync_to_content_dir
    git.send_content_dir
  end

  def sync_to_content_dir
    paths.each do |path|
      directory_path = File.directory?(path) ? path : File.dirname(path)
      sync_dir directory_path
      unless File.directory?(path)
        sync_file path
      end
    end
  end

  def destination_path(path)
    path.gsub BASE_DIR, CONTENT_DIR
  end
end