require 'rake'
require 'fileutils'

task :default => [:deploy]
task :deploy => [:deploy_contrib, :deploy_bin, :deploy_config]
 

##----
## Copy all of the configuration file out into the $HOME directory of the
## current user. (all files/folders starting with a "dot" except ".git/")
##----
task :deploy_config do
  puts "Copying Config Files"
  Dir[".[^.]*"].each do |file|
    unless ['.git', 'contrib'].include? file
      puts "\tMoving #{file}"
      FileUtils.cp_r file, Dir.home
    end
  end
end


##----
## Copy all of the files in ./bin to $HOME/bin and ensure that the $HOME/bin
## directory exists.
##----
task :deploy_bin do
  puts "Deploying ./bin Files"
  FileUtils.mkdir_p(File.join(Dir.home, 'bin'))
  Dir.chdir('bin') do
    Dir['[^.]*'].each do |bin_file|
      next if ['readme.md'].include? bin_file
      puts "\tMoving #{bin_file} to ~/bin"
      FileUtils.cp_r bin_file, File.join(Dir.home, 'bin')
    end
  end
end


##----
## Copy all of the files in ./contrib/$PROJECT_NAME to the $HOME dir in the
## same strucutre that exists below ./contrib/$PROJECT_NAME.
##----
task :deploy_contrib do
  puts "Deploying ./contrib Files"
  Dir.chdir('contrib') do
    Dir['*'].each do |dir|
      next if ['readme.md'].include? dir
      puts "\t#{dir}"
      Dir.chdir(dir) do
        Dir['*'].each do |file|
          puts "\t\tMoving #{file}"
          FileUtils.cp_r file, Dir.home
        end
      end
    end
  end
end

