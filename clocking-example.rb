use_bpm 86

MEASURE = 1.0 * 4
SIXTEENTH = MEASURE / 16

define :clock do
  live_loop :clock do
    sleep SIXTEENTH
  end
end

define :bass do
  trigr = ring 1,1,0,1,1,0,1,0,1,1,0,0,1,1,0,0
  velr = ring  1,0.25,0.5,0.25,0.75,0.25,0.5,0.25,0.75,0.25,0.5,0.25,0.75,0.25,0.5,0.25
  notes = ring :e2, :e1, :b1
  use_synth :tb303
  in_thread(name: :bass) do
    with_fx :reverb, room: 0.25, damp: 1.0 do
      256.times do
        sync :clock
        tick
        play notes.look, cutoff: (120 * velr.look), release: SIXTEENTH if trigr.look == 1
        #sleep SIXTEENTH
      end
    end
  end
end

define :arp do
  trigr = ring 1,0,0,0,1,0,0,0,1,0,0,1,0,0,1,0,0 #, 0,0,0,0, 0,0,0,0#, 0,0,0,0, 0,0,0,0
  velr = ring  1,0.25,0.5,0.25,0.75,0.25,0.5,0.25,0.75,0.25,0.5,0.25,0.75,0.25,0.5,0.25
  notes =  scale(:e2, :minor_pentatonic).shuffle
  pan = -0.5
  
  use_synth :pluck
  with_fx :pan, phase: 1, pan_min: -0.5, pan_max: 0.5 do
    with_fx :echo, phase: 3 do
      live_loop :arp do
        sync :clock
        tick
        pan = pan < 0 ? 0.5 : -0.5 if trigr.look
        play notes.look, release: SIXTEENTH * 3 , pan: pan if trigr.look == 1
        #sleep SIXTEENTH
      end
    end
  end
end

clock
bass
64.times do
  sync :clock
end

arp