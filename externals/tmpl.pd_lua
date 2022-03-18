local patch = pd.Class:new():register("tmpl")

function patch:initialize(sel, atoms)
   self.outlets = 1
   self.inlets = 1
   self.template = atoms
  return true
end

function patch:in_1(sel, atoms)
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
   head = table.remove(result, 1)
   self:outlet(1, head, result)
end