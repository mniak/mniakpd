require "busted.runner"()
require "pitch"
require "interval"

describe("Transposing", function()
   describe("by unison should keep the same pitch", function()
      octave = Interval:new()
      octave.size = Interval.SIZE_UNISON
      octave.quality = Interval.QUALITY_PERFECT
      octave.direction = Interval.DIRECTION_ASCENDING

      for a = -2, 2 do
         for o = 0, 10 do
            for s = 1, 7 do
               pitch = Pitch:new()
               pitch.step = s
               pitch.alteration = a
               pitch.octave = o

               transposed = pitch.transpose(octave)
               assert.are.equal(s, transposed.step)
               assert.are.equal(a, transposed.alteration)
               assert.are.equal(o, transposed.octave)
            end
         end
      end
   end)

   describe("by octave up should keep the same step and alteration but change octave", function()
      octave = Interval:new()
      octave.size = Interval.SIZE_OCTAVE
      octave.quality = Interval.QUALITY_PERFECT
      octave.direction = Interval.DIRECTION_ASCENDING

      for a = -2, 2 do
         for o = 0, 9 do
            for s = 1, 7 do
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

   describe("4aug+5dim should also behave as an octave", function()
      tone = Interval:new()
      tone.size = Interval.SIZE_FOURTH
      tone.quality = Interval.QUALITY_AUGMENTED
      tone.direction = Interval.DIRECTION_ASCENDING

      semitone = Interval:new()
      semitone.size = Interval.SIZE_FIFTH
      semitone.quality = Interval.QUALITY_DIMINISHED
      semitone.direction = Interval.DIRECTION_ASCENDING

      for a = -2, 2 do
         for o = 0, 9 do
            for s = 1, 7 do
               pitch = Pitch:new()
               pitch.step = s
               pitch.alteration = a
               pitch.octave = o

               transposed = pitch.transpose(tone).transpose(semitone)
               assert.are.equal(s, transposed.step)
               assert.are.equal(a, transposed.alteration)
               assert.are.equal(o + 1, transposed.octave)
            end
         end
      end
   end)

   describe("5dim+4aug should also behave as an octave", function()
      tone = Interval:new()
      tone.size = Interval.SIZE_FOURTH
      tone.quality = Interval.QUALITY_AUGMENTED
      tone.direction = Interval.DIRECTION_ASCENDING

      semitone = Interval:new()
      semitone.size = Interval.SIZE_FIFTH
      semitone.quality = Interval.QUALITY_DIMINISHED
      semitone.direction = Interval.DIRECTION_ASCENDING

      for a = -2, 2 do
         for o = 0, 9 do
            for s = 1, 7 do
               pitch = Pitch:new()
               pitch.step = s
               pitch.alteration = a
               pitch.octave = o

               transposed = pitch.transpose(semitone).transpose(tone)
               assert.are.equal(s, transposed.step)
               assert.are.equal(a, transposed.alteration)
               assert.are.equal(o + 1, transposed.octave)
            end
         end
      end
   end)
   
   describe("TTsTTTs should also behave as an octave", function()
      tone = Interval:new()
      tone.size = Interval.SIZE_SECOND
      tone.quality = Interval.QUALITY_MAJOR
      tone.direction = Interval.DIRECTION_ASCENDING

      semitone = Interval:new()
      semitone.size = Interval.SIZE_SECOND
      semitone.quality = Interval.QUALITY_MINOR
      semitone.direction = Interval.DIRECTION_ASCENDING

      for a = -2, 2 do
         for o = 0, 9 do
            for s = 1, 7 do
               pitch = Pitch:new()
               pitch.step = s
               pitch.alteration = a
               pitch.octave = o

               transposed = pitch
                  .transpose(tone)
                  .transpose(tone)
                  .transpose(semitone)
                  .transpose(tone)
                  .transpose(tone)
                  .transpose(tone)
                  .transpose(semitone)
               
               assert.are.equal(s, transposed.step)
               assert.are.equal(a, transposed.alteration)
               assert.are.equal(o + 1, transposed.octave)
            end
         end
      end
   end)
end)
