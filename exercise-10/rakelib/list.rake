desc 'list files from path using provided pattern or defaulting to listing all files'
task :list, [:path, :pattern] do |t, args|

  pattern = args[:pattern] ||= "*.*"

  Dir.chdir args[:path] do
    files = Rake::FileList[pattern]
    puts files
  end

end