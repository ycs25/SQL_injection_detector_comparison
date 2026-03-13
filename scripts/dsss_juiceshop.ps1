# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "juice_shop"
$dsss_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.dsss))
$request = Join-Path $PSScriptRoot $config.targets.$target.request1
$output_dir = Join-Path $PSScriptRoot $config.output_raw
$log_file = "$output_dir\juiceshop\dsss_juiceshop.txt"

$url_search = $config.environment.juice_shop_docker + "/rest/products/search?q=apple"
$url_login = $config.environment.juice_shop_docker + "/rest/login"
$cookie = $config.targets.$target.cookie


python $dsss_path -u "$url_search" --cookie="$cookie" > $log_file

Add-Content -Path $log_file -Value "`n"

python $dsss_path -u "$url_login" --data='{"email":"admin@juice-sh.op","password":"123"}' >> $log_file