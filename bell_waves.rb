# Bell waves
use_synth :fm
with_fx :flanger do
  with_fx :echo, phase: 4 / 7.0 do
    live_loop :sci_fi do
      p = play (scale :D4, :egyptian).choose - [0, 12, -12].choose, pan: -0.5, divisor: 0.01, div_slide: rrand(0, 10), depth: rrand(0.001, 2), attack: 0.01, release: rrand(0, 5), amp: 0.5
      control p, divisor: rrand(0.001, 10)
      sleep [0.5, 1].choose
    end
    
    live_loop :sci_fi_again do
      p = play (scale :D3, :egyptian).choose - [0, 12, -12].choose, pan: 0.5, divisor: rrand(0.001, 5), depth: rrand(0.001, 2), attack: 0.01, release: rrand(0, 5), amp: 0.6
      control p, divisor: 0.001
      sleep [1.0 / 3, 1.5, 2.0 / 5].choose
    end
  end
end
