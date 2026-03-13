# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "webgoat"
$ghauri_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.ghauri))
$request = Join-Path $PSScriptRoot $config.targets.$target.request1

$jsessid = $config.targets.$target.jsessid
$cookie = "JSESSIONID={0}" -f $jsessid
$request1 = Join-Path $PSScriptRoot $config.targets.$target.request1

& $ghauri_path -r "$request1" --cookie="$cookie" --technique=B --level 3 --batch