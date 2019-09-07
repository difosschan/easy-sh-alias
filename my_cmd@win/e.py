# -*- coding: UTF-8 -*-

import os,sys

dir = "."

argc = len(sys.argv)

if argc > 1:
    dir = " ".join(sys.argv[1:])
    if not os.path.exists(dir):
        print ("directory <%s> isn't exist!" % dir)
        exit(0)
cmd = "explorer %s" % dir
print (cmd)
os.system(cmd)
