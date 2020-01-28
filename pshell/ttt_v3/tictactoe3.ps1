
function newBoard ($gamesize,$blankIcon) {
    # write-host -f cyan $gamesize
    $newGameBoard = @()
    for ($i = 0; $i -lt $gamesize; $i += 1) {
        $row = $blankIcon*$boardsize
        $newGameBoard += $row
    }
    # write-host $thisGameBoard
    return $newGameBoard
}
function printBoard ($board) {
    $gamesize = $board.length
    # if ($board) {
    #     write-host "isboard"
    # }
    # write-host -f green "printing"
    # write-host $board.Length
    # write-host $gamesize
    for ($i = 0; $i -lt $gamesize; $i += 1) {
        # write-host -f Yellow $i
        #TODO - add numbers to columns
        $thisrowtoprint = $board[$i].ToCharArray()
        # write-host $thisrowtoprint.GetType()
        $thisrowtoprint = $thisrowtoprint -join ' | '
        # write-host $thisrowtoprint
        $horizontalrow = "+"*3*$gamesize
        Write-Host $thisrowtoprint
        if ($i -ne ($gamesize-1)) {
            write-host $horizontalrow
        }
    }
}

function updateGameboard ($board,$movestring,$icon) {
    $theirrow = $movestring[0].tostring()
    $theircol = $movestring[1].tostring()
    $rowToUpdate = $board[$theirrow].ToCharArray()
    $rowToUpdate[$theircol] = $theiricon
    $updatedrow = $rowToUpdate -join ''
    $board[$theirrow] = $updatedrow
    return $board
}

function checkwinner ($board,$blankspace) {
    $rowstocheck = @()
    ##horizontal
    foreach ($row in $board) {
        $rowstocheck+=$row
    }
    #vertical
    for ($y=0;$y -lt $board.Length; $y+=1) {
        $coltocheck = @()
        for ($x=0;$x -lt $board.Length; $x+=1) {
            $coltocheck += $board[$x][$y]
        }
        $rowstocheck += $coltocheck -join ""
    }
    #diagonal slash
    $slash = @()
    for ($y=0;$y -lt $board.Length; $y+=1) { 
        $slash += $board[$y][$y]
    }
    $rowstocheck += $slash -join ""
    #diagonal backslash
    $backslash = @() 
    for ($i=0;$i -lt $checkingboard.Length; $i+=1) { 
        $ycoord = ($checkingboard.length -1) - $i
        $xcoord = $i
        $backslash += $checkingboard[$ycoord][$xcoord]
    }
    $rowstocheck += $backslash -join ''
    ##validate
    foreach ($row in $rowstocheck) {
        $fullrow = $row -replace ($blankspace,'')
        if ($fullrow.tochararray().Count -eq 3) {
            if (($fullrow.ToCharArray() | get-Unique).count -eq 1) {
                return $true
            }
        }
    }
    return $false
}

$gamesize = 3
$blankspace = "-"

$thisGameBoard = newBoard $gamesize $blankspace
printBoard $thisGameBoard
# $thisGameBoard

for ($i=0;$i-le 8;$i+=1) {
    do {
        do {
            $input = read-host "enter your YX coordinates for your move"
            #temp until
        } until ($input -match "[0-2][0-2]")
        cls    
        if ($i%2 -eq 0) {
            $theiricon = "X"
        } else {
            $theiricon = "O"
        }
        $thisGameBoard = updateGameboard $thisGameBoard $input $theiricon
        printBoard $thisGameBoard

    } until ((checkwinner $thisGameBoard) -or ($i -eq 8))
}