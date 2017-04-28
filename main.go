package main // import "github.com/fabriziopandini/pause"

import (
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	// Set up channel on which to send signal notifications.
	// We must use a buffered channel or risk missing the signal
	// if we're not ready to receive when the signal is sent.
	c := make(chan os.Signal, 1)
	signal.Notify(c, syscall.SIGINT, syscall.SIGTERM, syscall.SIGKILL)

	// Block until a signal is received.
	fmt.Println("Waiting for signals...")
	s := <-c
	fmt.Println("Got signal:", s)
	if s == syscall.SIGKILL {
		log.Fatal("SIGKILL!!!")
	}
}
