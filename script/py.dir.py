#!/usr/bin/env python
# -*- coding: UTF-8 -*-

# `pydir.bat` in Version 0.1 as follow:
# @python -c "import %1; print ('\n'.join(dir(%1)))"

import sys, importlib, types, pydoc

if __name__ == '__main__':

    if len(sys.argv) <= 1: # print usage
        sys.stderr.write('usage: pydir < module[.submodule...] | object >\n')
        sys.stderr.write('> for more infomation, use follow command: $ pyhelp(dir)\n')

        sys.exit()

    argv1 = sys.argv[1]

    argv1_list = argv1.split('.')

    module_name = ''
    sub_modules = ''
    module = None

    if len(argv1_list) <= 1:
        module_name = argv1
    else:
        module_name = argv1_list[0]
        sub_modules = '.'.join(argv1_list[1:])

    #print("module_name:", module_name)
    #print("sub_modules:", sub_modules)

    try:
        if sub_modules == '':
            module = __import__(module_name)
            print('\n'.join( dir( module )))

        else:
            module = __import__(module_name)
            obj = None

            #eval_str = sub_modules
            print('\n'.join( dir(eval('module.' + sub_modules))))

    except ImportError as ie:
        print('\n'.join( dir( eval(argv1) )))

    except Exception as e:
        sys.stderr.write("Catch Exception {exp_type}: {reason}\n".format(exp_type=type(e), reason=e.__str__()))

