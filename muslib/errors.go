package muslib

type errType string

func (e errType) Error() string {
	return string(e)
}

const (
	ErrInvalidStep       errType = "invalid step"
	ErrInvalidAlteration errType = "invalid alteration"
)

// type _Error struct {
// 	errType errType
// 	message string
// }

// func (e _Error) Is(target error) bool {
// 	return target == fs.ErrExist
// }

// func (e _Error) Error() string {
// 	return e.message
// }

// func newError(t errType, msg string) error {
// 	return _Error{
// 		errType: t,
// 		message: msg,
// 	}
// }

// func InvalidStep() error {
// 	return newError(ErrInvalidStep, "invalid step")
// }
