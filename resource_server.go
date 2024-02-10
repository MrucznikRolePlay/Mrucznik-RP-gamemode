package main

import (
	"fmt"
	"log"
	"net/http"
)

const PORT = 8100
const HOST = "217.182.79.83"

func main() {
	fs := http.FileServer(http.Dir("./models"))
	http.Handle("/", fs)

	log.Printf("Listening on %s:%d...\n", HOST, PORT)
	err := http.ListenAndServe(fmt.Sprintf("%s:%d", HOST, PORT), nil)
	if err != nil {
		log.Fatal(err)
	}
}
