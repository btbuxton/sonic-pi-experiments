#fm experiment
notes = (scale :d3, :minor_pentatonic, num_octaves: 2).shuffle
use_bpm 120

use_synth :fm
use_synth_defaults decay: 0.1, release: 0.15, cutoff: 130

div = ring 0,3,1,2
dep = ring 1,2,0
ps_r = ring 0,5,7,12,-24,0


with_fx :reverb, room: 0.5 do
  with_fx :pitch_shift, pitch: 0, mix: 0.75 do |ps|
    with_fx :echo, phase: 0.75, decay: 1.5, amp: 0.5 do
      128.times do
        play note: notes.tick(:notes), divisor: div.tick(:div), depth: dep.tick(:dep)
        control ps, pitch: ps_r.tick(:ps)
        sleep 0.5
      end
    end
  end
end