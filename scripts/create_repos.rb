#!/usr/bin/env ruby
# -*- ruby -*-
# require 'pry'
require 'fileutils'
require 'erb'

require_relative '../lib/publish_repo'
require_relative '../lib/ask_week'
require_relative '../lib/ask_day'
require_relative '../lib/process_erb'

# Usage: ruby create_repos.rb [week number] [day_number]
# if you don't enter a week or day number you'll be prompted for one

# Prompt for the week, if we haven't input it
week_num = AskWeek.new(ARGV.shift).ask
puts "Wweek is #{week_num}"

# Prompt for the day, if we haven't input it
day_num = AskDay.new(ARGV.shift).ask
puts "Day is #{day_num}"

# Create Homework and Quiz directories in the ~/temp direcotry
dest_dir = "#{Dir.home}/temp"

# clean up the ~/temp directory
FileUtils.rm_r("#{dest_dir}/Week_N", :force => true)
FileUtils.rm_r("#{dest_dir}/Week_#{week_num}", :force => true)

# copy template directory to temp
template_dir = 'hw_quiz_template'
FileUtils.cp_r("#{template_dir}/Week_N", dest_dir)

# create the directory for the new HW and Quiz repos in ~/temp
FileUtils.cp_r("#{template_dir}/Week_N", "#{dest_dir}/Week_#{week_num}")
# rename the day directory
FileUtils.mv("#{dest_dir}/Week_#{week_num}/Day_N", "#{dest_dir}/Week_#{week_num}/Day_#{day_num}", :force => true)

# Generate the .rvmrc  in the homework directory
hw_dir = "#{dest_dir}/Week_#{week_num}/Day_#{day_num}/HW"
repo_name = "Week#{week_num}_Day#{day_num}_HW"
rvm_erb = ProcessErb.new("#{hw_dir}/rvmrc.erb", "#{hw_dir}/.rvmrc", :repo_name => repo_name)
rvm_erb.process

# Generate the .rvmrc  in the quiz directory
quiz_dir = "#{dest_dir}/Week_#{week_num}/Day_#{day_num}/Quiz"
repo_name = "Week#{week_num}_Day#{day_num}_Quiz"
quiz_erb = ProcessErb.new("#{quiz_dir}/rvmrc.erb", "#{quiz_dir}/.rvmrc", :repo_name => repo_name)
quiz_erb.process

# create the Homework Repo
hw_repo = PublishRepo.new(hw_dir)
puts hw_repo.name
# create the remote repo on github
hw_repo.create_remote_repo
hw_repo.init

# create the Quiz Repo
quiz_repo = PublishRepo.new("#{dest_dir}/Week_#{week_num}/Day_#{day_num}/Quiz")
puts quiz_repo.name
quiz_repo.create_remote_repo
quiz_repo.init

# cleanup, remove the template directory from ~/temp
FileUtils.rm_r("#{dest_dir}/Week_N", :force => true)




