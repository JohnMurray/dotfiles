##
## Load the current working directory into the load path
##
$: << '.'

##
## Clear the console window
##
def clear
  system 'clear'
end

##
## Load and Reload files
##
def fl(file_name)
  file_name += '.rb' unless file_name =~ /\.rb/
  @@recent = file_name 
  load "#{file_name}"
end
def rl
  fl(@@recent)
end
