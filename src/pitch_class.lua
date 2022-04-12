require "utils"

PitchClass = require "newclass"(function(self)
   self._step = 1
   self._alteration = 0
end)

PitchClass.MIN_STEP = 1
PitchClass.MAX_STEP = 7
PitchClass.MIN_ALTERATION = -2
PitchClass.MAX_ALTERATION = 2

function PitchClass:random()
   pitchclass = PitchClass:new()
   pitchclass.step = random_range(PitchClass.MIN_STEP, PitchClass.MAX_STEP)
   pitchclass.alteration = random_range(PitchClass.MIN_ALTERATION, PitchClass.MAX_ALTERATION)
   return pitchclass
end

function PitchClass:get_step()
   return self._step
end
function PitchClass:set_step(value)
   if value < PitchClass.MIN_STEP then
      return
   end
   self._step = math.floor((value - PitchClass.MIN_STEP) % (PitchClass.MAX_STEP - PitchClass.MIN_STEP + 1) +
                              PitchClass.MIN_STEP)
end

function PitchClass:get_alteration()
   return self._alteration
end

function PitchClass:set_alteration(value)
   self._alteration = math.floor(math.max(PitchClass.MIN_ALTERATION, math.min(PitchClass.MAX_ALTERATION, value)))
end

local NAMES = {"C", "D", "E", "F", "G", "A", "B"}
local FLAT_SYMBOL = "♭"
local SHARP_SYMBOL = "♯"

function PitchClass:name_pretty()
   result = NAMES[self.step]
   for i = 1, self._alteration do
      result = result .. SHARP_SYMBOL
   end
   for i = -1, self._alteration, -1 do
      result = result .. FLAT_SYMBOL
   end
   return result
end
