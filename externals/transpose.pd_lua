local patch = pd.Class:new():register("transpose")

function patch:initialize(sel, atoms)
   self.inlets = 2
   self.mode = "class"

   self.pitch = Pitch:new()
   self.interval = Interval:new()
   return true
end