piano
=====

Simple Piano in Shoes. You can play the MIDI piano with the mouse. :)

**Note:**   
I've hacked [bleything/midiator](http://github.com/bleything/midiator/tree/master) to pick up the core MIDI interface part. :)   
I know I can use MIDIator gem with Shoes. But I want to understand the basic MIDI usage and this tiny Shoes app doesn't need the big codes.

Piano v0.1 is a Windows version only. Hope someone helps to create the ones for Mac and Linux. ;-)


Usage
-----

	cd piano/lib
	shoes piano.rb

Songs
-----
`songs/sakura.song` is a traditional Japanese folk song. See [wikipedia](http://en.wikipedia.org/wiki/Sakura_Sakura).


Snapshot
--------
![piano_snapshot.png](http://github.com/ashbb/piano/raw/master/piano_snapshot.png)


Change log
----------
May 30th, 2009: First release v0.1


To do list
----------

- change the keyboard color to the sound
- create more songs


License
-------
Distributed under the terms of the MIT license.
Look at [midiator/LICENSE](http://github.com/bleything/midiator/tree/master/LICENSE).


References
----------

- [Note names, MIDI numbers and frequencies](http://www.phys.unsw.edu.au/jw/notes.html)
- [Piano Chord CLIP](http://www.piano-c.com/pianoClip.html) (Japanese)
- [Ruby/DL](http://ttsky.net/ruby/ruby-dl.html)
- [MSDN Library](http://msdn.microsoft.com/en-us/library/default.aspx) - [midiOutOpen](http://msdn.microsoft.com/en-us/library/ms711632(VS.85).aspx), [midiOutShortMsg](http://msdn.microsoft.com/en-us/library/ms711632(VS.85).aspx)
