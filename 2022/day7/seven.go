package main

import (
	"fmt"
	"sort"
	"strings"

	aoc2022 "github.com/pineman/aoc2022"
)

type dir struct {
	name   string
	parent *dir
	size   int
	dirs   map[string]*dir
}

// func tree(dir dir, level int) {
// 	fmt.Printf("%s %s %d\n", strings.Repeat("\t", level), dir.name, dir.size)
// 	for _, v := range dir.dirs {
// 		tree(*v, level+1)
// 	}
// 	if level == 0 {
// 		fmt.Printf("%s\n", strings.Repeat("=", 60))
// 	}
// }

func updateFileSizes(dir *dir, fileSize int) {
	current := dir
	for current != nil {
		current.size += fileSize
		current = current.parent
	}
}

func buildTree(input []string) dir {
	root := dir{name: "root", parent: nil, dirs: make(map[string]*dir)}
	current := &root
	input = input[1:]
	for _, v := range input {
		if v == "$ ls" {
			continue
		} else if strings.HasPrefix(v, "$ cd") {
			var dirName string
			fmt.Sscanf(v, "$ cd %s", &dirName)
			if dirName == ".." {
				current = current.parent
			} else {
				current = current.dirs[dirName]
			}
		} else if strings.HasPrefix(v, "dir") {
			var dirName string
			fmt.Sscanf(v, "dir %s", &dirName)
			current.dirs[dirName] = &dir{name: dirName, parent: current, dirs: make(map[string]*dir)}
		} else {
			fileSize, fileName := 0, ""
			fmt.Sscanf(v, "%d %s", &fileSize, &fileName)
			updateFileSizes(current, fileSize)
		}
	}
	return root
}

func getSizes(d dir) []int {
	sizes := []int{d.size}
	for _, dd := range d.dirs {
		sizes = append(sizes, getSizes(*dd)...)
	}
	return sizes
}

func partOne(input []string) int {
	root := buildTree(input)
	sizes := getSizes(root)
	t := 0
	for _, v := range sizes {
		if v <= 100000 {
			t += v
		}
	}
	return t
}

func partTwo(input []string, disk int, needUnused int) int {
	root := buildTree(input)
	sizes := getSizes(root)
	sort.Ints(sizes)
	for _, v := range sizes {
		if disk-root.size+v >= needUnused {
			return v
		}
	}
	return 0
}

func main() {
	input := aoc2022.GetInput(7)
	fmt.Println(partOne(input))
	fmt.Println(partTwo(input, 70e6, 30e6))
	input = aoc2022.GetBigBoyInput(7)
	fmt.Println(partOne(input))
	fmt.Println(partTwo(input, 3e9, 700e6))
}
