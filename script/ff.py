#!/usr/bin/python3
#coding:utf-8

import sys, os, subprocess
from typing import Tuple

def Usage():
    msg = '''Usage: find -name $2 | grep $1
example :
ff fileName: Find files

    find . -name "Makefile"

ff word .py : Find content in files

    find . -type f -name "*.[py]" | xargs -I{} sh -c "grep --color=yes -anH 'word'"

ff home -d : Find Directory

    find . -type d | grep --color=yes -anH home '''

    if os.getenv('LANG') == 'C.GBK':
        print(msg.decode('utf8'))
    else:
        print(msg)

def CheckContent():
    global content
    if content == '':
        sys.stderr.write( '[ERROR] miss content:\n\t%s\n' % ' '.join( sys.argv ) )
        sys.exit()

def db(*args):
    global g_debug
    if g_debug: print(args)

fileset = {
        'just find':[],
        'grep all object':[],
        'grep all file':[],
        'find dir':[],
        'grep some files':[],
        'grep some postfix':[],
}
content = ''
def ParseArg():
    global fileset, content, g_debug
    if '-d' in sys.argv:
        g_debug = 1
    db( sys.argv )
    if len( sys.argv ) == 1:
        Usage()
        sys.exit()
    for arg in sys.argv[1:]:
        if len( sys.argv ) == 2:
            key = 'just find'
            fileset[key].append(arg) if fileset[key] == [] else fileset[key].append(arg)
            db( key ,fileset[key] )
        elif arg == '.o':
            key = 'grep all object'
            fileset[key].append(arg) if fileset[key] == [] else fileset[key].append(arg)
            db( key ,fileset[key] )
        elif arg == '-d':
            key = 'find dir'
            fileset[key].append(arg) if fileset[key] == [] else fileset[key].append(arg)
            db( key ,fileset[key] )
        elif arg.startswith('.'):
            key = 'grep some postfix'
            fileset[key].append(arg[1:]) if fileset[key] == [] else fileset[key].append(arg[1:])
            db( key ,fileset[key] )
        elif content != '':
            key = 'grep some files'
            fileset[key].append(arg) if fileset[key] == [] else fileset[key].append(arg)
            db( key ,fileset[key] )
        elif content == '':
            content = arg
        else:

            key = 'grep all file'
            fileset[key].append(arg) if fileset[key] == [] else fileset[key].append(arg)
            db( key ,fileset[key] )

            #raise Exception('too much content:\t%s' % ' '.join(sys.argv) )

def CombiseCommand():
    global fileset, content
    if fileset['just find'] != []:
        key = 'just find'
        filename = ''.join( fileset[key] )
        if filename.startswith('..'):
            command = ''' find . -name "%s" ''' % filename[1:]
        elif filename.startswith('.'):
            command = ''' find . -name "*%s" ''' % filename
        else:
            command = ''' find . -name "%s" ''' % filename
    elif fileset['grep all object'] != []:
        key = 'grep all object'
        CheckContent()
        #alias fs="find . -type f -name '*.*o'|awk '{printf (\"nm -A %s|cat -n\n\", \$0) }'|sh|grep -a --color=yes"
        command = ''' find . -type f -name "*.o" | awk '{printf ("nm -A %%s|cat -n\\n", $0) }' | sh | grep --color=yes -anH '%s' ''' % content
    elif fileset['grep all file'] != []:
        key = 'grep all file'
        CheckContent()
        command = ''' find . -type f | xargs -I{} sh -c "grep --color=yes -anH '%s' {}" ''' % content
    elif fileset['find dir'] != []:
        key = 'find dir'
        CheckContent()
        command = ''' find . -type d | grep --color=yes -anH '%s' ''' % content
    elif len( fileset['grep some postfix'] ) != 0 or len( fileset['grep some files'] ) != 0:
        CheckContent()

        i = 0
        postfix=''
        files=''
        key = 'grep some postfix'
        if len( fileset[key] ) != 0:
            if len( fileset[key] ) == 1:
                postfix = '''-name "*.%s"''' % ''.join( fileset[key] )
                i+=1
            else:
                postfix = '''-name "*.[%s]"''' % '|'.join( fileset[key] )
                i+=1

        key = 'grep some files'
        if len( fileset[key] ) != 0:
            for f in fileset[key]:
                if i == 0:
                    files = '''-name "%s"''' % f
                    i+=1
                else:
                    files += ''' -o -name "%s"''' % f
                    i+=1
        command = ''' find . %s%s | xargs -I{} sh -c "grep --color=yes -anH '%s' {}" ''' % ( postfix, files, content )

    return command

def run_command(args) -> Tuple[str, str]:
    out = err = ""
    try:
        with subprocess.Popen(args, shell=True,
                              stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.PIPE) as p:
            out = p.stdout.read().decode()[:-1]
            err = p.stderr.read().decode()[:-1]
    except Exception as e:
        err = traceback.format_exc()
    return out, err

def main():
    ParseArg()
    command = CombiseCommand( )
    sys.stderr.write('%s\n' % command)

    s, _ = run_command(command)
    print(s)


g_debug = 0
if __name__ == "__main__":
    main()
