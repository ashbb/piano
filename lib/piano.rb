# piano.rb
info PLATFORM
require case PLATFORM
  when /mswin/ : 'midi_win'
  when /darwin/ : 'midi_mac'
  else 'midi_linux' end

Shoes.app :width => 440, :height => 240, :title => 'piano v0.3' do
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
  
  imgs, codes = [], [1.0, 0.75, 0.5, 0.375, 0.25, 0.125, 0.5, 0.25]
  8.times do |i|
    w, h, x, y = 20, 30, 200 + i * 20, 115
    imgs << image("../imgs/#{i}.png", 
      :width => w, :height => h, :left => x, :top => y, :fc => nil, :code => codes[i])
    imgs.last.style :fc => rect(:width => w, :height => h, :left => x, :top => y, 
        :fill => rgb(0, 255, 0, 0.5), :stroke => white).hide
  end
  imgs[2].style[:fc].show
  code = imgs[2].style[:code]
  imgs.each_with_index do |img, n|
    img.click do
      imgs.each{|e| e.style[:fc].hide}
      img.style[:fc].show
      code = img.style[:code]
      eb.text += "[0, #{code}], "  if n > 5
    end
  end
  
  midi = MIDI.new
  midi.program_change 0, 1
  
  (kb_white + kb_black).each do |kb|
    kb.click do
      midi.play kb.style[:mn], code
      msg.text = "#{kb.style[:nn]},#{kb.style[:mn]}"
      eb.text += "[#{kb.style[:mn]}, #{code}], "
      
      button, left, top = self.mouse
      f = flow :left => left - 10, :top => top - 25, :width => 25, :height => 25 do
        oval 0, 0, 25, :fill => rgb(0, 255, 0, 0.5), :stroke => rgb(0, 255, 0, 0.5)
        para kb.style[:nn], :stroke => red, :weight => 'bold', :size => 8
      end
      timer(1){f.remove}      
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