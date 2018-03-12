#wild 303
notes = (scale :e1, :minor_pentatonic, num_octaves: 2).shuffle

s = synth :tb303, sustain: 8, note_slide: 0.05, cutoff_slide: 0.20
64.times do
  control s, note: notes.tick, cutoff: rrand(50,100)
  sleep 0.25
end