local patch = pd.Class:new():register("tmpl")

function patch:initialize(sel, atoms)
   self.inlets = 2
   self.outlets = 1
   self.template = atoms
   self.head = "bang"
   self.tail = {}
  return true
end

function patch:in_1_bang()
   self:outlet(1, self.head, self.tail)
end

function patch:in_n(n, sel, atoms)
   result = {}
   for _, value in pairs(self.template) do
      if value == "$" then
         result[#result + 1] = sel
         for _, v in pairs(atoms) do
            result[#result + 1] = v
         end
      else
         result[#result + 1] = value
      end 
   end
   self.head = table.remove(result, 1)
   self.tail = result
   self:in_1_bang()
end