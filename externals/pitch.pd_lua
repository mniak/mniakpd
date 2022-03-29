require "libs"

local patch = pd.Class:new():register("pitch")

local MIN_OCTAVE <const> = 0
local MAX_OCTAVE <const> = 10
local MIN_ALTERATION <const> = -2
local MAX_ALTERATION <const> = 2

local CHOICES = {
            {0, 0}, {0, 1},
   {1, -1}, {1, 0}, {1, 1},
   {2, -1}, {2, 0}, {2, 1},
   {3, -1}, {3, 0}, {3, 1},
   {4, -1}, {4, 0}, {4, 1},
   {5, -1}, {5, 0}, {5, 1},
   {6, -1}, {6, 0},
}

function patch:initialize(sel, atoms)
   if #atoms > 0 and atoms[1] == "class" then
      self.inlets = 2
      self.mode = "class"
   else 
      self.inlets = 3
   end
   self.outlets = 1
   
   self.step = 0
   self.alteration = 0
   self.octave = 4

   self["in_n_pitch-class"] = self.in_n_pitch_class
   return true
end

function patch:in_1_bang()
   -- Normalize values
   self.step = math.floor(self.step % 7)
   self.alteration = truncate_range(self.alteration, MIN_ALTERATION, MAX_ALTERATION)
   self.octave = truncate_range(self.octave, MIN_OCTAVE, MAX_OCTAVE)

   if self.mode == "class" then
      self:outlet(1, "pitch-class", {self.step, self.alteration})
   else 
      self:outlet(1, "pitch", {self.step, self.alteration, self.octave})
   end
end

function patch:in_1_float(step)
   self.step = step
   self:in_1_bang()
end

function patch:in_2_float(alteration)
   self.alteration = alteration
end

function patch:in_3_float(octave)
   self.octave = octave
end

function patch:in_n_pitch(n, pitch)
   self.step = pitch[1]
   self.alteration = pitch[2]
   self.octave = pitch[3]
   if n == 1 then 
      self:in_1_bang()
   end
end

function patch:in_n_pitch_class(n, pitchclass)
   self.step = pitchclass[1]
   self.alteration = pitchclass[2]
   if n == 1 then 
      self:in_1_bang()
   end
end


function patch:in_n_random(n, atoms)
   choice = random_choice(CHOICES)
   self.step = choice[1]
   self.alteration = choice[2]
   self.octave = random_range(MIN_OCTAVE, MAX_OCTAVE)
   if n == 1 then 
      self:in_1_bang()
   end
end
