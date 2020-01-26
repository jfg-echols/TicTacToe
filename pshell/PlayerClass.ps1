class Player {
    [string] $playerName
    [char] $playerIcon
    [bool] $isHuman
    
    Player ($name,$icon) {
        $this.playerName = $name
        $this.playerIcon = $icon
    }
    [bool] playTurn ($board,$ycoord,$xcoord) {
        write-host "testing inputs"
        write-host $board
        write-host $ycoord
        write-host $xcoord
        if (!$board) {"board is null"} else {"board is not null"}
        <#
        if ($board[$ycoord][$xcoord] -eq ' ') {
            $board[$ycoord][$xcoord] = $this.playerIcon
            return $true
        } else {
            return $false
        }#>
    }
}