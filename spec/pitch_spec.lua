require "busted.runner"()
require "pitch"

describe("Basic test", function()
   pitch = Pitch:new()

   describe("Initial values", function()
      assert.are.equal(0, pitch.step)
      assert.are.equal(0, pitch.alteration)
      assert.are.equal(4, pitch.octave)
   end)

   describe("Values should be set normalized", function()

      pitch.step = -2
      assert.are.equal(5, pitch.step)

   end)
end)