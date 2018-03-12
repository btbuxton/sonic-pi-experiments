#drama
use_synth :sine

in_thread name: :down, delay: 0 do
  with_synth :mod_sine do
    syn = play 70, attack: 4, sustain: 2, mod_wave: 3
    control syn, mod_phase: 0.03125, mod_phase_slide: 6
    control syn, note: 58, note_slide: 4
    sleep 4
  end
end

in_thread name: :noise do
  with_synth :noise do
    4.times do
      syn = play 64, release: 0.25, cutoff: rrand(64,96), res: 0.5
      sleep 1
    end
  end
end


with_fx :echo do
  with_fx :octaver do
    syn = play 64, sustain: 4
    sleep 2
    control syn, note: 40, note_slide: 2
    sleep 2
    control syn, note: 64, note_slide: 1
  end
end

