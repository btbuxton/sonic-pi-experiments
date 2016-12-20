# FM Serialism
# By Blaine Buxton
# My first attempt at serial music using fm synth. It's not exactly
# by the rules, but so what.

use_synth :fm

root = :f2
notes = (scale root, :chromatic, num_octaves: 3).shuffle
divs = ring(*25.times.collect {|div| 1.0 / (div+1.0)}).shuffle

define :one_beat do | note, subs |
  s = play note, attack: 0.5, sustain: 0.5, divisor: 0, depth: 4, pan: rrand(-0.5, 0.5)
  if one_in(3) then
    sleep 1
  else
    time = 1.0 / subs
    subs.times do
      sleep time
      control s, divisor: divs.tick, divisor_slide: (time / 2.0)
    end
  end
end

48.times do
  one_beat(notes.tick, rrand_i(2,8))
end

notes = notes.reverse
48.times do
  one_beat(notes.tick, rrand_i(2,8))
end