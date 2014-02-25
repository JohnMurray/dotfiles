require 'rake'
require 'fileutils'

##----
## Copy all of the configuration file out into the $HOME directory of the
## current user. (all files/folders starting with a "dot" except ".git/")
##----
task :deploy do
  puts "Copying Files"
  Dir[".[^.]*"].each do |file|
    unless ['.git'].include? file
      puts "\tMoving #{file}"
      FileUtils.cp_r file, Dir.home
    end
  end
end

task :default => [:deploy]
