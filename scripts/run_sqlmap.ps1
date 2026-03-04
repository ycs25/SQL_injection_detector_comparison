# Read configuration
$config = Get-Content "..\config.json" | ConvertFrom-Json

# Target: juice-shop
$target = "juice_shop"
$url = $config.targets.$target.url
$cookie = $config.targets.$target.cookie
$request = $config.targets.$target.request_file

Write-Host "Scanning target: $name..."

$start = Get-Date

python $config.tools.sqlmap -u "$url" --cookie="$cookie" --level 2 --batch --output-dir="..\data\raw\$name"
python $config.tools.sqlmap -r "$request" --ignore-code 401 --level 2 --batch --output-dir="..\data\raw\$name"

$end = Get-Date
Write-Host "$target scanned, time used: $($end - $start)"