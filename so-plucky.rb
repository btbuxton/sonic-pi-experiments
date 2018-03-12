#so plucky
use_bpm 86
notes =  (scale(:e2, :minor_pentatonic)).shuffle
use_synth :pluck
spr = spread 7,12
velr = spread 5,13
with_fx :echo, phase: (0.66 + (0.33 / 2)) do
  144.times do
    tick
    if velr.look
      vel = 1.0
    else
      vel = 0.5
    end
    
    play notes.look, amp: vel if spr.look
    sleep 0.33
  end
end