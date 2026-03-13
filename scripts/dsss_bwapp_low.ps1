# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "bwapp"
$dsss_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.dsss))
$output_dir = Join-Path $PSScriptRoot $config.output_raw
$log_file = "$output_dir\bwapp_low\dsss_bwapp.txt"

$url_get_search = $config.environment.bwapp_docker + "/sqli_1.php?title=123&action=search"
$url_post_search = $config.environment.bwapp_docker + "/sqli_6.php"
$url_blindB = $config.environment.bwapp_docker + "/sqli_4.php?title=123&action=search"
$url_blindT = $config.environment.bwapp_docker + "/sqli_15.php?title=123&action=search"
$url_user_agent = $config.environment.bwapp_docker + "/sqli_17.php"

$phpsessid = $config.targets.$target.phpsessid
$cookie_low = "security_level=0; PHPSESSID={0}" -f $phpsessid
$request = Join-Path $PSScriptRoot $config.targets.$target.request_file

# DSSS commands
python $dsss_path -u "$url_get_search" --cookie="$cookie_low" > $log_file

Add-Content -Path $log_file -Value "`n"

python $dsss_path -u "$url_post_search" --data="title=it&action=search" --cookie="$cookie_low" >> $log_file

Add-Content -Path $log_file -Value "`n"

python $dsss_path -u "$url_blindB" --cookie="$cookie_low" >> $log_file
