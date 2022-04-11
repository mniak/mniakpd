Pitch = require "newclass"(function(self)
   self._step = 1
   self._alteration = 0
   self._octave = 4
end)

function Pitch:get_step()
   return self._step
end
function Pitch:set_step(value)
   if value < 1 then
      return
   end
   self._step = (value-1) % 7 + 1
end

function Pitch:get_alteration()
   return self._alteration
end

function Pitch:set_alteration(value)
   self._alteration = math.max(-2, math.min(2, value))
end


function Pitch:get_octave()
   return self._octave
end

function Pitch:set_octave(value)
   self._octave = math.max(0, math.min(10, value))
end