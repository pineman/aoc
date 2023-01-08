package main

import (
	"strings"
	"testing"

	aoc2022 "github.com/pineman/aoc2022"
)

func Test_partOne(t *testing.T) {
	type args struct {
		input []string
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"", args{strings.Split(`$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k`, "\n")}, 95437},
		{"", args{aoc2022.GetInput(7)}, 1334506},
		{"", args{aoc2022.GetBigBoyInput(7)}, 2414990429},
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
		disk  int
		need  int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		{"", args{strings.Split(`$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k`, "\n"), 70e6, 30e6}, 24933642},
		{"", args{aoc2022.GetInput(7), 70e6, 30e6}, 7421137},
		{"", args{aoc2022.GetBigBoyInput(7), 3e9, 700e6}, 170301725},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := partTwo(tt.args.input, tt.args.disk, tt.args.need); got != tt.want {
				t.Errorf("partTwo() = %v, want %v", got, tt.want)
			}
		})
	}
}
