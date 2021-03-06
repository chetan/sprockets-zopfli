require 'helper'

class TestZopfliBin < Micron::TestCase

  def setup
    @file = File.expand_path("../helper.rb", __FILE__)
    @gz = "#{@file}.gz"
  end

  def teardown
    if File.exists? @gz then
      begin
        File.unlink(@gz)
      rescue
      end
    end
  end

  def test_available
    assert Zopfli::Bin.available?
  end

  def test_compress
    assert Zopfli::Bin.compress(@file, false)
    assert File.exists?(@gz)

    cmd = Mixlib::ShellOut.new("gunzip -c #{@gz}")
    puts cmd.command
    cmd.run_command
    assert cmd.stdout =~ /rubygems/
  end

  def test_compress_png
    assert Zopfli::Bin.available?(Zopfli::Bin::PATH_PNG)

    file = File.expand_path("../test.png", __FILE__)
    dest = "#{file}.2.png"
    assert Zopfli::Bin.compress_png(file, dest)
    assert File.exists?(dest)
    File.unlink(dest)
  end

end
