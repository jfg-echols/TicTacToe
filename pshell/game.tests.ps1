$dir = 'C:\users\Jono-work\Git\personal\tictactoe\pshell\classes'
set-location $dir
. "$dir\Game.ps1"
# Invoke-Pester "$dir\tictactoe.ps1"


Describe 'Basic Tests'{
    it 'game class file should exist' {
        "$dir\game.ps1" | Should -Exist
    }
    Context 'Making the Classes' {
        $newGame = [Game]::new()
        # Mock New-Object {$newGame}
        it 'Testing if we created a game object' {
            $newGame | should -be $true
        }
    }
    Context 'Testing functions' {
        Context 'Functions for Ganme' {
            $newGame = [Game]::new()
            $testboard = @{}
            $testrow = @($null,$null,$null)
            $testboard[0] = $testrow
            $testboard[1] = $testrow
            $testboard[2] = $testrow
            $newGame.board = $testboard
            


        }

    }



}