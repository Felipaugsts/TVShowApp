SHELL = /bin/sh

help:
	echo "Usage: make [command]"
	echo ""
	echo "[Commands]"
	echo "help       Displays this help."
	echo "setup      Installs the required tools."
	echo "project    Runs pod install."
	echo "update     Update pods."
	echo "reset      Reset and reinstall repo"
	echo "open       Opens the project in XCode."

project:
	xcodegen generate
	pod install --repo-update

update:
	pod install --repo-update

reset:
	git clean -ffdx
	make project

open:
	open SportimeApp.xcworkspace