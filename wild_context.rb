#wild context
use_synth :tb303
use_synth_defaults wave: 1, res: 0.76
use_bpm 90
live_loop :context do
  all = ring(scale(:D3, :minor_pentatonic),
             scale(:G2, :minor_pentatonic),
             scale(:A3, :minor_pentatonic))
  
  notes = all.tick
  set :notes, shuffle(notes)
  sleep 8
end

rhythm_one = spread(4,13)
with_fx :reverb do
  live_loop :one do
    notes = get[:notes]
    if notes != nil and rhythm_one.tick then
      play(notes.choose, pan: -0.5, release: 0.25, cutoff: rrand(60, 100))
    end
    sleep 0.25
  end
end


rhythm_two = spread(7,15)
with_fx :reverb do
  live_loop :two do
    notes = get[:notes]
    if notes != nil and rhythm_two.tick then
      play(notes.choose, pan: 0.5, release: 0.25, cutoff: rrand(60, 100))
    end
    sleep 0.25
  end
end

rhythm_three = spread(3,5)
with_fx :echo, phase: 4.0/5.0, decay: 5 do
  live_loop :three do
    notes = get[:notes]
    played = nil
    if notes != nil and rhythm_three.tick then
      played = play((notes.tick :note) - 12, release: 6, amp: 0.5, cutoff: rrand(40, 80), cutoff_sustain: 120, cutoff_attack: 4)
    end
    sleep 2
    control played, note: (notes.tick :note), note_slide: 2 if played != nil
    sleep 2
    
  end
end

