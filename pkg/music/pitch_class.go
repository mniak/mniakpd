package music

type PitchClass struct {
	step       Step
	alteration Alteration
}

func NewPitchClass(step Step, alteration Alteration) (PitchClass, error) {
	return PitchClass{
		step:       step,
		alteration: alteration,
	}, nil
}

func ParsePitchClass(text string) PitchClass {
	return PitchClass{}
}

func RandomPitchClass() PitchClass {
	return PitchClass{}
}

func ExtendedRandomPitchClass() PitchClass {
	return PitchClass{}
}

func (pc PitchClass) Step() Step {
	return pc.step
}

func (pc PitchClass) Alteration() Alteration {
	return pc.alteration
}

func (pc PitchClass) String() string {
	return ""
}

func (pc PitchClass) FullName() string {
	return ""
}

func (pc PitchClass) PrettyName() string {
	return ""
}
