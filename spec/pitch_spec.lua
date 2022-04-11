require "busted.runner"()
require "pitch"

describe("Basic test", function()
   pitch = Pitch:new()

   describe("Assert initial values from constructor are being set", function()
      assert.are.equal(1, pitch.step)
      assert.are.equal(0, pitch.alteration)
      assert.are.equal(4, pitch.octave)
   end)

end)

describe("Step", function()

   describe("Normal values should work", function()
      pitch = Pitch:new()

      pitch.step = 1
      assert.are.equal(1, pitch.step)

      pitch.step = 2
      assert.are.equal(2, pitch.step)

      pitch.step = 3
      assert.are.equal(3, pitch.step)

      pitch.step = 4
      assert.are.equal(4, pitch.step)

      pitch.step = 5
      assert.are.equal(5, pitch.step)

      pitch.step = 6
      assert.are.equal(6, pitch.step)

      pitch.step = 7
      assert.are.equal(7, pitch.step)
   end)

   describe("Bigger values should be normalized", function()
      pitch = Pitch:new()

      pitch.step = 8
      assert.are.equal(1, pitch.step)

      pitch.step = 9
      assert.are.equal(2, pitch.step)

      pitch.step = 10
      assert.are.equal(3, pitch.step)

      pitch.step = 11
      assert.are.equal(4, pitch.step)

      pitch.step = 12
      assert.are.equal(5, pitch.step)

      pitch.step = 13
      assert.are.equal(6, pitch.step)

      pitch.step = 14
      assert.are.equal(7, pitch.step)

      pitch.step = 15
      assert.are.equal(1, pitch.step)

   end)

   describe("Zero or negative values should do nothing", function()
      pitch = Pitch:new()

      for goodValue = 1, 6 do
         for badValue = -1, -20, -1 do
            pitch.step = goodValue
            pitch.step = badValue
            assert.are.equal(goodValue, pitch.step)
         end
      end

   end)
end)

describe("Alteration", function()

   describe("When value is in range store the same", function()
      pitch = Pitch:new()

      pitch.alteration = -2
      assert.are.equal(-2, pitch.alteration)

      pitch.alteration = -1
      assert.are.equal(-1, pitch.alteration)

      pitch.alteration = 0
      assert.are.equal(0, pitch.alteration)

      pitch.alteration = 1
      assert.are.equal(1, pitch.alteration)

      pitch.alteration = 2
      assert.are.equal(2, pitch.alteration)

   end)

   describe("When value is smaller than limit, keep min value", function()
      pitch = Pitch:new()

      for v = -12, -2 do
         pitch.alteration = 0
         pitch.alteration = v
         assert.are.equal(-2, pitch.alteration)
      end
   end)

   describe("When value is greater than limit, keep max value", function()
      pitch = Pitch:new()

      for v = 2, 12 do
         pitch.alteration = 0
         pitch.alteration = v
         assert.are.equal(2, pitch.alteration)
      end
   end)

end)
