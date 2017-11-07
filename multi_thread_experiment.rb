# Experiment for changing values in a separate thread
use_bpm 90
class Notes
  def initialize(pi)
    @notes=[].ring
    @pi=pi
  end
  
  def start()
    @pi.live_loop :notes do
      @notes=@pi.chord(:e3, :minor7)
      @pi.sleep 4
      @notes=@pi.chord(:b3, :minor7)
      @pi.sleep 4
      @notes=@pi.chord(:a3, :minor7)
      @pi.sleep 4
      @notes=@pi.chord(:e3, :sus4)
      @pi.sleep 4
    end
    return self
  end
  
  def notes()
    return @notes
  end
end

puts self
note_inst = Notes.new(self).start()
use_synth :fm
use_synth_defaults divisor: 1.75, depth: 1.0
with_fx :echo, phase: 1.5, decay: 4, mix: 0.5 do
  #4/4
  live_loop :run_one do
    use_synth_defaults depth: rrand(0.1, 2.0), attack: 0.5, release: 0.5, pan: -0.5
    play note_inst.notes.choose
    sleep 0.5
    play note_inst.notes.choose
    sleep 0.5
    play note_inst.notes.choose
    sleep 1
    #play_pattern_timed note_inst.notes.shuffle, [0.5,0.5,1]
    sleep 2
  end
  
  #5/4
  live_loop :run_two do
    use_synth_defaults depth: rrand(0.1, 1.0), attack: 0.5, release: 1.0, pan: 0.5
    sleep 1
    play note_inst.notes.choose
    sleep 1
    play note_inst.notes.choose
    sleep 1
    play note_inst.notes.choose
    sleep 1
    #play_pattern_timed note_inst.notes.shuffle, [1,1,1]
    sleep 1
  end
  
  #7/4
  live_loop :run_three do
    sleep 5
    use_synth_defaults depth: rrand(1.0, 4.0), attack: 0.16666, release: 0.333
    play note_inst.notes.choose
    sleep 0.66
    play note_inst.notes.choose
    sleep 0.67
    play note_inst.notes.choose
    sleep 0.67
    #play_pattern_timed note_inst.notes.shuffle, [0.66,0.67,0.67]
  end
  
  live_loop :bass do
    use_synth :square
    use_synth_defaults amp: 0.5
    to_play = note(note_inst.notes[0]) - 12
    play to_play, release: 0.25, pan: -0.5
    sleep 0.33
    to_play = note(note_inst.notes[0]) - 5
    play to_play, release: 0.25, pan: 0.5
    sleep 0.33
    to_play = note(note_inst.notes[0])
    play to_play, release: 0.25, pan: 0.0
    sleep 1.33
    sleep 1.0
  end
end

