#!/usr/bin/env python3
import grp
import sys
import rewritemap_config as cfg

while sys.stdin:
    try:
        username = sys.stdin.readline().strip()   ## It is very important to use strip!
        if cfg.DEBUG: print(username)
        if not username:
            print('NULL')
        if username in grp.getgrnam(cfg.target_grp).gr_mem:
            print(cfg.target_hostname)
        else:
            print('NULL')
        sys.stdout.flush()
    except:
        print('NULL')
        sys.stdout.flush()
