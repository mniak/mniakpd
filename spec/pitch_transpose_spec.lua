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

--    describe("by octave up should keep the same step and alteration but change octave", function()
--       octave = Interval:new()
--       octave.size = Interval.SIZE_OCTAVE
--       octave.quality = Interval.QUALITY_PERFECT
--       octave.direction = Interval.DIRECTION_ASCENDING

--       for a = -2, 2 do
--          for o = 0, 9 do
--             for s = 1, 7 do
--                pitch = Pitch:new()
--                pitch.step = s
--                pitch.alteration = a
--                pitch.octave = o

--                transposed = pitch.transpose(octave)
--                assert.are.equal(s, transposed.step)
--                assert.are.equal(a, transposed.alteration)
--                assert.are.equal(o + 1, transposed.octave)
--             end
--          end
--       end
--    end)

--    describe("4aug+5dim should also behave as an octave", function()
--       tone = Interval:new()
--       tone.size = Interval.SIZE_FOURTH
--       tone.quality = Interval.QUALITY_AUGMENTED
--       tone.direction = Interval.DIRECTION_ASCENDING

--       semitone = Interval:new()
--       semitone.size = Interval.SIZE_FIFTH
--       semitone.quality = Interval.QUALITY_DIMINISHED
--       semitone.direction = Interval.DIRECTION_ASCENDING

--       for a = -2, 2 do
--          for o = 0, 9 do
--             for s = 1, 7 do
--                pitch = Pitch:new()
--                pitch.step = s
--                pitch.alteration = a
--                pitch.octave = o

--                transposed = pitch.transpose(tone).transpose(semitone)
--                assert.are.equal(s, transposed.step)
--                assert.are.equal(a, transposed.alteration)
--                assert.are.equal(o + 1, transposed.octave)
--             end
--          end
--       end
--    end)

--    describe("5dim+4aug should also behave as an octave", function()
--       tone = Interval:new()
--       tone.size = Interval.SIZE_FOURTH
--       tone.quality = Interval.QUALITY_AUGMENTED
--       tone.direction = Interval.DIRECTION_ASCENDING

--       semitone = Interval:new()
--       semitone.size = Interval.SIZE_FIFTH
--       semitone.quality = Interval.QUALITY_DIMINISHED
--       semitone.direction = Interval.DIRECTION_ASCENDING

--       for a = -2, 2 do
--          for o = 0, 9 do
--             for s = 1, 7 do
--                pitch = Pitch:new()
--                pitch.step = s
--                pitch.alteration = a
--                pitch.octave = o

--                transposed = pitch.transpose(semitone).transpose(tone)
--                assert.are.equal(s, transposed.step)
--                assert.are.equal(a, transposed.alteration)
--                assert.are.equal(o + 1, transposed.octave)
--             end
--          end
--       end
--    end)

--    describe("TTsTTTs should also behave as an octave", function()
--       tone = Interval:new()
--       tone.size = Interval.SIZE_SECOND
--       tone.quality = Interval.QUALITY_MAJOR
--       tone.direction = Interval.DIRECTION_ASCENDING

--       semitone = Interval:new()
--       semitone.size = Interval.SIZE_SECOND
--       semitone.quality = Interval.QUALITY_MINOR
--       semitone.direction = Interval.DIRECTION_ASCENDING

--       for a = -2, 2 do
--          for o = 0, 9 do
--             for s = 1, 7 do
--                pitch = Pitch:new()
--                pitch.step = s
--                pitch.alteration = a
--                pitch.octave = o

--                transposed = pitch.transpose(tone).transpose(tone).transpose(semitone).transpose(tone).transpose(tone)
--                                .transpose(tone).transpose(semitone)

--                assert.are.equal(s, transposed.step)
--                assert.are.equal(a, transposed.alteration)
--                assert.are.equal(o + 1, transposed.octave)
--             end
--          end
--       end
--    end)

describe("Major scales", function()
   scales = {
      ["C4"] = {"C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5"}
   }
   -- for first, scale in pairs(scales) do
   first, scale = "C4", {"C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5"}
   base = Pitch:parse(first)

   describe("incremental", function()
      n1 = base.transpose(Interval:parse("P1"))
      n2 = n1.transpose(Interval:parse("M2"))
      n3 = n2.transpose(Interval:parse("M2"))
      n4 = n2.transpose(Interval:parse("m2"))
      n5 = n4.transpose(Interval:parse("M2"))
      n6 = n5.transpose(Interval:parse("M2"))
      n7 = n6.transpose(Interval:parse("M2"))
      n8 = n7.transpose(Interval:parse("m2"))

      assert.are.equal(scale[1], n1.name())
      assert.are.equal(scale[2], n2.name())
      assert.are.equal(scale[3], n3.name())
      assert.are.equal(scale[4], n4.name())
      assert.are.equal(scale[5], n5.name())
      assert.are.equal(scale[6], n6.name())
      assert.are.equal(scale[7], n7.name())
      assert.are.equal(scale[8], n8.name())
   end)

   describe("from first note", function()
      n1 = base.transpose(Interval:parse("P1"))
      n2 = base.transpose(Interval:parse("M2"))
      n3 = base.transpose(Interval:parse("M3"))
      n4 = base.transpose(Interval:parse("P4"))
      n5 = base.transpose(Interval:parse("P5"))
      n6 = base.transpose(Interval:parse("M6"))
      n7 = base.transpose(Interval:parse("M7"))
      n8 = base.transpose(Interval:parse("P8"))

      assert.are.equal(scale[1], n1.name())
      assert.are.equal(scale[2], n2.name())
      assert.are.equal(scale[3], n3.name())
      assert.are.equal(scale[4], n4.name())
      assert.are.equal(scale[5], n5.name())
      assert.are.equal(scale[6], n6.name())
      assert.are.equal(scale[7], n7.name())
      assert.are.equal(scale[8], n8.name())
   end)
   -- end
end)
-- end)
