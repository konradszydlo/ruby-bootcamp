require 'tmpdir'
require 'fileutils'

shared_context "temporary_files" do
  def temp_dir
    @temp_dir ||= begin
      Dir.mktmpdir
    end
  end

  def touch_file filename
    FileUtils.touch("#{temp_dir}/#{filename}")
  end
end