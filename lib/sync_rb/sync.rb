module SyncRb::Sync

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