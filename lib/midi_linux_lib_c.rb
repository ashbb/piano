# midi_linux_lib_c.rb
require 'dl/import'
ON  = 0x90
OFF = 0x80
PC  = 0xc0

module C
  extend DL::Importer
  dlload 'libasound.so'

  extern "int snd_rawmidi_open(void*, void*, char*, int)"
  extern "int snd_rawmidi_close(void*)"
  extern "int snd_rawmidi_write(void*, void*, int)"
  extern "int snd_rawmidi_drain(void*)"
end
