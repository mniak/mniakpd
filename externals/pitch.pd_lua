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
   
   self.pitch = Pitch:new()
   -- self.step = 0
   -- self.alteration = 0
   -- self.octave = 4

   self["in_n_pitch-class"] = self.in_n_pitch_class
   return true
end

function patch:in_1_bang()
   -- Normalize values
   pd.post(string.format(">>> PITCH: %g",  self.pitch.step))
   -- self.pitch.step = math.floor(self.pitch.step % 7)
   self.pitch.alteration = truncate_range(self.pitch.alteration, MIN_ALTERATION, MAX_ALTERATION)
   self.pitch.octave = truncate_range(self.pitch.octave, MIN_OCTAVE, MAX_OCTAVE)

   if self.mode == "class" then
      self:outlet(1, "pitch-class", {self.pitch.step, self.pitch.alteration})
   else 
      self:outlet(1, "pitch", {self.pitch.step, self.pitch.alteration, self.pitch.octave})
   end
end

function patch:in_1_float(step)
   self.pitch.step = step
   self:in_1_bang()
end

function patch:in_2_float(alteration)
   self.pitch.alteration = alteration
end

function patch:in_3_float(octave)
   self.pitch.octave = octave
end

function patch:in_n_pitch(n, pitch)
   self.pitch.step = pitch[1]
   self.pitch.alteration = pitch[2]
   self.pitch.octave = pitch[3]
   if n == 1 then 
      self:in_1_bang()
   end
end

function patch:in_n_pitch_class(n, pitchclass)
   self.pitch.step = pitchclass[1]
   self.pitch.alteration = pitchclass[2]
   if n == 1 then 
      self:in_1_bang()
   end
end


function patch:in_n_random(n, atoms)
   choice = random_choice(CHOICES)
   self.pitch.step = choice[1]
   self.pitch.alteration = choice[2]
   self.pitch.octave = random_range(MIN_OCTAVE, MAX_OCTAVE)
   if n == 1 then 
      self:in_1_bang()
   end
end
