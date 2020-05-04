# ReadOnly

A Windows PS script to watch and restore modified files.

I had a file that I wanted to make ``readonly``, but modifying the file to ``readonly`` made it unusable by the parent program.  To make sure that the file never changed, I wrote this script to watch the file and replace it if any changes were detected.

This is a unique situation, and this script may not be useful to others, but I'm very pleased w/ how well it works.

## Usage

- Download the ``readonly.ps1`` file
- Edit the file in Notepad to target your file
- Save your changes
- Right click and run as PowerScript
- Close window (or ``ctl-c``) to end script

The script will backup the target file and begin watching for changes.  If and when it detects a change it will replace the modified file w/ the backup.