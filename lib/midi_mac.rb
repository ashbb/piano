# midi_mac.rb
require 'midi_mac_lib_c'

class MIDI
  include C, CF

  def initialize
    client_name = CF.cFStringCreateWithCString( nil, "Piano", 0 )
    @client = DL::PtrData.new( nil )
    C.mIDIClientCreate( client_name, nil, nil, @client.ref )

    port_name = CF.cFStringCreateWithCString( nil, "Output", 0 )
    @outport = DL::PtrData.new( nil )
    C.mIDIOutputPortCreate( @client, port_name, @outport.ref )

    @destination = C.mIDIGetDestination( 0 )
  end

  def message( *args )
    format = "C" * args.size
    bytes = args.pack( format ).to_ptr
    packet_list = DL.malloc( 256 )
    packet_ptr = C.mIDIPacketListInit( packet_list )

    # Pass in two 32-bit 0s for the 64 bit time
    packet_ptr = C.mIDIPacketListAdd( packet_list, 256, packet_ptr, 0, 0, args.size, bytes )

    C.mIDISend( @outport, @destination, packet_list )
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
