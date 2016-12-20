# Marbles in E
# By Blaine Buxton
# My first sonic pi piece
use_synth :fm

root = :e2
drone_notes = (chord root, :minor7, num_octaves: 2).shuffle
melody_notes = scale root, :minor_pentatonic, num_octaves: 2

length = 60
with_fx :echo, phase: 1.33, decay: 4 do
  drone = play root, attack: 0, sustain: length, release: 4, depth: 1
  
  in_thread do
    depth = 0
    max_depth = 4
    (length + 4).times do
      control drone, depth_slide: 0.33, depth: depth
      depth = max_depth - depth
      sleep 0.33
      control drone, depth_slide: 0.64, depth: depth
      depth = max_depth - depth
      sleep 0.64
    end
  end
  
  index = 0
  length.times do
    control drone, note: drone_notes.tick, note_slide: 0.375
    sleep 0.5
    next_note = melody_notes[index]
    next_note = :r if one_in(3)
    melody = play next_note, pan: rrand(-1,1), depth: 4, divisor: 4, release: 2
    control melody, depth: 0, depth_slide: 1
    control melody, divisor: 0, divisor_slide: 1
    sleep 0.5
    index += rrand_i(-2,2)
  end
end