# midi_win.rb
require 'midi_win_lib_c'

class MIDI
  include C

  def initialize
    @device = DL.malloc(DL.sizeof('I'))
    C.midiOutOpen @device, -1, 0, 0, 0
  end

  def message one, two=0, three=0
    message = one + (two << 8) + (three << 16)
    C.midiOutShortMsg @device.ptr.to_i, message
  end
  
  def play note, duration = 0.1, channel = 0, velocity = 100
    [note].flatten.each do |n|
      message( ON | channel, n, velocity )
    end
    sleep duration
    [note].flatten.each do |n|
      message( OFF | channel, n, velocity )
    end 
  end
  
  def program_change channel, program
    message( PC | channel, program )
  end
end
