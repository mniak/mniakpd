require "utils"

Interval = require "newclass"(function(self)
   self.raw_size = 0
   self.quality = 0
   self.direction = 1
end)

function Interval:get_size()
   return self.raw_size + 1
end

function Interval:set_size(value)
   self.raw_size = value - 1
end

Interval.SIZE_UNISON = 1
Interval.SIZE_SECOND = 2
Interval.SIZE_THIRD = 3
Interval.SIZE_FOURTH = 4
Interval.SIZE_FIFTH = 5
Interval.SIZE_SIXTH = 6
Interval.SIZE_SEVENTH = 7
Interval.SIZE_OCTAVE = 8

Interval.QUALITY_AUGMENTED = 2
Interval.QUALITY_MAJOR = 1
Interval.QUALITY_PERFECT = 0
Interval.QUALITY_MINOR = -1
Interval.QUALITY_DIMINISHED = -2

Interval.DIRECTION_ASCENDING = 1
Interval.DIRECTION_DESCENDING = -1

function Interval:normalize()
   int = Interval:new()
   if self.raw_size == 0 then
      int.raw_size = 0
   else
      int.raw_size = (self.raw_size - 1) % 7 + 1
   end
   return int
end

function Interval:invert()
   norm = self.normalize()
   int = Interval:new()
   int.raw_size = 7 - norm.raw_size
   int.direction = -self.direction
   return int
end
