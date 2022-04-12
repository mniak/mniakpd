require "libs"

local patch = pd.Class:new():register("pitch")

function patch:initialize(sel, atoms)
   if #atoms > 0 and atoms[1] == "class" then
      self.inlets = 2
      self.mode = "class"
   else 
      self.inlets = 3
   end
   self.outlets = 1
   
   self.pitch = Pitch:new()
   self["in_n_pitch-class"] = self.in_n_pitch_class
   return true
end

function patch:in_1_bang()
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
   self.pitch = Pitch:random()
   if n == 1 then 
      self:in_1_bang()
   end
end
