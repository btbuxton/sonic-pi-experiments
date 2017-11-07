### Chords


class Outcome
  def initialize()
    @chances=[]
  end
  
  def add(probability, value)
    @chances << Chance.new(probability, value)
  end
  
  def next(random)
    @chances.each do | chance |
      if random <= chance.probability
        return chance.value
      end
      random = random - chance.probability
      if random < 0
        return chance
      end
    end
    return @chances.any.value
  end
  
  
  def to_s()
    return @chances.to_s
  end
  
end

class Chance
  attr_reader(:value,:probability)
  def initialize(probability, value)
    @probability = probability
    @value = value
  end
end

# Start on I and end on I
# I -> ANY
chain= {}
outcome = Outcome.new
outcome.add(1.0 / 7, 1)
outcome.add(1.0 / 7, 2)
outcome.add(1.0 / 7, 3)
outcome.add(1.0 / 7, 4)
outcome.add(1.0 / 7, 5)
outcome.add(1.0 / 7, 6)
outcome.add(1.0 / 7, 7)
chain[1]=outcome
# ii -> iii, V
outcome = Outcome.new
outcome.add(1.0 / 3, 2)
outcome.add(1.0 / 3, 3)
outcome.add(1.0 / 3, 5)
chain[2]=outcome
# iii -> ii, vi, IV
outcome = Outcome.new
outcome.add(1.0 / 4, 2)
outcome.add(1.0 / 4, 3)
outcome.add(1.0 / 4, 4)
outcome.add(1.0 / 4, 6)
chain[3]=outcome
# IV -> iii, I, V, ii
outcome = Outcome.new
outcome.add(1.0 / 5, 1)
outcome.add(1.0 / 5, 2)
outcome.add(1.0 / 5, 3)
outcome.add(1.0 / 5, 4)
outcome.add(1.0 / 5, 5)
chain[4]=outcome
# V -> I, vi
outcome = Outcome.new
outcome.add(1.0 / 3, 1)
outcome.add(1.0 / 3, 5)
outcome.add(1.0 / 3, 6)
chain[5]=outcome
# vi -> ii, IV, V
outcome = Outcome.new
outcome.add(1.0 / 4, 2)
outcome.add(1.0 / 4, 4)
outcome.add(1.0 / 4, 5)
outcome.add(1.0 / 4, 6)
chain[6]=outcome
# vii -> I, vii
outcome = Outcome.new
outcome.add(1.0 / 2, 1)
outcome.add(1.0 / 2, 7)
chain[7]=outcome

use_random_seed 100
next_out = chain[7]
value = rand()

puts value
puts next_out.next(value)

use_synth :piano
use_bpm 120
current = 1
live_loop :chords do
  puts current
  play_chord (chord_degree current, :e3, :minor, 3), release: 4
  play_pattern (chord_degree current, :e2, :minor, 4).shuffle
  current = chain[current].next(rand())
end

#with_synth :fm do |node|
#  node = play (chord :e3, :minor), release: 4, depth: 0, divisor: 1, depth_slide: 2, note_slide: 2
#play_chord chord(:e3, :minor), release: 4, depth: 0, divisor: 1
#play :e3, release: 4, depth: 0, divisor: 1
#  sleep 1
#  control node, depth: 2, notes: (chord :e2, :minor)
#  sleep 2
#  sleep 1
#end

#with_synth :fm do |node|
#  node = play (chord :e3, :minor), release: 4, depth: 0, divisor: 1, depth_slide: 2, note_slide: 2
#play_chord chord(:e3, :minor), release: 4, depth: 0, divisor: 1
#play :e3, release: 4, depth: 0, divisor: 1
#  sleep 1
#  control node, depth: 2, notes: (chord :e2, :minor)
#  sleep 2
#  sleep 1
#end