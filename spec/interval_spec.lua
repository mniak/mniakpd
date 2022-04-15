require "busted.runner"()
require "interval"

describe("Constructor", function()
   int = Interval:new()

   assert.are.equal(Interval.SIZE_UNISON, int.size)
   assert.are.equal(1, int.size)

   assert.are.equal(Interval.QUALITY_PERFECT, int.quality)
   assert.are.equal(0, int.quality)

   assert.are.equal(Interval.DIRECTION_ASCENDING, int.direction)
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
      assert.are.equal(Interval.SIZE_UNISON, newInt.size)
   end)
   describe("Should always be in the first octave", function()
      for s = 2, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(2, newInt.size)
         assert.are.equal(Interval.SIZE_SECOND, newInt.size)
      end
      for s = 3, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(3, newInt.size)
         assert.are.equal(Interval.SIZE_THIRD, newInt.size)
      end
      for s = 4, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(4, newInt.size)
         assert.are.equal(Interval.SIZE_FOURTH, newInt.size)
      end
      for s = 5, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(5, newInt.size)
         assert.are.equal(Interval.SIZE_FIFTH, newInt.size)
      end
      for s = 6, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(6, newInt.size)
         assert.are.equal(Interval.SIZE_SIXTH, newInt.size)
      end
      for s = 7, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(7, newInt.size)
         assert.are.equal(Interval.SIZE_SEVENTH, newInt.size)
      end
      for s = 8, 127, 7 do
         int = Interval:new()
         int.size = s
         newInt = int.normalize()
         assert.are.equal(8, newInt.size)
         assert.are.equal(Interval.SIZE_OCTAVE, newInt.size)
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

   describe("Unison should become octave and vice-versa", function ()
      A = 1
      B = 8

      a = Interval:new()
      a.size = A
      assert.are.equal(B, a.invert().size)
      b = Interval:new()
      b.size = B
      assert.are.equal(A, b.invert().size)
   end)
   describe("Second should become seventh and vice-versa", function ()
      A = 2
      B = 7

      a = Interval:new()
      a.size = A
      assert.are.equal(B, a.invert().size)
      b = Interval:new()
      b.size = B
      assert.are.equal(A, b.invert().size)
   end)
   describe("Third should become Sixth and vice-versa", function ()
      A = 3
      B = 6

      a = Interval:new()
      a.size = A
      assert.are.equal(B, a.invert().size)
      b = Interval:new()
      b.size = B
      assert.are.equal(A, b.invert().size)
   end)
   describe("Fourth should become fifth and vice-versa", function ()
      A = 4
      B = 5

      a = Interval:new()
      a.size = A
      assert.are.equal(B, a.invert().size)
      b = Interval:new()
      b.size = B
      assert.are.equal(A, b.invert().size)
   end)
end)

describe("Parse", function()
   describe("Perfect intervals", function()
      for _, s in pairs({1, 4, 5, 8, 11, 12, 15}) do
         text = "P" .. s
         int = Interval:parse(text)

         assert.are.equal(text, int.name())
         assert.are.equal(s, int.size)
         assert.are.equal(Interval.QUALITY_PERFECT, int.quality)
         assert.are.equal(Interval.DIRECTION_ASCENDING, int.direction)
      end
   end)
end)
