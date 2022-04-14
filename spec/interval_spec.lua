require "busted.runner"()
require "interval"

describe("Constructor", function()
   int = Interval:new()

   assert.are.equal(Interval.UNISON, int.size)
   assert.are.equal(1, int.size)

   assert.are.equal(Interval.PERFECT, int.quality)
   assert.are.equal(0, int.quality)

   assert.are.equal(Interval.ASCENDING, int.direction)
   assert.are.equal(1, int.direction)
end)

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
         assert.are.equal(Interval.UNISON, newInt.size)
      end)
      describe("Should always be in the first octave", function()
         for s = 2, 127, 7 do
            int = Interval:new()
            int.size = s
            newInt = int.normalize()
            assert.are.equal(2, newInt.size)
            assert.are.equal(Interval.SECOND, newInt.size)
         end
         for s = 3, 127, 7 do
            int = Interval:new()
            int.size = s
            newInt = int.normalize()
            assert.are.equal(3, newInt.size)
            assert.are.equal(Interval.THIRD, newInt.size)
         end
         for s = 4, 127, 7 do
            int = Interval:new()
            int.size = s
            newInt = int.normalize()
            assert.are.equal(4, newInt.size)
            assert.are.equal(Interval.FOURTH, newInt.size)
         end
         for s = 5, 127, 7 do
            int = Interval:new()
            int.size = s
            newInt = int.normalize()
            assert.are.equal(5, newInt.size)
            assert.are.equal(Interval.FIFTH, newInt.size)
         end
         for s = 6, 127, 7 do
            int = Interval:new()
            int.size = s
            newInt = int.normalize()
            assert.are.equal(6, newInt.size)
            assert.are.equal(Interval.SIXTH, newInt.size)
         end
         for s = 7, 127, 7 do
            int = Interval:new()
            int.size = s
            newInt = int.normalize()
            assert.are.equal(7, newInt.size)
            assert.are.equal(Interval.SEVENTH, newInt.size)
         end
         for s = 8, 127, 7 do
            int = Interval:new()
            int.size = s
            newInt = int.normalize()
            assert.are.equal(8, newInt.size)
            assert.are.equal(Interval.OCTAVE, newInt.size)
         end
      end)
   end)

   describe("Inversion", function()
      describe("two times should result in normalization", function()
         for s = 1, 127 do
            int = Interval:new()
            int.size = s
            doubleInverted = int.invert().invert()
            normalized = int.normalize()
            assert.are.equal(normalized.size, doubleInverted.size)
            assert.are.equal(normalized.quality, doubleInverted.quality)
            assert.are.equal(normalized.direction, doubleInverted.direction)
         end
      end)

   describe("size and direction should never should remain the same", function()
      for _, d in pairs({1, -1}) do
         for s = 1, 127 do
            int = Interval:new()
            int.size = s
            int.direction = d

            inverted = int.invert()
            assert.are_not.equal(int.size, inverted.size)
            assert.are_not.equal(int.direction, inverted.direction)
         end
      end
   end)
end)
