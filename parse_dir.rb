include_hidden_files = ARGV[0] && ARGV[0].downcase.index('hidden') && true || false

file_names = Dir.glob('*.*')

if include_hidden_files
  file_names << Dir.glob('.*').reject { |file| ['.','..','.DS_STORE'].include? file }
end

file_names.flatten!

file_contents = []
divider = "\n*********************************************************\n"

file_names.each do |filename|
  next unless File.exist? filename
  next unless File.readable? filename
  file = File.open filename, 'r'
  contents = file.read
  file_contents << filename + ':'
  file_contents << divider
  file_contents << contents
  file_contents << divider
end

# create new file for the current directory's file contents
# and write entire directory contents to file
temp_file = File.new %Q'#{Dir.pwd.gsub('/','_')}.txt', 'w'
temp_file.puts file_contents.join("\n")
temp_file.close
