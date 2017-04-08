use_synth :fm
use_bpm 90

def bit_rhythm(bits)
  rlist = []
  8.times do
    rlist << (bits & 1)
    bits = bits >> 1
  end
  return ring *rlist
end

notes = scale :D, :phrygian

live_loop :steady do
  sync :bits
  play notes.tick(:steady), release: 2
  notes.tick(:steady)
end

rhythm = 0
live_loop :bits do
  rhythm = rhythm + 1
  if  rhythm == 256
    rhythm = 0
  end
  
  puts "rhythm", rhythm
  rlist = bit_rhythm(rhythm)
  bits = rrand_i(1,255)
  8.times do
    should_play = rlist.tick
    #puts "should_play", should_play
    if should_play != 0
      bits = bits >> 1
      play notes[bits & 7], release: 0.5
    end
    sleep 0.25
  end
  
end
