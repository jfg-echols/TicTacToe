package main

import (
	"fyne.io/fyne"
	"fyne.io/fyne/app"
	"fyne.io/fyne/widget"
)

func loadUI() {
	tictactoe := app.New()

	masterWindow := tictactoe.NewWindow("Tic Tac Toe")
	masterWindow.SetContent(widget.NewVBox(

		widget.NewLabelWithStyle("Tic Tac Toe", 1, fyne.TextStyle{Bold: true, Monospace: true}),
		widget.NewButton("Quit", func() { tictactoe.Quit() }),
	))
	masterWindow.ShowAndRun()

}
