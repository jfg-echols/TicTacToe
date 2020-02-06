package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

var blankChar = "-"

func main() {

	fmt.Println("Welcome to Tic Tac Toe")
	thisGame := game{length: 3, width: 3}
	thisGame = thisGame.newboard()
	fmt.Println(thisGame.board)

	thisPlayer := "X"
	for i := 0; i < 9; i++ {
		thisGame.printGame()

		for {
			fmt.Print("Player " + thisPlayer + " what move would you like to make? (Y/X)-> ")
			reader := bufio.NewReader(os.Stdin)
			input, _ := reader.ReadString('\n')
			input = strings.Replace(input, "\n", "", 2)
			//this is hacky - not sure why it's appending more onto here
			input = input[:2]
			isvalid := validatePlayerInput(thisGame, input)
			if isvalid == true {
				yval, err0 := strconv.Atoi(string(input[0]))
				if err0 != nil {
					fmt.Println("error")
					fmt.Println(err0)
					os.Exit(1)
				}
				xval, err1 := strconv.Atoi(string(input[1]))
				if err1 != nil {
					fmt.Println("error")
					fmt.Println(err1)
					os.Exit(1)
				}
				setBoardValue(thisGame, yval, xval, thisPlayer)
				winner := thisGame.checkWin()
				if winner == true {
					fmt.Println("Congratulations Player " + thisPlayer + " You WIN")
					os.Exit(0)
				}
				break
			}
		}
		if thisPlayer == "X" {
			thisPlayer = "O"
		} else if thisPlayer == "O" {
			thisPlayer = "X"
		}
		fmt.Println("EVERBODY LOSES")
	}

}
