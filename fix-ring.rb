define :fix_ring do | input |
  dist = 0
  selected = 16
  while selected >= 0 && dist == 0
    selected = selected - 1
    value = input[selected]
    dist = value - selected
  end
  
  if dist == 0
    return input
  end
  
  result = input.to_a
  max = selected + 1
  for index in 0..selected do
      result[index]=input[(index + 1) % max]
    end
    
    return ring *result
  end
  
  startr = range 0, 16, 1
  startr = startr.shuffle
  48.times do
    puts startr
    startr = fix_ring startr
  end
  