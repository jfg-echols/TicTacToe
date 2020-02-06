package main

import (
	"strings"
	"testing"
)

func TestPrintGame(t *testing.T) {
	testGame := game{
		length: 3,
		width:  3,
		board:  []string{strings.Repeat(blankChar, 3), strings.Repeat(blankChar, 3), strings.Repeat(blankChar, 3)},
	}
	testGame.printGame()
}
func TestValidateInput(t *testing.T) {
	testGame := game{
		length: 3,
		width:  3,
		board:  []string{"XXX", strings.Repeat(blankChar, 3), strings.Repeat(blankChar, 3)},
	}
	testInput := "10"
	testValue := validatePlayerInput(testGame, testInput)
	if testValue == false {
		t.Errorf("value %v expected true, got false", testInput)
	}
	testInput = "00"
	testValue = validatePlayerInput(testGame, testInput)
	if testValue == true {
		t.Errorf("picked non-available space, expected false got true")
	}
	testInput = "11"
	testValue = validatePlayerInput(testGame, testInput)
	if testValue == false {
		t.Errorf("value %v expected true, got false", testInput)
	}
	testInput = "1a"
	testValue = validatePlayerInput(testGame, testInput)
	if testValue == true {
		t.Errorf("value with letters: expected false, got true")
	}
	testInput = "33"
	testValue = validatePlayerInput(testGame, testInput)
	if testValue == true {
		t.Errorf("value %v outside of bounds: expected false, got true", testInput)
	}
	testInput = "111"
	testValue = validatePlayerInput(testGame, testInput)
	if testValue == true {
		t.Errorf("value %v with too many digits: expected false, got true", testInput)
	}

}
func TestGetBoardValue(t *testing.T) {
	testGame := game{
		length: 3,
		width:  3,
		board:  []string{strings.Repeat("X", 3), strings.Repeat(blankChar, 3), strings.Repeat("O", 3)},
	}
	testValue := getBoardValue(testGame, 0, 0)
	if testValue != "X" {
		t.Errorf("Expected X, got %v", testValue)
	}
	testValue = getBoardValue(testGame, 1, 1)
	if testValue != blankChar {
		t.Errorf("Expected blank, got %v", testValue)
	}
	testValue = getBoardValue(testGame, 2, 2)
	if testValue != "O" {
		t.Errorf("Expected O, got %v", testValue)
	}
}
func TestSetBoardValue(t *testing.T) {
	testGame := game{
		length: 3,
		width:  3,
		board:  []string{strings.Repeat(blankChar, 3), strings.Repeat(blankChar, 3), strings.Repeat(blankChar, 3)},
	}
	setBoardValue(testGame, 0, 0, "X")
	// testGame.printGame()
	testResults := getBoardValue(testGame, 0, 0)
	if testResults != "X" {
		t.Errorf("Tried setting value to X but got %v", testResults)
	}
	testResults = getBoardValue(testGame, 0, 1)
	if testResults != blankChar {
		t.Errorf("Tried setting 00 to X expecting 01 to be blank but got %v", testResults)
	}
	testResults = getBoardValue(testGame, 0, 2)
	if testResults != blankChar {
		t.Errorf("Tried setting 00 to X expecting 02 to be blank but got %v", testResults)
	}
	testResults = getBoardValue(testGame, 1, 0)
	if testResults != blankChar {
		t.Errorf("Tried setting 00 to X expecting 10 to be blank but got %v", testResults)
	}
	testResults = getBoardValue(testGame, 2, 0)
	if testResults != blankChar {
		t.Errorf("Tried setting 00 to X expecting 20 to be blank but got %v", testResults)
	}
}
func TestCheckWin(t *testing.T) {
	testGame := game{
		length: 3,
		width:  3,
		board:  []string{strings.Repeat(blankChar, 3), strings.Repeat(blankChar, 3), strings.Repeat(blankChar, 3)},
	}
	test := testGame.checkWin()
	if test == true {
		t.Errorf("Empty Game should not validate as having been won")
	}

	testGame = game{
		length: 3,
		width:  3,
		board:  []string{"XO-", "X-O", "-OX"},
	}
	test = testGame.checkWin()
	if test == true {
		t.Errorf("Game with - blanks should not have a complete row and not be won")
	}

	testGame = game{
		length: 3,
		width:  3,
		board:  []string{"XOO", "OXX", "XOO"},
	}
	test = testGame.checkWin()
	if test == true {
		t.Errorf("stalemate game should not be marked as won")
	}

	testGame = game{
		length: 3,
		width:  3,
		board:  []string{"XXX", "OXX", "XOO"},
	}
	test = testGame.checkWin()
	if test == false {
		t.Errorf("first row should have won")
	}

	testGame = game{
		length: 3,
		width:  3,
		board:  []string{"XOO", "X--", "XOO"},
	}
	test = testGame.checkWin()
	if test == false {
		t.Errorf("first column should have won")
	}

	testGame = game{
		length: 3,
		width:  3,
		board:  []string{"XOO", "XX-", "XOX"},
	}
	test = testGame.checkWin()
	if test == false {
		t.Errorf("Slash Diagonal should have won")
	}

	testGame = game{
		length: 3,
		width:  3,
		board:  []string{"XOO", "XO-", "OOX"},
	}
	test = testGame.checkWin()
	if test == false {
		t.Errorf("Backslash Diagonal should have won")
	}

}
