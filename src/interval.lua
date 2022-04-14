require "utils"


Interval = require "newclass"(function(self)
   self.size = 1
   self.quality = 0
   self.direction = 0
end)

function Interval:normalize()
   newInterval = Interval:new()
   if self.size == 1 then
      newInterval.size = 1
   else
      newInterval.size = (self.size -2) % 7 +2
   end
   return newInterval
end

-- function Interval:invert()
--    newInterval = Interval:new()
--    return newInterval
-- end