#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import sys, types, pydoc

if __name__ == '__main__':

    if len(sys.argv) > 1:
        pydoc.help( sys.argv[1] )

    else: # print help
        print('usage: pyhelp < module[.submodule...] >')
