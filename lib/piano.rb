# piano.rb
info PLATFORM

require case PLATFORM
  when /mswin/ : 'midi_win'
  when /darwin/ : 'midi_mac'
  else 'midi_linux' end
require 'piano_methods'

Shoes.app :width => 440, :height => 240, :title => 'piano v0.4' do
  extend PianoMethods
  keyboards = display_piano
  
  midi = MIDI.new
  midi.program_change 0, 1
  
  keyboards.each do |kb|
    kb.click do
      midi.play kb.style[:mn], @code
      @msg.text = "#{kb.style[:nn]},#{kb.style[:mn]}"
      @eb.text += "[#{kb.style[:mn]}, #{@code}], "
      
      button, left, top = self.mouse
      f = flow :left => left - 10, :top => top - 25, :width => 25, :height => 25 do
        oval 0, 0, 25, :fill => rgb(0, 255, 0, 0.5), :stroke => rgb(0, 255, 0, 0.5)
        para kb.style[:nn], :stroke => red, :weight => 'bold', :size => 8
      end
      timer(1){f.remove}     
    end
  end
  
  para link('auto'){
    data = eval("[#{@eb.text}]")
    a = animate 100 do |i|
      a.remove if data.empty?
      mn, len = data.shift
      nn = ''
      keyboards.each{|kb|
        if kb.style[:mn] == mn
          nn = kb.style[:nn]
          kb.style[:shadow].show
          timer(1){kb.style[:shadow].hide}
        end
      }
      if mn.nil?
        timer(1){keyboards.each{|kb| kb.style[:shadow].hide}}
      else
        @msg.text = "#{nn},#{mn}"
        midi.play(mn, len) unless mn.nil?
      end
    end
    }, :left => 10, :top => 120
    
  para link('clear'){@eb.text = ''}, :left => 50, :top => 120
  
  para link('load'){
      fname = ask_open_file
      @eb.text = IO.read(fname) if fname =~ /\.song$/
    }, :left => 90, :top => 120
    
  para link('save'){
      fname = ask_save_file
      open(fname, 'w'){|f| f.puts @eb.text} if fname =~ /\.song$/
    }, :left => 130, :top => 120
    
end
