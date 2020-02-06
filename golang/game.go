package main

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

type game struct {
	length int
	width  int
	board  []string
}

func (g game) newboard() game {
	row := strings.Repeat(blankChar, g.width)
	for i := 0; i < g.length; i++ {
		g.board = append(g.board, row)
	}
	return g
}

func (g game) printGame() {
	horizontal := strings.Repeat("+", 3*len(g.board[0]))
	fmt.Println(horizontal)
	for i := 0; i < len(g.board); i++ {
		fmt.Println(strings.Join(strings.Split(g.board[i], ""), " | "))
		if i != len(g.board)-1 {
			fmt.Println(strings.Repeat("=", 3*len(g.board[0])))
		}
	}
	fmt.Println(horizontal)
}

func validatePlayerInput(g game, input string) bool {

	if len(input) == 2 {
		match, err := regexp.MatchString("([0-2][0-2])", input)
		if err != nil {
			fmt.Println("err:", err)
			return false
		}
		if match {
			yval, err0 := strconv.Atoi(string(input[0]))
			if err0 != nil {
				return false
			}
			xval, err1 := strconv.Atoi(string(input[1]))
			if err1 != nil {
				return false
			}
			if getBoardValue(g, yval, xval) != blankChar {
				return false
			} else {
				return true
			}
		} else {
			return false
		}
	} else {
		// fmt.Println("not 2 length i guess")
		return false
	}
}
func getBoardValue(g game, yval int, xval int) string {
	targetRow := g.board[yval]
	targetVal := string(targetRow[xval])
	return targetVal
}
func setBoardValue(g game, yval int, xval int, newValue string) {
	rowToUpdate := g.board[yval]
	rowAsSlice := strings.Split(rowToUpdate, "")
	rowAsSlice[xval] = newValue
	updatedRow := strings.Join(rowAsSlice, "")
	g.board[yval] = updatedRow
}
func (g game) checkWin() bool {
	rowsToCheck := []string{}
	//rows
	for i := 0; i < len(g.board); i++ {
		rowsToCheck = append(rowsToCheck, g.board[i])
	}
	//cols
	//00 01 02  || 10 11 12 || 20 21 22
	for i := 0; i < len(g.board); i++ {
		// column := []string{}
		column := ""
		for j := 0; j < len(g.board); j++ {
			column = column + getBoardValue(g, j, i)
		}
		// rowsToCheck = append(rowsToCheck, strings.Join(column, ""))
		rowsToCheck = append(rowsToCheck, column)
	}
	//diags
	slash := ""
	for i := 0; i < len(g.board); i++ {
		slash = slash + getBoardValue(g, i, i)
	}
	rowsToCheck = append(rowsToCheck, slash)
	//backslash
	backslash := ""
	for i := 0; i < len(g.board); i++ {
		y := i
		x := (len(g.board) - 1) - i
		backslash = backslash + getBoardValue(g, y, x)
	}
	rowsToCheck = append(rowsToCheck, backslash)
	for _, row := range rowsToCheck {
		check := strings.ReplaceAll(row, blankChar, "")
		if len(check) == 3 {
			if strings.Count(row, "X") == 3 || strings.Count(row, "O") == 3 {
				return true
			}
		}
	}
	return false
}
