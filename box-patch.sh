#!/usr/bin/env zsh

echo "Replacing python37.zip in Box app..."
sudo cp ./python37.zip /Applications/Box.app/Contents/Resources/lib/python37.zip 

echo "Ensuring Box FUSE kernel extension is loaded..."
sudo kextload /System/Volumes/Data/Library/Filesystems/box.fs/Contents/Extensions/10.11/osxfuse.kext 2>/dev/null

if [[ `kextstat | grep com.box.filesystems.osxfuse | wc -l` -ge 1 ]]
then
  echo "Box FUSE kext loaded successfully! Now try launching the Box App."
else
  echo "Box FUSE kext failed to load :("
fi


