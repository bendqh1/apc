# GitHub repository
$repoUrl = "https://github.com/bendqh1/apc"

# Create a unique temporary folder
$apc_temp_repo_path = Join-Path $env:TEMP "apc-$([guid]::NewGuid())"

try {
    # Download the repository
    git clone --depth 1 $repoUrl $apc_temp_repo_path

    # Run apc.ps1 from the downloaded repository
    & (Join-Path $apc_temp_repo_path "apc.ps1")
}
finally {
    # Delete the downloaded repository
    Remove-Item $apc_temp_repo_path -Recurse -Force -ErrorAction SilentlyContinue
}
