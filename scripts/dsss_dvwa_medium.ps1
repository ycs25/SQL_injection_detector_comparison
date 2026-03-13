# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "dvwa"
$dsss_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.dsss))
$output_dir = Join-Path $PSScriptRoot $config.output_raw
$log_file = "$output_dir\dvwa_medium\dsss_dvwa.txt"

$url_sqli = $config.environment.dvwa_docker + "/vulnerabilities/sqli"
$url_blind = $config.environment.dvwa_docker + "/vulnerabilities/sqli_blind"

$phpsessid = $config.targets.$target.phpsessid
$cookie_medium = "security=medium; PHPSESSID={0}" -f $phpsessid
$post_data = "id=1&Submit=Submit#"

# Medium Security
python $dsss_path -u "$url_sqli" --data="$post_data" --cookie="$cookie_medium" > $log_file

Add-Content -Path $log_file -Value "`n"

python $dsss_path -u "$url_blind" --data="$post_data" --cookie="$cookie_medium" >> $log_file