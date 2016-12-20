# Fractal beginnings with note length

def lengths(max, step)
  result = []
  left = max
  sum = 0
  while sum < max and left > 0.125 do
      i = left / step
      left = left - i
      result << left
      sum += left
    end
    last = result.pop
    sum -= left
    result << (max - sum)
    #puts result.inject {|sum,x| sum + x}
    return ring *result
  end
  
  use_synth :sine
  use_bpm 120
  lengths = lengths(7.0, 2.0)
  notes = chord(:'e3', :minor, num_octaves: 2)
  live_loop :foo do
    note_len = lengths.tick :length
    play notes.tick :note, sustain: note_len, release: note_len * 0.5, pan: -0.5
    sleep note_len
  end
  
  lengths2 = lengths(5.0, 1.5).reverse
  notes2 = chord(:'e3', :minor, num_octaves: 2).reverse
  live_loop :bar do
    note_len2 = lengths2.tick :length2
    play notes2.tick :note2, sustain: note_len2, release: note_len2 * 0.5, pan: 0.5
    sleep note_len2
  end
  
  lengths3 = lengths(8.0, 2.0).shuffle
  notes3 = chord(:'e2', :minor, num_octaves: 1)
  live_loop :snafu do
    note_len3 = lengths2.tick :length3
    play notes3.choose, sustain: note_len3, release: note_len3 * 0.5
    sleep note_len3
  end