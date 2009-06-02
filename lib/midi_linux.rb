# midi_linux.rb
require 'midi_linux_lib_c'

class MIDI
  include C
  
  def initialize
    @output = DL::PtrData.new(nil)
    C.snd_rawmidi_open(nil, @output.ref, "virtual", 0)
  end

  def message(*args)
    format = "C" * args.size
    bytes = args.pack(format).to_ptr
    C.snd_rawmidi_write(@output, bytes, args.size)
    C.snd_rawmidi_drain(@output)
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
