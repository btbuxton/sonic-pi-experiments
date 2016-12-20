# Playing with effects and sine waves
# This is so peaceful and sometimes unnerving
# Love the microtonal aspect
# By Blaine Buxton
use_synth :sine
with_fx :echo, phase: 0.33, decay: 4 do
  with_fx :panslicer, wave: 3 do
    with_fx :slicer, phase: 0.5, wave: 3 do
      live_loop :fx_test do
        play rrand(45,81), sustain: 4
        sleep 2
        play rrand(45,81), sustain: 4
        sleep 2
      end
    end
  end
end
