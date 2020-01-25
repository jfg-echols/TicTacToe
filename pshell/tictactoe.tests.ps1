#PESTER Should documentation https://github.com/pester/Pester/wiki/Should-v3
$dir = 'C:\users\Jono-work\Git\personal\tictactoe\pshell'
set-location $dir
. "$dir\tictactoe.ps1"
# Invoke-Pester "$dir\tictactoe.ps1"

Describe 'Basic Tests'{
    Context 'checking files' {
        it 'tictactoe file should exist' {
            "$dir\tictactoe.ps1" | Should -Exist
        }
    }


}
