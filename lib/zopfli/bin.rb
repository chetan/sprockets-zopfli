
require "mixlib/shellout"

module Zopfli
  class Bin

    PATH = File.expand_path("../../../vendor/zopfli/zopfli", __FILE__)

    def self.available?
      File.exists?(PATH)
    end

    def self.compress(filename, overwrite=false)

      if !available? then
        raise "zopfli binary not found!"
      end

      if !File.exists?(filename) then
        raise "File not found: #{filename}"
      end

      if File.exists?(filename+".gz") && !overwrite then
        raise "Target file already exists: #{filename}.gz"
      end

      cmd = Mixlib::ShellOut.new("#{PATH} #{filename}")
      cmd.run_command

      return !cmd.error?
    end

  end
end
