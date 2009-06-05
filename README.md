piano
=====

Simple Piano in Shoes. You can play the MIDI piano with the mouse. :)

**Note:**   
I've hacked [bleything/midiator](http://github.com/bleything/midiator/tree/master) to pick up the core MIDI interface part. :)   
I know I can use MIDIator gem with Shoes. But I want to understand the basic MIDI usage and this tiny Shoes app doesn't need the big codes.

Piano v0.1 and v0.2 are Windows version only.   
Piano v0.3 includes the drivers for Mac and Linux. But I have no Mac and Linux... :(   
**Hope someone attempt to run v0.3 on his/her Mac or Linux and let me know what happen.** ;-)

- Jun 3rd: **Paul Harris** attempted to run v0.3 on his (k)ubuntu 9.04 with TiMIDIty. It worked well. Fantastic! Now need some connecting sequence by hand, so trying to find the easy way.
- Jun 5th: **Willian Molinari** run v0.4 on his i686-linux. It didn't work and got the error message: libasound.so: cannot open shared object file: No such file or directory. Umm...


Usage
-----

	cd piano/lib
	shoes piano.rb

Songs
-----

- `songs/sakura.song` is a traditional Japanese folk song. See [wikipedia](http://en.wikipedia.org/wiki/Sakura_Sakura).
- [Silent Night](http://gardenofpraise.com/key21e.htm)
- [Sippin' Cider Through a Straw](http://gardenofpraise.com/key21t.htm)
- [Joy to the World](http://gardenofpraise.com/key21be.htm)
- `songs/tulip.song` is a traditional Japanese folk song. 

Snapshot
--------
![piano_snapshot.png](http://github.com/ashbb/piano/raw/master/piano_snapshot.png)


Change log
----------
Jun 04th, 2009: Updated to v0.4 which changes the keyboard color to the sound.   
Jun 03rd, 2009: Added a small comment about Paul's great work. Added one more song.    
Jun 02nd, 2009: Wrote the drivers for Mac and Linux (v0.3). But not get a chance to run so far.     
Jun 01st, 2009: Added more one song and improved the editing chrone function (v0.2).   
May 31th, 2009: Added the hovering message function (v0.1a) and two songs.      
May 30th, 2009: First release v0.1


To do list
----------

- prepare drivers for Mac and Linux
- change the keyboard color to the sound... done!
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
- [MSDN Library](http://msdn.microsoft.com/en-us/library/default.aspx) - <a href="http://msdn.microsoft.com/en-us/library/ms711632(VS.85).aspx">midiOutOpen</a>, <a href="http://msdn.microsoft.com/en-us/library/ms711632(VS.85).aspx">midiOutShortMsg</a>
