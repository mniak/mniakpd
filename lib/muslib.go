package main

import "C"

//export generateWord
func generateWord() *C.char {
	return C.CString("Hello [Go] World!")
}

func main() {}
