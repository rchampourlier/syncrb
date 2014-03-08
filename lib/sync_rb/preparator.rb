class SyncRb::Preparator

  def content_dir
    unless File.exists?(CONTENT_DIR)
      Dir.mkdir(CONTENT_DIR)
    end
  end
end