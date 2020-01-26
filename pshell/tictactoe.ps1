$dir = 'C:\Users\Jono-work\Git\personal\tictactoe\pshell'
Set-Location $dir

. ".\PlayerClass.ps1"
. ".\GameClass.ps1"



$player1 = [Player]::new("Player1","X")
$player2 = [Player]::new("Player2","O")

$newGame = [Game]::new($player1,$player2)
$newGame.addBoardToGame()

$lastplayer = $null
do {
    $newGame.turncount +=1
    if ($lastplayer -eq $null) {
        $newGame.taketurn($newgame.board,$Player1)
        $lastplayer = $player1
    } elseif ($lastplayer -eq $player1) {
        $newGame.taketurn($newgame.board,$player2)
        $lastplayer = $player2
    } elseif ($lastplayer -eq $player2) {
        $newGame.taketurn($newgame.board,$player1)
        $lastplayer = $player1
    }

} until ($newGame.turncount = 9)