$dir = 'C:\users\Jono-work\Git\personal\tictactoe\pshell'
Set-Location $dir
".\Player.ps1"

class Game {
    [hashtable] $board
    [bool] $gameIsOver
    [int] $turncount
    [Player] $player1
    [Player] $player2
    
    Game ($player1,$player2) { 
        write-host "New Game Constructor Called"
        $this.player1 = $player1
        $this.player2 = $player2
    }
    [string] toString() {
        return "I am a game"
    }
    [void] addBoardToGame () {
        $boardsize = 3
        write-host "adding board of size $boardsize"
        $gameboard = @{}
        #TODO: change $gamerow to a meaningful variable name
        for ($gamerow=0; $gamerow -lt $boardsize; $gamerow += 1) {
            $rowstring = " "*$boardsize
            $thisrow = $rowstring.ToCharArray()
            $thisrow.Count
            $gameboard[$gamerow] = $thisrow
        }
        $this.board = $gameboard
    }
    [void] printBoard () {
        for ($count=0;$count -lt $this.board.Count;$count+=1) {
            #TODO: add number markers
            
            write-host "$($this.board[$count] -join " | ")"
            if ($count -ne ($this.board.count-1)) {
                write-host "========="
            }
        }
    }
    [bool] checkRowForWin ([array]$checkRow) {
        [char]$mostRecentSpace = $null
        $thisplayercount = 0
        $rowMeetsVictoryCondition = $false
        foreach ($space in $checkRow) {
            if ($space -ne ' ') {
                if ($thisplayercount -eq 0) {
                    $mostRecentSpace = $space
                    $thisplayercount += 1
                } else {
                    if ($mostRecentSpace -eq $space) {
                        $thisplayercount += 1
                        if ($thisplayercount -eq 3) {
                            $rowMeetsVictoryCondition = $true
                        }
                    } else {
                        $mostRecentSpace = $space
                        $thisplayercount = 1
                    }
                }
            }
        }
        return $rowMeetsVictoryCondition
    }
    [void] checkGameWin () {
        do {
            #check each row
            foreach ($row in $this.board) {
                $this.gameIsOver = checkrowforwin($row)
            }
            #check diags
            $diagonalrows = @{}
            $diagonalrows[0] = @($this.board[0][0],$this.board[1][1],$this.board[2][2])
            $diagonalrows[1] = @($this.board[2][0],$this.board[1][1],$this.board[0][2])
            foreach ($row in $diagonalrows) {
                $this.gameIsOver = checkrowforwin($row)
            }
            #check each column
            $columns = @{}
            #TODO: make this scalable and not hardcoded
            for ($columncount = 0; $columncount -lt $this.board.count; $columncount +=1) {
                $columns[$columncount] = @($this.board[0][$columncount],$this.board[1][$columncount],$this.board[2][$columncount])
            }
            foreach ($row in $columns) {
                $this.gameIsOver = checkrowforwin($row)
            }
        } until ($this.over = $true)
    }
    [void] takeTurn ($playboard,$player) {
        $this.printBoard()
        $success = $false
        do {
            $playerinput = ""
            do {
                $playerinput = read-host "$($player.name) it is your turn. Input coordinates in the form of YX. 00 is the top left corner"
            } until ($playerinput -match "\d\d")
            $ycoord = $playerinput[0]
            $xcoord = $playerinput[1]
            $success = $player.playTurn($this.board,$ycoord,$xcoord)

        } until ($success -eq $true)
    }
}