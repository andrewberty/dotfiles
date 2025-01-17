path=(
    /opt/homebrew/opt/trash/bin
    $path
    /Applications/XAMPP/bin
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH
