GRAMMAR = { 'A' => "AB", 'B' => "A" }
def next_iter(input)
  output = ""
  input.each_char do |c|
    output += GRAMMAR[c]
  end
  
  return output
end

use_synth :sine
use_bpm 210
current = "B"
10.times do
  puts current
  current = next_iter(current)
  current.each_char do |c|
    if c == 'A'
      play rrand(45, 81), sustain: 1
    end
    if c == 'B'
      sleep 0.5
    end
    sleep 0.5
  end
end