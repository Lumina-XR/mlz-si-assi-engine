# Update-GitRemotes.ps1
# Fix GitHub remote URLs from Lumina007 to Lumina-XR

$oldUsername = "Lumina007"
$newUsername = "Lumina-XR"

$gitDirs = Get-ChildItem -Recurse -Directory -Force -ErrorAction SilentlyContinue | Where-Object {
    Test-Path "$($_.FullName)\.git"
}

foreach ($dir in $gitDirs) {
    Write-Host "`nProcessing: $($dir.FullName)"
    Set-Location $dir.FullName

    $originUrl = git remote get-url origin 2>$null

    if ($originUrl -and $originUrl -match "github\.com[:/](.+?)/(.+?)(\.git)?$") {
        if ($originUrl -like "*$oldUsername*") {
            $newUrl = $originUrl -replace $oldUsername, $newUsername
            git remote set-url origin $newUrl
            Write-Host "Updated origin: $originUrl --> $newUrl"
        } else {
            Write-Host "No change needed: $originUrl"
        }
    } else {
        Write-Host "No valid GitHub origin found. Skipping..."
    }
}

Write-Host "`nAll repositories checked."
