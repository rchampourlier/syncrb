class Utils::GitRepo

  def initialize(local_path, remote_url)
    @local_path = local_path
    @remote_url = remote_url
  end

  def prepare
    unless exists?
      commands = []
      commands << 'git init'
      commands << "git remote add origin #{@remote_url}"
    end
  end

  def prepare_branch(name)
    run ["git checkout -b #{branch}"] unless has_branch?(name)
  end

  def checkout_branch(name)
    run ["git checkout #{name}"] unless on_branch?(name)
  end

  def commit_all(message)
    commands = []
    commands << 'git add -A'
    commands << "git commit -m \"#{message}\""
    run commands
  end

  def pull(name)
    run ["git pull origin #{name}"]
  end

  def push(name)
    run ["git push -u origin #{name}"]
  end

  def exists?
    File.exists? File.join(@local_path, '.git')
  end

  def has_branch?(name)
    run(['git branch'], :capture => true) =~ %r{#{name}}
  end

  def on_branch?(name)
    run(['git branch'], :capture => true) =~ %r{\* #{name}}
  end

  private

  def run(commands, options = {})
    commands.unshift "cd #{@local_path}"
    command = commands.join ' && '
    if options[:capture]
      `#{command}`
    else
      system command
    end
  end
end