#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import sys, os
import platform
from difoss_pybase.common_utils import *

class SeeEnv(object):
    def __init__(self):
        self.is_win_ = (platform.system() == 'Windows')

    def print_usage(self):
        print_info('python %s PATH' % sys.argv[0], 'usage')

    def main(self):
        if len(sys.argv) <= 1:
            print_usage()
            sys.exit(1)

        system_type = platform.system()

        for env_name in sys.argv[1:]:
            env_str = os.getenv(env_name)
            env_show_name = ''

            if self.is_win_:
                env_show_name = '%{}%'.format(env_name)
            else:
                env_show_name = '${}'.format(env_name)

            if not env_str:
                print_info(env_show_name, 'Environment Variable not exist')
                sys.exit(1)

            env_arr = []

            if self.is_win_:
                env_arr = env_str.split(';')
            else:
                env_arr = env_str.split(':')

            print_info('', env_show_name)
            print('%s' % '\n'.join(env_arr) )


if __name__ == '__main__':
    SeeEnv().main()

