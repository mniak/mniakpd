Pitch = require "newclass"(function(self)
   self._step = 1
   self.alteration = 0
   self.octave = 4
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

