#!/usr/bin/env python

##----
## Copy all of the configuration file out into the $HOME directory of the
## current user. (all files/folders starting with a "dot" except ".git/")
##----

import os, shutil

def main():
  curr_dir = os.path.dirname(os.path.realpath(__file__))
  home = os.environ['HOME']

  stuff = os.walk(curr_dir).next()
  files = stuff[2]
  dirs  = stuff[1]

  print("copying to " + home + ":")
  for f in files:
    if f[0] == '.':
      dest = home + '/' + f
      print('   ' + f)
      shutil.copyfile(f, dest)

  for d in dirs:
    if d[0] == '.' and d != '.git':
      dest = home + '/' + d
      print('   ' + d + '/')
      copytree(d, dest, True, None)


def copytree(src, dst, symlinks=False, ignore=None):
  """
  Because copying directories in Python really just sucks
  """
  if not os.path.exists(dst):
    os.makedirs(dst)
  for item in os.listdir(src):
    s = os.path.join(src, item)
    d = os.path.join(dst, item)
    if os.path.isdir(s):
      copytree(s, d, symlinks, ignore)
    else:
      print('   ' + s)
      shutil.copy2(s, d)



main()
