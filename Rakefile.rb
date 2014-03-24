require 'rake'
require 'fileutils'
require 'yaml'

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



##----
## Find all the '.upgrade' YAML files and execute the upgrade commands
##----
task :upgrade_vim_addons do
  puts "Upgrading Vim Addons"
  Dir.chdir('.vim') do 
    upgrade_dir('*')
  end
end


def upgrade_dir(dir_glob) 
  Dir.glob(dir_glob, File::FNM_DOTMATCH).each do |file|
    next if ['.', '..'].include? file
    if File.directory? file
      Dir.chdir(file) { upgrade_dir('*') }
    else
      run_upgrade(load_yaml_config(file))
    end
  end
end

def load_yaml_config(config_file)
  if config_file =~ /.+\.up$/
    addon_name = config_file.gsub(/^\./, '').gsub(/\.up$/, '')
    puts "\tUpgrading #{addon_name}"
    begin
      return YAML::load_file(config_file)
    rescue Psych::SyntaxError => err
      puts "\tCould not upgrade #{addon_name}. Not valid YAML file"
      puts "\t => #{err.message}"
      puts ''
    end
  end
end


def run_upgrade(config)
  return unless config

  [:pre_update, :update, :post_update].each do |key|
    if config.has_key? key
      if (config[key] || []).is_a? Array
        config[key].each { |cmd| run_command(cmd) }
      else
        run_command(config[key])
      end
    end
  end
end


def run_command(cmd)
  puts "\t\t#{cmd}"
  `#{cmd}`
end

