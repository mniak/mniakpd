require "busted.runner"()
require "transpose"

describe("Transposing", function()
   describe("by unison should keep the same pitch", function()
      interval = Interval:new()
      interval.size = Interval.SIZE_UNISON
      interval.quality = Interval.QUALITY_PERFECT
      interval.direction = Interval.DIRECTION_ASCENDING

      for a = -2, 2 do
         for o = 0, 10 do
            for s = 1, 7 do
               pitch = Pitch:new()
               pitch.step = s
               pitch.alteration = a
               pitch.octave = o

               transposed = transpose(pitch, interval)
               assert.are.equal(s, transposed.step)
               assert.are.equal(a, transposed.alteration)
               assert.are.equal(o, transposed.octave)
            end
         end
      end
   end)

   describe("by octave up should keep the same step and alteration but change octave", function()
      interval = Interval:new()
      interval.size = Interval.SIZE_OCTAVE
      interval.quality = Interval.QUALITY_PERFECT
      interval.direction = Interval.DIRECTION_ASCENDING

      for a = -2, 2 do
         for o = 0, 9 do
            for s = 1, 7 do
               pitch = Pitch:new()
               pitch.step = s
               pitch.alteration = a
               pitch.octave = o

               transposed = transpose(pitch, interval)
               assert.are.equal(s, transposed.step)
               assert.are.equal(a, transposed.alteration)
               assert.are.equal(o+1, transposed.octave)
            end
         end
      end
   end)
end)
