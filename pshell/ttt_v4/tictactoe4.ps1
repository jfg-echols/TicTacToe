function newBoard ($blankspace,$size) {
    
    $board = @()
    $row = $blankspace * $size
    for ($i=0;$i-lt $size; $i+=1){
        $board += $row
    }
    return $board
}

function printBoard ($board) {
    $size = $board.Length
    for ($i=0;$i -lt $size; $i+=1) {
        $row = $board[$i].tochararray()
        $rowstring = $row -join ' | '
        $straightline = "========="
        write-host $rowstring
        if ($i -lt ($size-1)) {
            write-host $straightline
        }
    }
}


function validateplayerinput ($board,$playerinput,$blank) {
    ## convert this to scale on < 3
    # write-host $playerinput.gettype()
    if ($playerinput -match "[0-2][0-2]") {
        # write-host "matches 2 numbers"
        $ycoord = $playerinput[0].ToString()
        $xcoord = $playerinput[1].ToString()
        if ($board[$ycoord][$xcoord] -eq $blank) {
            # write-host "matches empty space"
            return $true
        } else {
            # write-host "not empty"
            return $false
        }
    } else {
        # write-host "NaN"
        return $false
    }
}
function makeMove($board,$icon,$blank) {

    do{
        $playerinput = read-host "input your choice in YX format"
    } until (validateplayerinput $board $playerinput $blank)
    
    
    $ycoord = $playerinput[0].ToString()
    $xcoord = $playerinput[1].ToString()
    
    $rowtoupdate = $board[$ycoord].tochararray()
    $rowtoupdate[$xcoord] = $icon
    $board[$ycoord] = $rowtoupdate -join ''
    return $board

} 

function checkWin ($board) {
    $size = $board.Length
    $rowstocheck = @()
    #all rows
    foreach ($row in $board) {
        $rowstocheck += $row
    }
    #all columns
    for ($x=0;$x -lt $size; $x+=1) {
        $column = @()
        for ($y=0;$y -lt $size; $y+=1) {
            $column += $board[$y][$x]
        }
        $rowstocheck += $column -join ""
    }
    #diags
    $slash = @()
    for ($i=0;$i -lt $size; $i+=1) {
        $slash += $board[$i][$i]
    }
    $rowstocheck += $slash -join ""

    $backslash = @()
    for ($i=0;$i -lt $size; $i+=1) {
        #20 11 02
        $y = ($size-1)-$i
        $x = $i
        $backslash += $board[$y][$x]
    }
    $rowstocheck += $backslash -join ""

    foreach ($row in $rowstocheck) {
        if (($row -replace "-","").length -eq 3) {
            if (($row.ToCharArray() | select -Unique).count -eq 1) {
                return $true
            } 
        } 
    }
    return $false

}



$blank = "-"
$gamesize = 3
$thisGame = newBoard $blank $gamesize
# printBoard $thisGame
$turn = 0
do {
    cls
    if ($turn%2 -eq 0) {
        $marker = "X"
    } else {
        $marker = "O"
    }
    printBoard $thisGame
    $thisGame = makeMove $thisGame $marker $blank
    
    $turn +=1
} until ((checkwin $thisGame) -or ($turn -eq 8))
cls
printboard $thisGame
write-host -f green "Game Over"






# printBoard $thisGame


