package main

import (
	"testing"

	"github.com/pineman/aoc2022"
)

var example = []string{"30373", "25512", "65332", "33549", "35390"}

func first[T, U, V any](val T, _ U, _ V) T {
	return val
}

var parsedExample = first(parseInput(example))

func Test_partOne(t *testing.T) {
	type args struct {
		input []string
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"", args{example}, 21},
		{"", args{aoc2022.GetInput(8)}, 1870},
		{"", args{aoc2022.GetBigBoyInput(8)}, 116882},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := partOne(tt.args.input); got != tt.want {
				t.Errorf("partOne() = %v, want %v", got, tt.want)
			}
		})
	}
}

func Test_partTwo(t *testing.T) {
	type args struct {
		input []string
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"", args{example}, 8},
		{"", args{aoc2022.GetInput(8)}, 517440},
		{"", args{aoc2022.GetBigBoyInput(8)}, 6852600},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := partTwo(tt.args.input); got != tt.want {
				t.Errorf("partTwo() = %v, want %v", got, tt.want)
			}
		})
	}
}

func Test_scenicScore(t *testing.T) {
	type args struct {
		trees [][]int
		row   int
		col   int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"", args{parsedExample, 1, 2}, 4},
		{"", args{parsedExample, 3, 2}, 8},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := scenicScore(tt.args.trees, tt.args.row, tt.args.col); got != tt.want {
				t.Errorf("viewingDistance() = %v, want %v", got, tt.want)
			}
		})
	}
}

func Test_viewFromTop(t *testing.T) {
	type args struct {
		trees [][]int
		row   int
		col   int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"", args{parsedExample, 1, 2}, 1},
		{"", args{parsedExample, 3, 2}, 2},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := viewFromTop(tt.args.trees, tt.args.row, tt.args.col); got != tt.want {
				t.Errorf("viewFromTop() = %v, want %v", got, tt.want)
			}
		})
	}
}

func Test_viewFromLeft(t *testing.T) {
	type args struct {
		trees [][]int
		row   int
		col   int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"", args{parsedExample, 1, 2}, 1},
		{"", args{parsedExample, 3, 2}, 2},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := viewFromLeft(tt.args.trees, tt.args.row, tt.args.col); got != tt.want {
				t.Errorf("viewFromLeft() = %v, want %v", got, tt.want)
			}
		})
	}
}

func Test_viewFromBottom(t *testing.T) {
	type args struct {
		trees [][]int
		row   int
		col   int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"", args{parsedExample, 1, 2}, 2},
		{"", args{parsedExample, 3, 2}, 1},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := viewFromBottom(tt.args.trees, tt.args.row, tt.args.col); got != tt.want {
				t.Errorf("viewFromBottom() = %v, want %v", got, tt.want)
			}
		})
	}
}

func Test_viewFromRight(t *testing.T) {
	type args struct {
		trees [][]int
		row   int
		col   int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"", args{parsedExample, 1, 2}, 2},
		{"", args{parsedExample, 3, 2}, 2},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := viewFromRight(tt.args.trees, tt.args.row, tt.args.col); got != tt.want {
				t.Errorf("viewFromRight() = %v, want %v", got, tt.want)
			}
		})
	}
}
