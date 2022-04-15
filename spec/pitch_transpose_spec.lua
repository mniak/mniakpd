require "busted.runner"()
require "pitch"
require "interval"

-- describe("Transposing", function()
--    describe("by unison should keep the same pitch", function()
--       octave = Interval:new()
--       octave.size = Interval.SIZE_UNISON
--       octave.quality = Interval.QUALITY_PERFECT
--       octave.direction = Interval.DIRECTION_ASCENDING

--       for a = -2, 2 do
--          for o = 0, 10 do
--             for s = 1, 7 do
--                pitch = Pitch:new()
--                pitch.step = s
--                pitch.alteration = a
--                pitch.octave = o

--                transposed = pitch.transpose(octave)
--                assert.are.equal(s, transposed.step)
--                assert.are.equal(a, transposed.alteration)
--                assert.are.equal(o, transposed.octave)
--             end
--          end
--       end
--    end)

   describe("by octave up should keep the same step and alteration but change octave", function()
      octave = Interval:new()
      octave.size = Interval.SIZE_OCTAVE
      octave.quality = Interval.QUALITY_PERFECT
      octave.direction = Interval.DIRECTION_ASCENDING

      for a = -2, 2 do
         for o = 0, 9 do
            for s = 1, 7 do
               print(a, o, s)
               pitch = Pitch:new()
               pitch.step = s
               pitch.alteration = a
               pitch.octave = o

               transposed = pitch.transpose(octave)
               assert.are.equal(s, transposed.step)
               assert.are.equal(a, transposed.alteration)
               assert.are.equal(o + 1, transposed.octave)
            end
         end
      end
   end)

--    describe("4aug+5dim should also behave as an octave", function()
--       aug_fourth = Interval:new()
--       aug_fourth.size = Interval.SIZE_FOURTH
--       aug_fourth.quality = Interval.QUALITY_AUGMENTED
--       aug_fourth.direction = Interval.DIRECTION_ASCENDING

--       dim_fifth = Interval:new()
--       dim_fifth.size = Interval.SIZE_FIFTH
--       dim_fifth.quality = Interval.QUALITY_DIMINISHED
--       dim_fifth.direction = Interval.DIRECTION_ASCENDING

--       for a = -2, 2 do
--          for o = 0, 9 do
--             for s = 1, 7 do
--                print(s, a, o)
--                pitch = Pitch:new()
--                pitch.step = s
--                pitch.alteration = a
--                pitch.octave = o

--                transposed = pitch.transpose(aug_fourth).transpose(dim_fifth)
--                assert.are.equal(s, transposed.step)
--                assert.are.equal(a, transposed.alteration)
--                assert.are.equal(o + 1, transposed.octave)
--             end
--          end
--       end
--    end)
-- end)
