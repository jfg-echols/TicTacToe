class Player {
    [string] $playerName
    [char] $playerIcon
    [bool] $isHuman
    
    Player ($name,$icon) {
        $this.playerName = $name
        $this.playerIcon = $icon
    }
    [bool] playTurn ($board,$ycoord,$xcoord) {
        if ($board[$ycoord][$xcoord] -eq ' ') {
            $board[$ycoord][$xcoord] = $this.playerIcon
            return $true
        } else {
            return $false
        }
    }
}