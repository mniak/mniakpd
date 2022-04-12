require "libs"

local patch = pd.Class:new():register("name")

function patch:initialize(sel, atoms)
   self.inlets = 1
   self.outlets = 1
   -- self["in_1_pitch-class"] = self.in_1_pitch_class
   return true
end

function patch:in_1_pitch_class(pitchclass)
   pc = PitchClass:new()
   pc.step = pitchclass[1]
   pc.alteration = pitchclass[2]
   self:outlet(1, "symbol", {pc.name()})
end

function patch:in_1_pitch(pitch)
   p = Pitch:new()
   p.step = pitch[1]
   p.alteration = pitch[2]
   p.octave = pitch[3]
   self:outlet(1, "symbol", {p.name()})
end
