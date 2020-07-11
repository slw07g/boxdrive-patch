# boxdrive
UNOFFICIAL Box Drive Patch For Big Sur (beta)

_Disclaimer: I am not affiliated with Box. This is an unofficial patch! Use at your own risk._

Box Drive seems to be incompatible with macOS 11 Big Sur beta, and Box does not seem to want to early-release a patch.

This leaves folks who rely on Box Drive for personal or work use with a choice to either patch it themselves or wait 2+ months for an official patch. 

I decided to patch it myself since it was developed in Python (frozen with py2app) and easy to decompile from bytecode.


## Patching Box Drive (short method)
 1. Clone this repository, 
 2. In a terminal, navigate to the repository's directory.
 3. Run the command `zsh box-patch.sh` _You may be prompted for your macOS user password because root privileges are needed to copy the python37.zip file into the Box app subfolders, as well as to ensure the box FUSE kext is loaded._
 4. If all goes will you should be able to launch Box with no issues. 


## Patching Box Drive (Detailed)
So, In this repo you will find python37.zip - you will need to replace /Applications/Box.app/Contents/Resources/lib/python37.zip with python37.zip from this repo.

Most of the compiled modules are unchanged in the zip, I had to modify a few because Box attempts to load CoreFoundation, CoreServices, and SystemConfiguration dylibs without specifying the complete file path. Additionally, now that macOS 11 Big Sur has moved shared libraries from the file system to a shared cache, ctypes find_library() calls fail.

Additionally, you might also have to manually load the Box FUSE kernel extension. This is only necessary if you try to launch Box and it complains that kernel extension hasn't loaded. The command to load the kernel extension is:

`sudo kextload /System/Volumes/Data/Library/Filesystems/box.fs/Contents/Extensions/10.11/osxfuse.kext`

If you see an error that the start/stop routine failed, you may be able to ignore it. Run the command `kextstat | grep box` and if you see `com.box.filesystems.osxfuse (303.10.2)` in the list, that means it's loaded and you're good to go.

Now, with python37.zip in place and the kext loaded, you should be able to smoothly launch the Box app, You should see the box logo appear in your menu bar and your Box Drive mounted in Finder.


## Thanks
uncompyle6
py2app (bundled app documentation)


## FAQ
1. Will this fix survive a reboot?

The python37.zip will survive the reboot, but the Kernel extension may have to be manually loaded after each reboot. To load kext, You could just repeat the short method again, since the script tries to load the kernel extension for you.

Alternatively, if you try to Launch box and encounter an error regarding the Box Kernel Extension not being loaded, reference the notes in the "Detailed" section above which talks about loadinbg the Kernel extension.
