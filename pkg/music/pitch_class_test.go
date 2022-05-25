package music

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestPitchClass(t *testing.T) {
	t.Run("Basic test", func(t *testing.T) {
		var pc PitchClass

		t.Run("Assert initial values from constructor are being set", func(t *testing.T) {
			assert.Equal(t, 1, pc.Step())
			assert.Equal(t, 0, pc.Alteration())
		})
	})

	t.Run("Step", func(t *testing.T) {
		t.Run("Normal values should work", func(t *testing.T) {
			pc, err := NewPitchClass(1, 0)
			require.NoError(t, err)
			assert.Equal(t, 1, pc.Step())

			pc, err = NewPitchClass(2, 0)
			require.NoError(t, err)
			assert.Equal(t, 2, pc.Step())

			pc, err = NewPitchClass(3, 0)
			require.NoError(t, err)
			assert.Equal(t, 3, pc.Step())

			pc, err = NewPitchClass(4, 0)
			require.NoError(t, err)
			assert.Equal(t, 4, pc.Step())

			pc, err = NewPitchClass(5, 0)
			require.NoError(t, err)
			assert.Equal(t, 5, pc.Step())

			pc, err = NewPitchClass(6, 0)
			require.NoError(t, err)
			assert.Equal(t, 6, pc.Step())

			pc, err = NewPitchClass(7, 0)
			require.NoError(t, err)
			assert.Equal(t, 7, pc.Step())
		})

		t.Run("Bigger values should be normalized", func(t *testing.T) {
			pc, err := NewPitchClass(8, 0)
			require.NoError(t, err)
			assert.Equal(t, 1, pc.Step())

			pc, err = NewPitchClass(9, 0)
			require.NoError(t, err)
			assert.Equal(t, 2, pc.Step())

			pc, err = NewPitchClass(10, 0)
			require.NoError(t, err)
			assert.Equal(t, 3, pc.Step())

			pc, err = NewPitchClass(11, 0)
			require.NoError(t, err)
			assert.Equal(t, 4, pc.Step())

			pc, err = NewPitchClass(12, 0)
			require.NoError(t, err)
			assert.Equal(t, 5, pc.Step())

			pc, err = NewPitchClass(13, 0)
			require.NoError(t, err)
			assert.Equal(t, 6, pc.Step())

			pc, err = NewPitchClass(14, 0)
			require.NoError(t, err)
			assert.Equal(t, 7, pc.Step())

			pc, err = NewPitchClass(15, 0)
			require.NoError(t, err)
			assert.Equal(t, 1, pc.Step())
		})

		for _, goodValue := range Steps() {
			for badValue := -1; badValue <= -21; badValue-- {

				pc, err := NewPitchClass(Step(badValue), 0)
				assert.Error(t, err, ErrInvalidStep)
				assert.Equal(t, goodValue, pc.Step())
			}
		}
	})

	t.Run("Alteration", func(t *testing.T) {
		t.Run("When value is in range store the same", func(t *testing.T) {
			pc, err := NewPitchClass(1, -2)
			require.NoError(t, err)
			assert.Equal(t, -2, pc.Alteration())

			pc, err = NewPitchClass(1, -1)
			require.NoError(t, err)
			assert.Equal(t, -1, pc.Alteration())

			pc, err = NewPitchClass(1, 0)
			require.NoError(t, err)
			assert.Equal(t, 0, pc.Alteration())

			pc, err = NewPitchClass(1, 1)
			require.NoError(t, err)
			assert.Equal(t, 1, pc.Alteration())

			pc, err = NewPitchClass(1, 2)
			require.NoError(t, err)
			assert.Equal(t, 2, pc.Alteration())
		})

		t.Run("When value is smaller than limit, keep min value", func(t *testing.T) {
			for v := -12; v <= -2; v++ {
				_, err := NewPitchClass(1, Alteration(v))
				assert.ErrorIs(t, err, ErrInvalidAlteration)
			}
		})

		t.Run("When value is greater than limit, keep max value", func(t *testing.T) {
			for v := 2; v <= 12; v++ {
				_, err := NewPitchClass(1, Alteration(v))
				assert.ErrorIs(t, err, ErrInvalidAlteration)
			}
		})
	})

	t.Run("Random", func(t *testing.T) {
		t.Run("Normal", func(t *testing.T) {
			t.Run("Steps should have a good distribution", func(t *testing.T) {
				steps := make(map[Step]bool)
				for i := 1; i <= 7*5; i++ {
					pc := RandomPitchClass()
					steps[pc.Step()] = true
				}
				for _, i := range Steps() {
					assert.True(t, steps[i])
				}
			})

			t.Run("Alterations should never be double", func(t *testing.T) {
				alterations := make(map[Alteration]bool)
				for i := 1; i <= 5*5; i++ {
					pc := RandomPitchClass()
					alterations[pc.Alteration()] = true
				}
				for i := -1; i <= 1; i++ {
					assert.True(t, alterations[Alteration(i)])
				}
				for _, v := range []int{-2, 2} {
					assert.False(t, alterations[Alteration(v)])
				}
			})
		})
		t.Run("Ext}ed", func(t *testing.T) {
			t.Run("Steps should have a good distribution", func(t *testing.T) {
				steps := make(map[Step]bool)
				for i := 1; i <= 7*5; i++ {
					pc := ExtendedRandomPitchClass()
					steps[pc.Step()] = true
				}
				for _, i := range Steps() {
					assert.True(t, steps[i])
				}
			})

			t.Run("Alterations should have a good distribution", func(t *testing.T) {
				alterations := make(map[Alteration]bool)
				for i := 1; i <= 5*5; i++ {
					pc := ExtendedRandomPitchClass()
					alterations[pc.Alteration()] = true
				}
				for _, i := range Alterations() {
					assert.True(t, alterations[i])
				}
			})
		})
	})

	t.Run("Name", func(t *testing.T) {
		t.Run("Simple", func(t *testing.T) {
			t.Run("Without alterations", func(t *testing.T) {
				names := []string{"C", "D", "E", "F", "G", "A", "B"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, 0)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.String()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 1 flat", func(t *testing.T) {
				names := []string{"Cb", "Db", "Eb", "Fb", "Gb", "Ab", "Bb"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, -1)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.String()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 2 flats", func(t *testing.T) {
				names := []string{"Cbb", "Dbb", "Ebb", "Fbb", "Gbb", "Abb", "Bbb"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, -2)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.String()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 1 sharp", func(t *testing.T) {
				names := []string{"C#", "D#", "E#", "F#", "G#", "A#", "B#"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, 1)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.String()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 2 sharps", func(t *testing.T) {
				names := []string{"C##", "D##", "E##", "F##", "G##", "A##", "B##"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, 2)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.String()
					assert.Equal(t, expected, actual)
				}
			})
		})

		t.Run("Pretty", func(t *testing.T) {
			t.Run("Without alterations", func(t *testing.T) {
				names := []string{"C", "D", "E", "F", "G", "A", "B"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, 0)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.PrettyName()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 1 flat", func(t *testing.T) {
				names := []string{"C♭", "D♭", "E♭", "F♭", "G♭", "A♭", "B♭"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, -1)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.PrettyName()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 2 flats", func(t *testing.T) {
				names := []string{"C𝄫", "D𝄫", "E𝄫", "F𝄫", "G𝄫", "A𝄫", "B𝄫"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, -2)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.PrettyName()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 1 sharp", func(t *testing.T) {
				names := []string{"C♯", "D♯", "E♯", "F♯", "G♯", "A♯", "B♯"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, 1)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.PrettyName()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 2 sharps", func(t *testing.T) {
				names := []string{"C𝄪", "D𝄪", "E𝄪", "F𝄪", "G𝄪", "A𝄪", "B𝄪"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, 2)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.PrettyName()
					assert.Equal(t, expected, actual)
				}
			})
		})

		t.Run("Full", func(t *testing.T) {
			t.Run("Without alterations", func(t *testing.T) {
				names := []string{"C", "D", "E", "F", "G", "A", "B"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, 0)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.FullName()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 1 flat", func(t *testing.T) {
				names := []string{"C flat", "D flat", "E flat", "F flat", "G flat", "A flat", "B flat"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, -1)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.FullName()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 2 flats", func(t *testing.T) {
				names := []string{
					"C double flat", "D double flat", "E double flat", "F double flat", "G double flat", "A double flat",
					"B double flat",
				}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, -2)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.FullName()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 1 sharp", func(t *testing.T) {
				names := []string{"C sharp", "D sharp", "E sharp", "F sharp", "G sharp", "A sharp", "B sharp"}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, 1)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.FullName()
					assert.Equal(t, expected, actual)
				}
			})

			t.Run("With 2 sharps", func(t *testing.T) {
				names := []string{
					"C double sharp", "D double sharp", "E double sharp", "F double sharp", "G double sharp",
					"A double sharp", "B double sharp",
				}
				for _, i := range Steps() {
					pc, err := NewPitchClass(i, 2)
					require.NoError(t, err)
					expected := names[i]
					actual := pc.FullName()
					assert.Equal(t, expected, actual)
				}
			})
		})
	})

	t.Run("Parse", func(t *testing.T) {
		t.Run("Simple name", func(t *testing.T) {
			for ialt, alt := range []string{"bb", "b", "", "#", "##"} {
				for istep, step := range []string{"C", "D", "E", "F", "G", "A", "B"} {
					text := step + alt
					parsed := ParsePitchClass(text)

					assert.Equal(t, istep, parsed.Step())
					assert.Equal(t, ialt-3, parsed.Alteration())
				}
			}
		})

		t.Run("Pretty name", func(t *testing.T) {
			for ialt, alt := range []string{"𝄫", "♭", "", "♯", "𝄪"} {
				for istep, step := range []string{"C", "D", "E", "F", "G", "A", "B"} {
					text := step + alt
					parsed := ParsePitchClass(text)

					assert.Equal(t, istep, parsed.Step())
					assert.Equal(t, ialt-3, parsed.Alteration())
				}
			}
		})
	})
}
