require "utils"

Interval = require "newclass"(function(self)
   self.size = 1
   self.quality = 0
   self.direction = 1
end)

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

function Interval:parse(text)
   head, tail = utf8_sub(text, 1, 1), utf8_sub(text, 2)
   s = math.tointeger(tail)

   if s == nil then
      return nil
   end

   int = Interval:new()
   int.size = s

   if head == "d" then
      int.quality = Interval.QUALITY_DIMINISHED
   elseif head == "m" then
      int.quality = Interval.QUALITY_MINOR
   elseif head == "P" then
      int.quality = Interval.QUALITY_PERFECT
   elseif head == "M" then
      int.quality = Interval.QUALITY_MAJOR
   elseif head == "A" then
      int.quality = Interval.QUALITY_MAJOR
   else
      return nil
   end
   return int
end
