local patch = pd.Class:new():register("interval")

function patch:initialize(sel, atoms)
   self.inlets = 2
   self.outlets = 1

   self.steps = 0
   self.alteration = 0

   return true
end

function patch:in_1_bang()
   -- Normalize values
   self.steps = (self.steps -1) % 7 + 1
   self.alteration = math.min(math.max(self.alteration, -2), 1)

   self:outlet(1, "interval", {self.steps, self.alteration})
end

function patch:in_1_float(steps)
   self.steps = steps
   self:in_1_bang()
end

function patch:in_2_float(alteration)
   self.alteration = alteration
end

function patch:in_n_interval(n, interval)
   self.steps = interval[1]
   self.alteration = interval[2]
   if n == 1 then
      self:in_1_bang()
   end
end
