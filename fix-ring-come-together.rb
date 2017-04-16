# Original
use_bpm 45 #90

define :metro do
  live_loop :metro do
    cue :metro
    sleep 0.25
  end
end

samples = [
  "/home/btbuxton/Music/cosmic/001_Cosmic_Part01.wav",
  "/home/btbuxton/Music/cosmic/001_Cosmic_Part09.wav",
  "/home/btbuxton/Music/cosmic/001_Cosmic_Part10.wav",
  "/home/btbuxton/Music/cosmic/001_Cosmic_Part13.wav",
  "/home/btbuxton/Music/cosmic/001_Cosmic_Part16.wav"
]

startr = samples.collect do | eachSample |
  each = range 0, 16, 1
  each.shuffle
end
#with_fx :reverb do
with_fx :echo, mix: 0.5, phase: 0.66, decay: 4 do
  samples.each_with_index do | eachSample, index |
    live_loop ('sample' + index.to_s).to_sym do
      sync :metro
      tick
      
      diff = (look % 16) - startr[index].look
      rate = 1 - (diff / 16.0)
      start = startr[index].look / 16.0
      step = 1.0 / 16 #1.0 / (16 + (2 * diff.abs))
      if !(one_in 4) || diff == 0
        roll = 1
        roll = rrand_i(1,6) if (one_in 16)
        step = step / roll
        roll.times do
          sample eachSample, start: start, finish: (start + step), rate: rate, pan: rrand(-0.5,0.5)
          sleep 0.25 / roll
        end
      end
      
      if (look % 16) == 0
        startr[index] = fix_ring startr[index]
      end
    end
  end
  
  #end
end

metro