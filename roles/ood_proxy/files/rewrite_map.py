#!/usr/bin/env python3
import grp
import sys

target_grp = 'gpfs5'
target_hostname = 'login002.cm.cluster'
DEBUG = False

while sys.stdin:
    try:
        username = sys.stdin.readline().strip()   ## It is very important to use strip!
        if DEBUG: print(username)
        if not username:
            print('NULL')
        if username in grp.getgrnam(target_grp).gr_mem:
            print(target_hostname)
        else:
            print('NULL')
        sys.stdout.flush()
    except:
        print('NULL')
        sys.stdout.flush()
