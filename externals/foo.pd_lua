-- Read https://agraef.github.io/pd-lua/tutorial/pd-lua-intro.html

local foo = pd.Class:new():register("foo")

function foo:initialize(sel, atoms)
   self.inlets = 1
   self.outlets = 1
   return true
end