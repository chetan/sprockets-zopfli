
require "mixlib/shellout"

module Zopfli
  class Bin

    PATH     = File.expand_path("../../../vendor/zopfli/zopfli", __FILE__)
    PATH_PNG = File.expand_path("../../../vendor/zopfli/zopflipng", __FILE__)

    # Test if zopfli bin is available
    #
    # @param [String] file     path to the binary to test
    #
    # @return [Boolean] true if available
    def self.available?(file=PATH)
      File.exists?(file) && File.executable?(file)
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

    # Compress the given png file with zopfli_png
    #
    # @param [String] filename      png file to compress
    # @param [String] dest          destination file; if nil, will overwrite original
    def self.compress_png(filename, dest=nil)

      if !available?(PATH_PNG) then
        raise "zopfli binary not found!"
      end

      if !File.exists?(filename) then
        raise "File not found: #{filename}"
      end

      if dest.nil? || dest.empty? then
        dest = filename
      end

      temp = Tempfile.new("zopfli-")
      temp.close
      cmd = Mixlib::ShellOut.new("#{PATH_PNG} #{filename} #{temp.path}")
      cmd.run_command

      if cmd.error? then
        temp.unlink
        err = cmd.stdout.empty?() ? cmd.stderr : cmd.stdout
        raise "zopflipng failed: #{err}"
      end

      File.rename(temp.path, dest)
      true
    end

  end
end
