require 'octokit'

class PublishRepo
  attr_accessor :source_dir, :client, :user, :repo_options, :access_token, :repo_name

  def initialize(source_dir, repo_name, access_token)
    self.source_dir = source_dir
    @access_token = access_token
    @repo_name = repo_name
    connect
  end
  
  def create_remote_repo
    puts "Creating Repo name #{repo_name}"

    if @repo = self.client.create_repository(repo_name, :private => false)
      puts "Created Repo name #{repo_name}"
    else
      puts "Problem: Creating Repo name {repo_name}"      
    end
  end
  
  def repo_options
    #    @repo_options ||= %w{ private has_issues has_wiki has_downloads
    #    }.inject({}) do |opts, prop|
    return @repo_options if @repo_options

    @repo_options = { }
    %w{ private has_issues has_wiki has_downloads }.each do |prop|
      @repo_options[prop.to_sym] = false
    end
    @repo_options[:auto_init] = true
    @repo_options[:gitignore_template] = 'Ruby'
    @repo_options
  end

  # Not working ??
  def delete_hw_repo
    # self.client.delete_repository(@hw_repo)
    self.client.delete_repository(repo_hw_name)
  end

  def connect
    self.client = Octokit::Client.new(:access_token => self.access_token)
    self.user = self.client.user
  end

  def init
    puts "source_dir is #{source_dir}"
    Dir.chdir(self.source_dir) do
      %x{ git init}
      puts "git init"

      %x{ touch README.md}
      puts "touch README.md"

      %x{ git add . }
      puts "git add ."
      
      %x{ git commit . -m 'initial commit' }
      puts "git commit . -m 'initial commit' "

      curdir = `pwd`
      puts "current working dir is #{curdir}"
      # # git remote add origin git@github.com:tdyer/Week_3_Day_1_HW.git
      # cmd = ""
      # %x{ "#{cmd}" }
      %x{ git remote add origin git@github.com:#{self.user.login}/#{repo_name}.git }
      puts "added the remote"

      %x{ git push -u origin master}
      puts "git push -u origin master"
    end
  end
end
