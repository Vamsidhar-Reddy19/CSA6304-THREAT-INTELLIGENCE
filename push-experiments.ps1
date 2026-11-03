
$experiments = @(
    "exp 1",
    "EXP2", "EXP3", "EXP4", "EXP5",
    "EXP6", "EXP7", "EXP8", "EXP9", "EXP10",
    "EXP11", "EXP12", "EXP13", "EXP14", "EXP15",
    "EXP16", "EXP17", "EXP18", "exp19", "exp20",
    "exp21", "exp22", "exp23", "exp24", "exp25",
    "exp26", "exp27", "exp28", "exp29", "exp30",
    "exp31", "exp32", "exp33", "exp34", "exp35",
    "exp36", "exp37", "exp38", "exp39", "exp40"
)

# Verify all 40 experiment files exist before committing
$missing = @(
    $experiments | Where-Object {
        -not (Test-Path -LiteralPath $_ -PathType Leaf)
    }
)

if ($missing.Count -gt 0) {
    Write-Host "Missing files:" -ForegroundColor Red
    $missing
    throw "Fix missing files before proceeding."
}

# Create 40 separate commits
for ($i = 0; $i -lt $experiments.Count; $i++) {

    $file = $experiments[$i]
    $number = $i + 1

    git add -- $file

    if ($LASTEXITCODE -ne 0) {
        throw "Git add failed: $file"
    }

    $message = "Experiment {0:D2} - Implementation" -f $number

    git commit -m $message

    if ($LASTEXITCODE -ne 0) {
        throw "Commit failed: $file"
    }

    Write-Host "Successfully committed $message" -ForegroundColor Green
}

Write-Host "All 40 commits created successfully!"
