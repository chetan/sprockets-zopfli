
require "mixlib/shellout"

module Zopfli
  class Bin

    PATH = File.expand_path("../../../vendor/zopfli/zopfli", __FILE__)

    # Test if zopfli bin is available
    #
    # @return [Boolean] true if available
    def self.available?
      File.exists?(PATH)
    end

    # Compress the given file
    #
    # @param [String] filename          file to compress
    # @param [Boolean] overwrite        whether or not to overwrite existing files
    #
    # @return [Boolean] true if zopfli command returned cleanly
    #
    # @raise [Exception] raises on failure
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
