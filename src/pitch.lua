require "utils"
require "pitch_class"

Pitch = require "newclass"(function(self)
   self.class = PitchClass:new()
   self._octave = 4
end)

Pitch.MIN_STEP = PitchClass.MIN_STEP
Pitch.MAX_STEP = PitchClass.MAX_STEP
Pitch.MIN_ALTERATION = PitchClass.MIN_ALTERATION
Pitch.MAX_ALTERATION = PitchClass.MAX_ALTERATION
Pitch.MIN_OCTAVE = 0
Pitch.MAX_OCTAVE = 10

function Pitch:get_step()
   return self.class.step
end
function Pitch:set_step(value)
  self.class.step = value
end

function Pitch:get_alteration()
   return self.class.alteration
end

function Pitch:set_alteration(value)
   self.class.alteration = value
end


function Pitch:get_octave()
   return self._octave
end

function Pitch:set_octave(value)
   self._octave = math.floor(math.max(0, math.min(10, value)))
end

function Pitch:random()
   pitch = Pitch:new()
   pitch.class = PitchClass:random()
   pitch.octave = random_range(Pitch.MIN_OCTAVE, Pitch.MAX_OCTAVE)
   return pitch
end
