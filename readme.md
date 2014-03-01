# Dotfiles

## Description:
This "project" contains the Linux dotfiles that I used on all of my systems.
I mainly keep them on here for my own personal storage and use. However if
you find them useful or like a part of them, feel free to fork them and make
them your own. This is a work-in-progress for me and will grow and get 
better over time.


## Installation
For quick easy installation, you can run either a python or ruby script, depending
what you have available on your system. Note that running the interall will overwrite
any existing dot-files that conflict with what is included in this project.

#### Ruby
```ruby
rake
```

#### Python
```python
./install.py
```

This will copy all of the files and directories starting with '.' from the folder
into your $HOME directory (except for the .git dir).
