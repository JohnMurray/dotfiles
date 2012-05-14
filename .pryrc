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

##
## timing functions
##
def time(&block)
  t1 = Time.now
  yield
  t2 = Time.now
  diff = t2 - t1
  puts "#{diff} seconds"
  puts "#{(diff - diff.to_i) * 1000} milliseconds"
end
alias :t :time
