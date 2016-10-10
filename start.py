#!/usr/bin/env python
import subprocess, os, sys
listShellInput = "ls -a " + os.path.dirname(os.path.realpath(sys.argv[0])) + "/*.sh"
directoryContents = subprocess.Popen(listShellInput, shell=True, stdout=subprocess.PIPE)
directoryContentsString = directoryContents.communicate()[0]
#print (directoryContentsString.decode('ascii'))
directoryContentsOutput = ""
for line in directoryContentsString.decode('ascii').split('\n'):
	line = line[:-3]
	print(line)
	line = line.rsplit('/',1)[-1]
	directoryContentsOutput = directoryContentsOutput + line + "\n"
#print(directoryContentsOutput)
result = subprocess.Popen(['/usr/bin/bash'], shell=False, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
roficommand = 'echo "' + directoryContentsOutput + '" | rofi -dmenu run -lines 4 -bw 20 -eh 2 -width 600 -padding 40 -p " > "'
# roficommand = 'echo "' + directoryContentsOutput + '" | rofi -dmenu -lines 3 -eh 2 -width 100 -fullscreen -opacity "85" -bw 0 -bc "$bg-color" -bg "$bg-color" -fg "$text-color" -hlbg "$bg-color" -hlfg "#9575cd" -font "Ubuntu 18" -p " > "'
stdout = result.stdin.write(str(roficommand).encode())
screenChoice = result.communicate()[0].decode('ascii')
#now to actually execute the shell
screenChoice = screenChoice[:-1] + ".sh"
actualExecution = subprocess.Popen(['/usr/bin/bash'], shell=False, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
finalCommand = os.path.dirname(os.path.realpath(sys.argv[0])) + "/" + screenChoice
stdout = actualExecution.stdin.write(str(finalCommand).encode())
