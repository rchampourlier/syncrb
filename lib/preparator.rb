class Syncer::Preparator

  def base_dir
    unless File.exists?(CONTENT_DIR)
      Dir.mkdir(CONTENT_DIR)
    end
  end
end