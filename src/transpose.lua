require "interval"
require "pitch"

function transpose(pitch, interval)
   newPitch = Pitch:new()
   newPitch.step = pitch.step
   newPitch.alteration = pitch.alteration
   newPitch.octave = pitch.octave + math.floor((interval.size) / 7)
   return newPitch
end
