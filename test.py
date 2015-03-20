#!/usr/bin/python

import commands


print  commands.getoutput("ls -al | wc -l")

