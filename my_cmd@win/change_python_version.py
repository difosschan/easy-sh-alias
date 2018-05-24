#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import os, sys

python_dir = { \
    '2.7': 'D:\develop_tools\Python27',
    '3.6.1': 'D:\develop_tools\python-3.6.1-embed-amd64' }

python_home = os.getenv('PYTHON_HOME')
if python_home:
    print('PYTHON_HOME={python_home}'.format(python_home=python_home))



