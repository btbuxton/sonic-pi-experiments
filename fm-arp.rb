use_bpm 120
use_synth :fm
notes = chord(:e3, :sus4).shuffle
live_loop :arp do
  node = play notes.tick, release: 0.25, divisor: rrand_i(1,7), depth: rrand_i(0,4)
  control node, depth: 0, depth_slide: 0.125, divisor: 0.5, divisor_slide: 0.125
  sleep 0.5
end

more = chord(:e4, :sus4).shuffle
with_fx :echo, phase: 7, decay: 10, mix: 0.5 do
  live_loop :arp_2 do
    5.times do
      node = play more.tick, release: 0.1
      control node, divisor: 4, divisor_slide: 0.2
      control node, depth: 4, depth_slide: 0.4
      sleep 0.4
    end
    sleep 8
  end
end
