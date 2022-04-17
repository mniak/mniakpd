package muslib

type Alteration int

const (
	AlterationDoubleFlat  = -2
	AlterationFlat        = -1
	AlterationNatural     = 0
	AlterationSharp       = 1
	AlterationDoubleSharp = 2
)

func Alterations() []Alteration {
	return []Alteration{}
}
