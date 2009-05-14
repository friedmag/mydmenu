#!/usr/bin/ruby

require 'fileutils'

module DMenu
  def dmenu(*opts)
    dm = IO.popen((dmenu_cmd or 'dmenu'), 'w+')
    opts.each do |opt|
      dm.puts opt
    end
    dm.close_write
    value = dm.read
    dm.close
    unless $? == 0
      raise 'Operation cancelled'
    end
    value
  end
end

class MyDMenu
  ConfigFile = ENV['HOME'] + '/.mydmenu.rb'
  extend DMenu

  def self.cmd(name, command = nil, &block)
    @commands = {} unless @commands
    @commands[name.to_s] = (command or block or name.to_s)
    @command_keys = [] unless @command_keys
    @command_keys.push name
  end

  # This hack is because setting class-level attributes in a class
  # definition is a PITA.
  def self.dmenu_cmd(use_dmenu_cmd = nil)
    @dmenu_cmd = (use_dmenu_cmd or @dmenu_cmd)
  end

  def self.run
    # Obtain the command to run from the sorted list.
    command = dmenu(@command_keys)
    to_exec = case @commands[command]
    when String
      @commands[command]
    when Proc
      @commands[command].call
    when NilClass
      # When there is no entry in @commands, assume
      # the user typed in a custom command to execute
      command
    else
      raise "Invalid command given: #{command}"
    end
    if String === to_exec
      # Fork off so this process returns to the caller
      Kernel.fork do
        Kernel.exec to_exec
      end
    end
  end

  self.instance_eval(File.read(ConfigFile), ConfigFile)
end

MyDMenu.run
