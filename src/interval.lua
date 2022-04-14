require "utils"

Interval = require "newclass"(function(self)
   self.size = 1
   self.quality = 0
   self.direction = 1
end)

Interval.UNISON = 1
Interval.SECOND = 2
Interval.THIRD = 3
Interval.FOURTH = 4
Interval.FIFTH = 5
Interval.SIXTH = 6
Interval.SEVENTH = 7
Interval.OCTAVE = 8

Interval.AUGMENTED = 0
Interval.MAJOR = 1
Interval.PERFECT = 0
Interval.MINOR = -1
Interval.DIMINISHED = 0

Interval.ASCENDING = 1
Interval.DESCENDING = -1

function Interval:normalize()
   int = Interval:new()
   if self.size == 1 then
      int.size = 1
   else
      int.size = (self.size - 2) % 7 + 2
   end
   return int
end

function Interval:invert()
   norm = self.normalize()
   int = Interval:new()
   int.size = 8 - norm.size + 1
   int.direction = -self.direction
   return int
end