package main

import "C"

//export generateWord
func generateWord() string {
	return "Hello [Go] World!"
}

func main() {}
