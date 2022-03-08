local patch = pd.Class:new():register("midipitch")

function patch:initialize(sel, atoms)
   self.outlets = 1
   self.inlets = 3

   self.step = 0
   self.alteration = 0
   self.octave = 4

   self["in_n_pitch-class"] = self.in_n_pitch_class
   return true
end

function patch:in_1_bang()
   -- Normalize values
   self.step = self.step % 7
   self.alteration = math.min(math.max(self.alteration, -2), 2)
   self.octave = math.min(math.max(self.octave, 0), 10)

   result = self.step * 2 + self.alteration + self.octave * 12
   if self.step >= 3 then
      result = result - 1
   end
   self:outlet(1, "float", {result})
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
