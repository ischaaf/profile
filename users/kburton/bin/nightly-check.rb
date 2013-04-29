#!/usr/bin/env ruby
require 'rubygems'
require 'base_app'
require 'net/smtp'
require 'fileutils'

class GitCheck < BaseApp

  def project_is_clean? name, path
    Dir.chdir path
    status = `git status`.split("\n").last
    status.include?("nothing to commit") && status.include?("working directory clean")
  end

  def command_line_arguments
    super.concat [['s','send-mail','Send email warnings.']]
  end

  def send_email(from, to, subject, message)
    unless to.is_a? Array
      to = [to]
    end

    msg = <<END_OF_MESSAGE
From: #{from}
To: #{to.join(", ")}
Subject: #{subject}

#{message}
END_OF_MESSAGE

    Net::SMTP.start('localhost') do |smtp|
      smtp.send_message msg, from, to
    end
  rescue Exception => e
    $stderr.puts "Error: unable to send email: #{e.inspect}"
  end

  def hostname
    unless @hostname
      @hostname = `hostname`
      @hostname.chomp!
    end
    @hostname
  end

  def run

    unless File.exist? "#{ENV['HOME']}/.rn"
      Dir.mkdir "#{ENV['HOME']}/.rn"
    end
    changed_projs = []
    Dir.glob("#{ENV['HOME']}/projects/*/.git/config").each do |git_config_file|
      contents = File.read(git_config_file)
      puts "checking #{git_config_file}"
      if contents.include?('assembla') || contents.include?('relaynetwork')
        project_name = git_config_file.split('/')[-3]
        puts "  yep: #{project_name}"
        path = "#{ENV['HOME']}/projects/#{project_name}"
        unless project_is_clean? project_name, path
          changed_projs << project_name
          subj = "There are unchecked in changes on #{hostname} in #{project_name}"
          msg = <<-MSG
        There are unchecked in changes in #{project_name} on #{hostname}:
          #{`git status`}
          MSG
          if self.send_mail
            send_email "eng@relaynetwork.com", "eng@relaynetwork.com", subj, msg
          end
          puts subj
          puts msg
        end
      end
    end

    change_file = "#{ENV['HOME']}/.rn/changed-projects"
    unless changed_projs.empty?
      File.open(change_file,"w") do |f|
        f.puts changed_projs.join(" ")
      end
    else
      FileUtils.rm change_file
      File.open(change_file,"w") do |f|
      end
    end
  end

end

GitCheck.main
