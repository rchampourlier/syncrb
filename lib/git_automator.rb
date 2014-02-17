class Syncer::GitAutomator

  def commit
    prepare_repo
    prepare_branch
    checkout_branch
    commit_all
  end

  def push
    run ["git push -u origin #{branch}"]
  end

  private

  def prepare_repo
    unless File.exists? File.join(CONTENT_DIR, '.git')
      run ['git init']
    end
  end

  def prepare_branch
    run ["git checkout -b #{branch}"] unless branch_exists?
  end

  def checkout_branch
    run ["git checkout #{branch}"] unless branch_active?
  end

  def branch_exists?
    run(['git branch'], :capture => true) =~ %r{#{branch}}
  end

  def branch_active?
    run(['git branch'], :capture => true) =~ %r{\* #{branch}}
  end

  def commit_all
    git_commands = []
    git_commands << 'git add -A'
    git_commands << "git commit -m \"#{Time.now.strftime('%Y-%m-%d-%H:%M')} on #{@hostname}\""
    run git_commands
  end

  def branch
    @hostname ||= `hostname`.strip
  end

  def run(commands, options = {})
    commands.unshift "cd #{CONTENT_DIR}"
    command = commands.join ' && '
    if options[:capture]
      `#{command}`
    else
      system command
    end
  end
end