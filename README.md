## References

- [Atonal Glossary](http://elliotthauser.com/openmusictheory/atonalGlossary.html#:~:text=interval%20class%20%E2%80%93%20The%20number%20of,concerned%20only%20with%20pitch%20classes.)
- [Music Theory for the 21st-Century Classroom](https://musictheory.pugetsound.edu/mt21c/MusicTheory.html)

## Objectives

Create a framework of subpatches that would allow building many exercises for self-service study.

The idea is to allow the creationg of "Dynamic Music Practice Text Books".
There are many text books out there, like the famous Bona, Pozzoli and so on.

### Sample exercises
- Generate random single-voice measures and display on the screen. The student should try to play it.
  - Option to choose scale
  - Option to play the notes as midi
  - Option to play the notes as sine waves


- Generate random single chord measures and display on the screen. The student should try to play it (Root, Bass, 3th, 5ths, 7th/8ve, Arpeggio, etc.).
  - Option to choose scale
  - Option to play the notes as midi
  - Option to play the notes as sine waves
  - Option to choose wether to play the entire chord or just the root/bass note


- Play two notes and ask for the interval
  - Option to check the answer choosing from a series of buttons

- Play a root, then many notes and ask for the names.
  - Option to check the answer choosing from a series of buttons
  - 


### Generation 
#### Pitches
- [ ] Random Pitch generator
  - [ ] With constraints (Octave range, scales, diatonic, chromatic)

#### Intervals
- [ ] Random Interval generator
  - [ ] With constraints (3rds, 5ths, Major, Minor)
- [ ] Interval from two Pitches


#### Chords
- [ ] Chord builder (Root Pitch + Intervals)


#### Rythm
- [ ] "Duration"

### Outputs

#### Sine output
- [ ] Play pitch
  - [ ] With duration in seconds
  - [ ] With tempo and duration in beats
- [ ] Play chord
  - [ ] With duration in seconds
  - [ ] With tempo and duration in beats

#### MIDI output
- [ ] Play pitch `[make-sine]`, `[pitch-class C#(`, `[set octave 4(`
  - [ ] With duration in seconds
  - [ ] With tempo and duration in beats
- [ ] Play chord `[make-sine]`, `[chord C#(`, `[set octave 4(`
  - [ ] With duration in seconds
  - [ ] With tempo and duration in beats

#### Text output
- [ ] Pitch name
- [ ] Chord name
- [ ] Big text box

#### Simple displays
- [ ] Single Pitch display
- [ ] Single Chord display
- [ ] Single Note Duration/Rest display

#### Measure displays
- [ ] Rhythm: series of Note/Rests without pitch
  - [ ] Clef
  - [ ] Key signature
- [ ] Melody: series of Notes/Rests with pitch
  - [ ] Clef
  - [ ] Key signature

- [ ] Sheet music: series of "Lines", each one composed of Chords/Rests with pitch
  - [ ] Clef
  - [ ] Key signature

### Exercise tools
- [ ] Note name checker
  - [ ] English name
  - [ ] Italian name
    - [ ] Fixed Do
    - [ ] Movable Do
- [ ] Interval checker
