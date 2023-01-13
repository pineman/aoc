package main

import (
	"fmt"

	"github.com/pineman/aoc2022"
)

func isVisibleFromLeft(trees [][]int, row int, col int) bool {
	for i := 0; i < col; i++ {
		if trees[row][i] >= trees[row][col] {
			return false
		}
	}
	return true
}

func isVisibleFromRight(trees [][]int, row int, col int) bool {
	for i := len(trees[0]) - 1; i > col; i-- {
		if trees[row][i] >= trees[row][col] {
			return false
		}
	}
	return true
}

func isVisibleFromTop(trees [][]int, row int, col int) bool {
	for i := 0; i < row; i++ {
		if trees[i][col] >= trees[row][col] {
			return false
		}
	}
	return true
}
func isVisibleFromBottom(trees [][]int, row int, col int) bool {
	for i := len(trees) - 1; i > row; i-- {
		if trees[i][col] >= trees[row][col] {
			return false
		}
	}
	return true
}

func isVisible(trees [][]int, row int, col int) bool {
	return isVisibleFromLeft(trees, row, col) || isVisibleFromRight(trees, row, col) || isVisibleFromTop(trees, row, col) || isVisibleFromBottom(trees, row, col)
}

func parseInput(input []string) ([][]int, int, int) {
	rows := len(input)
	cols := len(input[0])
	trees := make([][]int, rows)
	for i := 0; i < rows; i++ {
		trees[i] = make([]int, cols)
	}
	for i := 0; i < rows; i++ {
		for j, ch := range input[i] {
			trees[i][j] = int(ch - '0')
		}
	}
	return trees, rows, cols
}

func partOne(input []string) int {
	trees, rows, cols := parseInput(input)
	r := 0
	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if isVisible(trees, i, j) {
				r++
			}
		}
	}
	return r
}

func viewFromLeft(trees [][]int, row int, col int) int {
	if col == 0 {
		return 0
	}
	v := 0
	for i := col - 1; i >= 0; i-- {
		v++
		if trees[row][i] >= trees[row][col] {
			break
		}
	}
	return v
}

func viewFromRight(trees [][]int, row int, col int) int {
	if col == len(trees[0])-1 {
		return 0
	}
	v := 0
	for i := col + 1; i < len(trees[0]); i++ {
		v++
		if trees[row][i] >= trees[row][col] {
			break
		}
	}
	return v
}

func viewFromTop(trees [][]int, row int, col int) int {
	if row == 0 {
		return 0
	}
	v := 0
	for i := row - 1; i >= 0; i-- {
		v++
		if trees[i][col] >= trees[row][col] {
			break
		}
	}
	return v
}

func viewFromBottom(trees [][]int, row int, col int) int {
	if row == len(trees[0])-1 {
		return 0
	}
	v := 0
	for i := row + 1; i < len(trees); i++ {
		v++
		if trees[i][col] >= trees[row][col] {
			break
		}
	}
	return v
}

func scenicScore(trees [][]int, row int, col int) int {
	return viewFromLeft(trees, row, col) * viewFromRight(trees, row, col) * viewFromTop(trees, row, col) * viewFromBottom(trees, row, col)
}

func partTwo(input []string) int {
	trees, rows, cols := parseInput(input)
	var scores []int
	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			scores = append(scores, scenicScore(trees, i, j))
		}
	}
	max := 0
	for _, v := range scores {
		if v > max {
			max = v
		}
	}
	return max
}

func main() {
	// TODO: rewrite using slices, more range, and 4x memory by storing copies of
	// the map (matrix) transposed, mirrored, and mirrored transposed.
	// To turn this O(n^3) to O(n^2) trade cpu for memory and store a monotonic
	// stack with indices to each tree height observed in a row/col (2x for each
	// direction). Use these stacks to calculate distance and visibility - O(1)
	// for each tree, so O(n^2) overall.
	input := aoc2022.GetInput(8)
	fmt.Println(partOne(input))
	fmt.Println(partTwo(input))
	input = aoc2022.GetBigBoyInput(8)
	fmt.Println(partOne(input))
	fmt.Println(partTwo(input))
}
