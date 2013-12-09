package main

import (
	"log"
	"net/http"
	"os"
	"flag"
	"fmt"
	"time"
)

var port = flag.Int("p", 8080, "port to listen on")
var pause = flag.String("w", "1ms", "time to wait before responding")
var verbose = flag.Bool("v", false, "Be verbose")

type PauseHandler struct {
	fs http.Handler
	pause time.Duration
}

func (this PauseHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	time.Sleep(this.pause)
	if *verbose {
		log.Printf("%s\t%s", r.Method, r.URL)
	}
	this.fs.ServeHTTP(w, r)
}


func main() {
	flag.Parse()
	wait, err := time.ParseDuration(*pause)
	if err != nil {
		log.Fatalf("illegal wait time, %s : %s", *pause, err)
	}
	pwd, err := os.Getwd()
	if err != nil {
		log.Fatalf("unable to retrieve pwd: %s", err)
	}
	
	http.Handle("/", PauseHandler { 
		fs: http.FileServer(http.Dir(pwd)),
		pause: wait,
	})

	log.Printf("Listening on %d", *port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", *port), nil))
}
