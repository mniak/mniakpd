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

function Pitch:extended_random()
   pitch = Pitch:new()
   pitch.class = PitchClass:extended_random()
   pitch.octave = random_range(Pitch.MIN_OCTAVE, Pitch.MAX_OCTAVE)
   return pitch
end

function Pitch:name()
   pcname = self.class.name() .. self._octave
   return pcname
end

local SUPERSCRIPT_OCTAVES = {"⁰", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹", "¹⁰"}
function Pitch:pretty_name()
   pcname = self.class.pretty_name() .. SUPERSCRIPT_OCTAVES[self._octave + 1]
   return pcname
end

function Pitch:full_name()
   pcname = self.class.full_name() .. " " .. self._octave
   return pcname
end

function Pitch:transpose(interval)
   newPitch = Pitch:new()
   newPitch.step = self.step + interval.size -1
   if interval.quality == Interval.QUALITY_AUGMENTED then
      newPitch.alteration = self.alteration + 1
   elseif  interval.quality == Interval.QUALITY_DIMINISHED then
      newPitch.alteration = self.alteration -1
   else 
      newPitch.alteration = self.alteration
   end
   newPitch.octave = self.octave + math.floor((self.step -1 + interval.size) / 7)
   return newPitch
end
