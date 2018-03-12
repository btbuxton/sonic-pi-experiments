#sci-fi drums
# to study
use_synth :tb303
#with_fx :wobble do
#  play 50, sustain: 4
#  sleep 4
#end
#sleep 1
#
#with_fx :tanh do
#  play 50, sustain: 4
#  sleep 4
#end
#sleep 1
use_bpm 120

with_fx :echo do
  with_fx :vowel, vowel_sound: 1 do |fx|
    live_loop :foo do
      play (scale :fs0, :minor_pentatonic, num_octaves: 4).choose, sustain: 12
      5.times do |vs|
        5.times do |v|
          control fx, vowel_sound: rrand_i(1,3), voice: rrand_i(0,2)
          play (scale :fs0, :minor_pentatonic, num_octaves: 4).choose
          sleep 0.5
        end
      end
    end
  end
end
