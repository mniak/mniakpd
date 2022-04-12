
Pitch = require "newclass"(function(self)
   self._step = 1
   self._alteration = 0
   self._octave = 4
end)

Pitch.MIN_STEP = 1
Pitch.MAX_STEP = 7
Pitch.MIN_ALTERATION = -2
Pitch.MAX_ALTERATION = 2
Pitch.MIN_OCTAVE = 0
Pitch.MAX_OCTAVE = 10

function Pitch:random()
   self.pitch.step = utils.random_range(Pitch.MIN_STEP, Pitch.MAX_STEP)
   self.pitch.alteration = utils.random_range(Pitch.MIN_ALTERATION, Pitch.MAX_ALTERATION)
   self.pitch.octave = utils.random_range(Pitch.MIN_OCTAVE, Pitch.MAX_OCTAVE)
end

function Pitch:get_step()
   return self._step
end
function Pitch:set_step(value)
   if value < Pitch.MIN_STEP then
      return
   end
   self._step = math.floor((value-Pitch.MIN_STEP) % (Pitch.MAX_STEP - Pitch.MIN_STEP + 1) + Pitch.MIN_STEP)
end

function Pitch:get_alteration()
   return self._alteration
end

function Pitch:set_alteration(value)
   self._alteration = math.floor(math.max(Pitch.MIN_ALTERATION, math.min(Pitch.MAX_ALTERATION, value)))
end


function Pitch:get_octave()
   return self._octave
end

function Pitch:set_octave(value)
   self._octave = math.floor(math.max(0, math.min(10, value)))
end