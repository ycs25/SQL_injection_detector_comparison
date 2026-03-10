# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "juice_shop"
$sqlmap_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.sqlmap))
$request = Join-Path $PSScriptRoot $config.targets.$target.request_file
$output_dir = Join-Path $PSScriptRoot $config.output_raw

$url_search = $config.environment.juice_shop_docker + "/rest/products/search?q=apple"
$cookie = $config.targets.$target.cookie


Write-Host "Scanning target: $target..."

$start = Get-Date

Write-Host "$url_search"

python $sqlmap_path -u "$url_search" --cookie="$cookie" --level 2 --batch --output-dir="$output_dir\juiceshop"
python $sqlmap_path -r "$request" --ignore-code 401 --level 2 --batch --output-dir="$output_dir\juiceshop"


$end = Get-Date
Write-Host "$target scanned, time used: $($end - $start)"