# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "juice_shop"
$ghauri_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.ghauri))
$request = Join-Path $PSScriptRoot $config.targets.$target.request1
$output_dir = Join-Path $PSScriptRoot $config.output_raw

$url_search = $config.environment.juice_shop_docker + "/rest/products/search?q=apple"
$cookie = $config.targets.$target.cookie


Write-Host "Scanning target: $target..."

# Ghauri does not support option --output-dir="$output_dir\juiceshop"

$start = Get-Date

# Ghauri does not support SQLite, yet

& $ghauri_path -u "$url_search" --level 2 --batch
& $ghauri_path -r "$request" --ignore-code 401 --level 2 --batch


$end = Get-Date
Write-Host "$target scanned, time used: $($end - $start)"