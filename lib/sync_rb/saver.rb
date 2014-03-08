class SyncRb::Saver
  require 'sync_rb/base'

  include SyncRb::Base

  def run
    prepare.content_dir
    sync_to_content_dir
    #git.send_content_dir
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

  private

  def sync_dir(path)
    unless File.exists? destination_path(path)
      make_dir(destination_path(path))
    end
  end

  def sync_file(path)
    path = escape_path(path)
    source, destination = [path, destination_path(path)]
    if !File.exists?(destination) or File.mtime(source) > File.mtime(destination)
      copy source, destination
    end
  end
end