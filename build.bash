#!/bin/bash

echo $1

/cygdrive/f/Soft/cc65/bin/cl65.exe -t cx16 -o $1.prg -l $1.txt $1.asm
