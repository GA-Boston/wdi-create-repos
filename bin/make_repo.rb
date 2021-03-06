#!/usr/bin/env ruby
# -*- ruby -*-

require 'thor'
require 'dotenv'
Dotenv.load

require_relative '../lib/process_erb'
require_relative '../lib/publish_repo'

# Need to add a github access token into your .env file
# GITHUB_ACCESS_TOKEN="<access_token>"
module GA

  class MakeRepo < Thor
    attr_accessor :repo_dir, :full_name

    class_option :verbose, :type => :boolean
    class_option :repo_prefix, :default => 'ga'
    # class_option :repo_suffix, :default => 'homework'

    desc "create <REPOSITORY NAME>", "make a github repository"
    def create(repo_name)
      clean repo_name
      copy repo_name
      generate_rvmrc repo_name
      publish repo_name, ENV['GITHUB_ACCESS_TOKEN']
    end

    desc "clean <REPOSITORY NAME>", "clean the local temp repository directory"
    def clean(repo_name)
      repo_directory = repo_dir(repo_name)
      puts "remove directory repo_dir #{repo_directory}" if options[:verbose]
      FileUtils.rm_r(repo_directory, :force => true)
    end

    desc "copy <REPOSITORY NAME>", "copy the template directory to temp repository directory"
    def copy(repo_name)
      repo_directory = repo_dir(repo_name)
      puts "copy template directory #{GA::TEMPLATE_DIR} to #{repo_directory}" if options[:verbose]
      FileUtils.cp_r(GA::TEMPLATE_DIR, repo_directory)
    end

    # Hide these methods from Thor
    no_commands do

      def generate_rvmrc(repo_name)
        repo_directory = repo_dir(repo_name)
        puts "Generate .rvmrc in directory #{repo_directory}" if options[:verbose]
        rvm_erb = ProcessErb.new("#{repo_directory}/rvmrc.erb", "#{repo_directory}/.rvmrc", :repo_name => repo_name)
        rvm_erb.process
      end

      def publish(repo_name, access_token)
        repo_directory = repo_dir(repo_name)
        puts "Publish repository #{repo_directory} in your github account" if options[:verbose]
        repo = PublishRepo.new(repo_directory, full_name(repo_name), access_token)
        repo.create_remote_repo
        repo.init
      end
      
      def repo_dir(repo_name)
        unless @repo_dir
          temp_dir = options[:temp_dir] || "#{Dir.home}/temp"
          @repo_dir || "#{temp_dir}/#{full_name(repo_name)}"
        end
      end

      def full_name(repo_name)
        @full_name ||= "#{options[:repo_prefix]}-#{repo_name}-#{options[:repo_suffix]}"
      end
    end
  end
end
