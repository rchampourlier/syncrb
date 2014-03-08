class SyncRb::GitAutomator
  require 'utils'

  def load_content_dir
    repo.prepare
    repo.checkout_branch(branch)
    repo.pull(branch)
  end

  def send_content_dir
    repo.prepare
    repo.prepare_branch(branch)
    repo.checkout_branch(branch)
    repo.commit_all(commit_message)
    #repo.push(branch)
  end

  private

  def commit_message
    "#{Time.now.strftime('%Y-%m-%d-%H:%M')} on #{@hostname}"
  end

  def repo
    @repo = Utils::GitRepo.new(CONTENT_DIR, GIT_REPO)
  end

  def branch
    @hostname ||= `hostname`.strip
  end
end