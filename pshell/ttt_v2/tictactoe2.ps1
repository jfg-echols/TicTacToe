#board stuff
$emptyspace = '-'
function newBoard ($boardsize) {
    $gameBoard = @()
    $row = "$emptyspace"*$boardsize
    for ($i=0;$i -lt $boardsize; $i +=1) {
        $gameBoard += $row
    }
    return $gameBoard
}

function printBoard ($board) {
    for ($i=0; $i -lt $board.length; $i+=1) {
        ##TODO - vertical lines don't scale properly
        $gamerow = ($board[$i].tochararray()) -join " | "
        $printedrow = "[$i] $gamerow"
        write-host $printedrow
        $horizontal = "="*$($board.length*3)
        if ($i -lt $board.length-1) {
            write-host "    $horizontal"
        }
    }
    write-host "  "-NoNewline
    for ($i=0; $i -lt $board.length; $i+=1) {
        write-host " [$i]" -NoNewline
    }
    write-host ""
    
}

function makeMove ($board,$rownum,$colnum,$marker) {
    $rowtochange = $board[$rownum]
    $changingrow = $rowtochange.ToCharArray()
    $changingrow[$colnum] = $marker
    $changedrow = $changingrow -join ''
    $board[$rownum] = $changedrow
    return $board
}
function validateMove ($board,$movestring) {
    #oof
    $furthestright = $board.length-1
    $regex = "[0-$furthestright][0-$furthestright]"
    if ($movestring -notmatch $regex) {
        return $false
    } else {
        $y = $movestring[0].tostring()
        $x = $movestring[1].tostring()
        if ($board[$y][$x] -eq $emptyspace) {
            return $true
        } else {
            return $false
        }
    }
}
function checkWin ($board) {
    $boardsize = $board.length
    $stringstocheck = @()
    #rows
    foreach ($row in $board) {
    $stringstocheck += $row
    }
    #columns
    for ($xcoord = 0; $xcoord -lt $boardsize; $xcoord += 1) {
        $column = @()
        for ($ycoord = 0; $ycoord -lt $boardsize; $ycoord += 1) {
            $column += $board[$ycoord][$xcoord].tostring()
        }
        $stringstocheck += $column -join ''
    }
    #diags
    $slash = ""
    for ($i = 0; $i -lt $boardsize; $i +=1) {
        $slash += $board[$i][$i].tostring()
    }
    $stringstocheck += $slash
    
    $backslash = ""
    for ($i = 0; $i -lt $boardsize; $i +=1) {
        #write-host -f green "$i $"
        $backslash += $board[($boardsize-1)-$i][$i].tostring()
    }
    $stringstocheck += $backslash
    
    foreach ($stringtocheck in $stringstocheck) {
        if ($stringtocheck -notmatch $emptyspace) {
            if ($(($stringtocheck.tochararray() | select -Unique).count) -eq 1) {
                Write-host -ForegroundColor green "We have a winner!!"
                return $true
            }
        }
    }
    return $false
}


#newgame
$thisGameBoard = newBoard 3
$turn = 0
do {
    cls
    printBoard $thisGameBoard
    #TODO - set player marker
    if ($turn%2 -eq 0) {
        $marker = 'X'
    } else {
        $marker = 'O'
    }

    do {
        $move = read-host "Player [$marker]: input YX Coordinates of your move" 
        
    } until (validatemove $thisgameboard $move)

    $thisGameBoard = makeMove $thisGameBoard $move[0].tostring() $move[1].tostring() $marker
    $turn +=1
    $gamewon = checkWin $thisGameBoard

} until ($gamewon -or ($turn -eq 9))
cls
printBoard $thisGameBoard
if ($gamewon) {
    write-host -f green "We have a winner!"
    ""
} else {
    write-host -f yellow "Game Over"
}












