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
   pitchclass.alteration = random_range(-1, 1)
   return pitchclass
end

function PitchClass:extended_random()
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

local function utf8_sub(s, i, j)
   if s == nil then
      return nil
   elseif s == "" then
      return ""
   end
   
   i = utf8.offset(s, i)
   if j ~= nil then
      j = utf8.offset(s, j + 1) - 1
   end
   return string.sub(s, i, j)
end

function PitchClass:parse(value)
   newpc = PitchClass:new()
   head, tail = utf8_sub(value, 1, 1), utf8_sub(value, 2)
   for iname, name in pairs(NAMES) do
      if name == head then
         newpc.step = iname
         break
      end
   end
   while true do
      head, tail = utf8_sub(tail, 1, 1), utf8_sub(tail, 2)
      if head == "b" or head == FLAT_SYMBOL then
         newpc.alteration = newpc.alteration - 1
      elseif head == "#" or head == SHARP_SYMBOL then
         newpc.alteration = newpc.alteration + 1
      else
         return newpc
      end
   end
end

function PitchClass:name()
   result = NAMES[self.step]
   for i = 1, self._alteration do
      result = result .. "#"
   end
   for i = -1, self._alteration, -1 do
      result = result .. "b"
   end
   return result
end

function PitchClass:pretty_name()
   result = NAMES[self.step]
   for i = 1, self._alteration do
      result = result .. SHARP_SYMBOL
   end
   for i = -1, self._alteration, -1 do
      result = result .. FLAT_SYMBOL
   end
   return result
end

function PitchClass:full_name()
   if self._alteration == -2 then
      return NAMES[self.step] .. " double flat"
   elseif self._alteration == -1 then
      return NAMES[self.step] .. " flat"
   elseif self._alteration == 1 then
      return NAMES[self.step] .. " sharp"
   elseif self._alteration == 2 then
      return NAMES[self.step] .. " double sharp"
   else
      return NAMES[self.step]
   end
end
