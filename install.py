#!/usr/bin/env python

##----
## Copy all of the configuration file out into the $HOME directory of the
## current user. (all files/folders starting with a "dot" except ".git/")
##----

import os, shutil

curr_dir = os.path.dirname(os.path.realpath(__file__))
files = os.walk(curr_dir).next()[2]
home = os.environ['HOME']


print("copying to " + home + ":")
for f in files:
  if f[0] == '.':
    dest = home + '/' + f
    print('   ' + f)
    shutil.copyfile(f, dest)
