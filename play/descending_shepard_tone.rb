#descending shepard tone
use_synth :fm
notes_1 = (scale :D3, :aeolian)[0..-1].reverse
notes_2 = (scale :D2, :aeolian)[0..-1].reverse
amp_up = (range 0,7, inclusive: true).collect {|each| each / 7.0 }
amp_up = amp_up[0..-1]
amp_down = amp_up.reverse

live_loop :temp do
  if tick % notes_1.size == 0
    tick
  end
  play notes_1.look, amp: amp_up.look, release: 0.5
  play notes_2.look, amp: amp_down.look, release: 0.5
  sleep 0.5
end
