require "busted.runner"()
require "interval"

describe("Getters and setters", function()
   describe("Size", function()
      describe("Values within range", function()
         for s = 1, 8 do
            int = Interval:new()
            int.size = s
            assert.are.equal(s, int.size)
         end
      end)
   end)
end)

describe("Normalization", function()
   describe("Unison should stay unison", function()
      int = Interval:new()
      int.size = 1
      newInt = int.normalize()
      assert.are.equal(1, newInt.size)
   end)
   describe("Should always be in the first octave", function()
      for s = 2, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(2, newInt.size)
      end
      for s = 3, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(3, newInt.size)
      end
      for s = 4, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(4, newInt.size)
      end
      for s = 5, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(5, newInt.size)
      end
      for s = 6, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(6, newInt.size)
      end
      for s = 7, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(7, newInt.size)
      end
      for s = 8, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(8, newInt.size)
      end
   end)
end)
