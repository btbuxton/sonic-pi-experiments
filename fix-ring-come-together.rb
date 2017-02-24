# Original
use_bpm 90
define :metro do
  live_loop :metro do
    cue :metro
    sleep 0.25
  end
end

sample1 = "/home/btbuxton/Music/cosmic/001_Cosmic_Part01.wav"
sample2 = "/home/btbuxton/Music/cosmic/001_Cosmic_Part09.wav"
sample3 = "/home/btbuxton/Music/cosmic/001_Cosmic_Part10.wav"
sample4 = "/home/btbuxton/Music/cosmic/001_Cosmic_Part13.wav"
sample5 = "/home/btbuxton/Music/cosmic/001_Cosmic_Part16.wav"

startr = range 0, 16, 1
startr = startr.shuffle

live_loop :samples do
  sync :metro
  tick
  diff = (look % 16) - startr.look
  rate = 1 - (diff / 16.0)
  sample sample1, start: (startr.look / 16.0), finish: (startr.look / 16.0) + 0.0625, rate: rate, pan: rrand(-0.6,0.6)
  sample sample2, start: (startr.look / 16.0), finish: (startr.look / 16.0) + 0.0625, rate: rate, pan: rrand(-0.5,0.5)
  sample sample3, start: (startr.look / 16.0), finish: (startr.look / 16.0) + 0.0625, rate: rate, pan: rrand(-0.5,0.5)
  sample sample4, start: (startr.look / 16.0), finish: (startr.look / 16.0) + 0.0625, rate: rate, pan: rrand(-0.5,0.5)
  sample sample5, start: (startr.look / 16.0), finish: (startr.look / 16.0) + 0.0625, rate: rate, pan: rrand(-0.5,0.5)
  
  #sample sample2, start: startr.look, finish: startr.look + 0.0625 #, rate: rrand(-2,2)
  #sample sample3, start: startr.look, finish: startr.look + 0.0625 #, rate: rrand(-2,2)
  #sample sample4, start: startr.look, finish: startr.look + 0.0625 #, rate: rrand(-2,2)
  #sample sample5, start: startr.look, finish: startr.look + 0.0625 #, rate: rrand(-2,2)
  #puts sample_duration(sample1)
  #sleep sample_duration(sample1)
  sleep 0.25
  if (look % 16) == 0
    startr = fix_ring startr
  end
end

metro