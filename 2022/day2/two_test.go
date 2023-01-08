package main

import (
	"testing"

	aoc2022 "github.com/pineman/aoc2022"
)

func Test_partOne(t *testing.T) {
	got := partOne(aoc2022.GetInput(2))
	want := 8933
	if got != want {
		t.Errorf("got = %d; want %d", got, want)
	}
}

func Test_partTwo(t *testing.T) {
	got := partTwo(aoc2022.GetInput(2))
	want := 11998
	if got != want {
		t.Errorf("got = %d; want %d", got, want)
	}
}
