# Reverse_Shell_MacOS
Simple reverse shell attack.
Do not use for malicious purposes.

## Requirements:
-  the macOS operating system (on the attacked VM)
-  Xcode
-  file accessing permissions for Terminal


## 1. Customisation & Preparation.
In `bait.command`, line 10, change the numbers `HOST,PORT=\"0.0.0.0\",\"0\"` to match the attacker's IP on a port of your choice. (For example, `HOST,PORT=\"172.54.4.16\",\"9999\"`)
Make sure `bait.command` has appropriate permissions: `chmod +x bait.command` or `chmod 111 bait.command`

## 2. Running options.
-  Calling `./bait.command` from the command line
OR
-  Running the code inside `bait.command`
OR
-  Double-clicking the file in Finder or Desktop (requires .command extention)

