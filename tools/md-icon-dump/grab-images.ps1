$src = "md-icons"
$destination = "md-icons-sorted-2"

Get-ChildItem $src -Filter "*_2x.png" -Recurse | % {
    $typeMatch = [regex]::Match($_.Name, "_(\d+pt)")
    $type = "24pt"

    if ($typeMatch.captures.groups.Count -gt 0) {
        $type = $typeMatch.captures.groups[1].value
    }

    if ($_.Name -match "_white_") {
        $destinationPath = Join-Path -Path $destination -ChildPath $type

        if (-not (Test-Path $destinationPath)) {
            New-Item $destinationPath -Type Directory
        }

        Copy-Item $_.FullName -Destination (Join-Path -Path (Join-Path -Path $destination -ChildPath $type) -ChildPath $_.Name)
    }
}