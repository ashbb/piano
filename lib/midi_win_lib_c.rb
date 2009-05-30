# midi_win_lib_c.rb
require 'dl/import'
ON  = 0x90
OFF = 0x80
PC  = 0xc0

module C
  extend DL::Importable
  dlload 'winmm'

  extern "int midiOutOpen(HMIDIOUT*, int, int, int, int)"
  extern "int midiOutShortMsg(int, int)"
end