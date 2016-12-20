def next_iter(input)
  output = []
  input.each do |i|
    if i != :r
      if i < 86
        output << i - 2
      end
      output << :r
      if i > 42
        output << i + 1
      end
    else
      #output << :r #rrand_i(54,74)
    end
  end
  return output
end

use_synth :sine
use_bpm 90
live_loop :foo do
  current = [64]
  note_len = 0.5
  with_fx :echo, phase: 1, decay: 4 do
    10.times do
      current = next_iter(current)
      puts current
      current.each do |n|
        play n, sustain: note_len * 1.25, release: note_len * 0.5
        sleep note_len
      end
      #note_len *= 0.66
    end
  end
end

live_loop :bar do
  use_synth :fm
  current = [64]
  note_len = 1
  p_curr = 0.5
  #with_fx :echo, phase: 0.67 do
  5.times do
    current = next_iter(current)
    puts current
    current.each do |n|
      p_curr = 0.5 == p_curr ? -0.5 : 0.5
      play n, sustain: note_len * 2, release: note_len , amp: 0.75, pan: p_curr
      sleep note_len
    end
    note_len *= 0.66
  end
  #end
end
