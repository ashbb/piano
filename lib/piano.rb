# piano.rb
require 'midi_winmm'

Shoes.app :width => 440, :height => 240, :title => 'piano v0.1' do
  background tomato..gold, :angle => 45
  
  a = %w[C D E F G A B].collect{|e| [e + '3', e + '4', e + '5']}
  nn = a.shift.zip(*a).flatten  # Note name
  a = [48, 50, 52, 53, 55, 57, 59].collect{|e| [e, e + 12, e + 24]}
  mn = a.shift.zip(*a).flatten  # MIDI number
  kb_white = []
  21.times{|i| kb_white << rect(10 + 20 * i, 10, 20, 100,
    :fill => white, :nn => nn[i], :mn => mn[i])}
  
  nn = %w[Cs Ds Fs Gs As].collect{|e| [e + '3', e + '4', e + '5']}.flatten
  mn = [49, 51, 54, 56, 58].collect{|e| [e, e + 12, e + 24]}.flatten
  kb_black = []
  pos = [24, 44, 84, 104, 124].collect{|e| [e, e + 140, e + 280]}.flatten
  pos.each_with_index{|x, i| kb_black << rect(x, 10, 14, 60, :nn => nn[i], :mn => mn[i])}
  
  msg = para 'nn,mn', :left => 380, :top => 120
  eb = edit_box :left => 10, :top => 150, :width => 420, :height => 90
  eb.text = "[60, 0.5], [64, 0.5], [67, 0.5], [0, 1.0], [[60, 64, 67], 3.0], "
  
  midi = WinMM.new
  midi.program_change 0, 1
  
  (kb_white + kb_black).each do |kb|
    kb.click do
      midi.play kb.style[:mn], 0.5
      msg.text = "#{kb.style[:nn]},#{kb.style[:mn]}"
      eb.text += "[#{kb.style[:mn]}, 0.5], "
    end
  end
  
  music = lambda do
    eval("[#{eb.text}]").each{|mn, len| midi.play mn, len}
  end
  para link('auto'){music.call}, :left => 10, :top => 120
  para link('clear'){eb.text = ''}, :left => 50, :top => 120
  para link('load'){
      fname = ask_open_file
      eb.text = IO.read(fname) if fname =~ /\.song$/
    }, :left => 90, :top => 120
  para link('save'){
      fname = ask_save_file
      open(fname, 'w'){|f| f.puts eb.text} if fname =~ /\.song$/
    }, :left => 130, :top => 120
end