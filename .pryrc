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


## 
## Pry settings
## 
Pry.editor = 'vim'


## Monkey patch for Pry to work on JRuby 1.7.0
if RUBY_VERSION == '1.9.3' && RUBY_ENGINE == 'jruby'
  class IO
    def winsize
      stty_info = `stty -a`
      # BSD version of stty, like the one used in Mac OS X
      match = stty_info.match(/(\d+) rows; (\d+) columns/)
      # GNU version of stty, like the one used in Ubuntu
      match ||= stty_info.match(/; rows (\d+); columns (\d+)/)
      [match[1].to_i, match[2].to_i]
    end
  end
end
