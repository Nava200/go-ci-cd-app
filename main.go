package main

import (
    "fmt"
    "github.com/gorilla/mux"
)

func main() {
    fmt.Println("Hello, World!")
    r := mux.NewRouter()
    fmt.Println(r)
}

