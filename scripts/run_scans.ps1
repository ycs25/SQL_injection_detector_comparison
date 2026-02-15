# 1. Read configuration
$config = Get-Content "..\config.json" | ConvertFrom-Json

# 2.Run SQLmap
foreach ($target in $config.targets.PSObject.Properties) {
    $name = $target.Name
    $url = $target.Value.url
    $cookie = $target.Value.cookie

    Write-Host "Scanning target: $name..."
    
    # Start time
    $start = Get-Date
    
    # Run command and save results to data\raw\
    python $config.tools.sqlmap -u "$url" --cookie="$cookie" --batch --output-dir="..\data\raw\$name"
    
    $end = Get-Date
    Write-Host "$name scanned, time used: $($end - $start)"
}