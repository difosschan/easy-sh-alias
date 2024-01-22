#!/bin/env python3
# -*- coding:utf-8 -*-
# author: difosschan

import sys, os

Usage = '''Usage: cnt.cpp {file}'''.format(
    file=sys.argv[0].split(os.path.sep)[-1]
)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print(Usage, file=sys.stderr)
        sys.exit(1)

    fn = sys.argv[1]
    cnt = 0
    if os.path.isfile(fn):
        with open(fn, 'r', encoding='utf-8') as f:
            line = f.readline()
            while line:
                line = line.strip()
                cnt += 0 if line.startswith('/*') or line.startswith('*') or line == '' else 1
                line = f.readline()

        print(f"count of file <{fn}> = {cnt}")
    else:
        print(Usage, file=sys.stderr)
