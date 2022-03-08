local patch = pd.Class:new():register("pitch")

function patch:initialize(sel, atoms)
   self.outlets = 1
   if type(atoms[1]) == "string" and atoms[1] == "class" then
      self.mode = "class"
      self.inlets = 2
   else
      self.mode = "full"
      self.inlets = 3
   end
 
   self.step = 0
   self.alteration = 0
   self.octave = 4

   self["in_1_pitch-class"] = self.in_1_pitch_class
   self["in_2_pitch-class"] = self.in_2_pitch_class

   return true
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

function patch:in_1_bang()
   if self.mode == "class" then
      self:outlet(1, "pitch-class", {self.step, self.alteration})
   else
      self:outlet(1, "pitch", {self.step, self.alteration, self.octave})
   end
end

function patch:in_1_pitch(pitch)
   self:in_2_pitch(pitch)
   self:in_1_bang()
end

function patch:in_1_pitch_class(pitchclass)
   self:in_2_pitch_class(pitchclass)
   self:in_1_bang()
end


function patch:in_2_pitch(pitch)
   self.step = pitch[1]
   self.alteration = pitch[2]
   self.octave = pitch[3]
end

function patch:in_2_pitch_class(pitchclass)
   self.step = pitchclass[1]
   self.alteration = pitchclass[2]
end
