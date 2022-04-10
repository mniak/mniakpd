Pitch = require "newclass"(function(self)
   self.step = 0
   self.alteration = 0
   self.octave = 4
end)

function Pitch:set_step(value)
   self.step = math.floor(self.step % 7)
end