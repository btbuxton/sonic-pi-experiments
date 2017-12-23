#future residue
use_synth :fm

root_note = :C2
notes = scale(root_note, :blues_minor).collect { | each | midi_to_hz each }
root = midi_to_hz root_note
divs = notes.collect { | each | each / root }.shuffle

use_bpm 90
with_fx :echo, phase: 6/5.0, decay: 8 do
  with_fx :slicer, phase: 2/3.0, pulse_width: 0.25 do
    live_loop :drone do
      p = play chord(:D3, :minor7).choose, depth: 0, divisor: 0, divisor_slide: 0.5, depth_slide: 0.5, pan_slide: 0.5, attack: 0, sustain: 16, release: 0
      
      16.times do
        sleep 0.5
        control p, depth: 4, divisor: divs.tick, pan: -0.5
        sleep 0.5
        control p, depth: 0, divisor: divs.tick, pan: 0.5
      end
    end
  end
end

