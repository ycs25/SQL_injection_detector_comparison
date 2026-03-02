## Step 1: Install Docker Desktop
Docker will host our "vulnerable targets" (Juice Shop, WebGoat, etc.) in isolated environments .

Download: Go to the Docker Desktop website and install the Windows version.

Backend: During installation, ensure WSL2 (Windows Subsystem for Linux) is selected as the backend for better performance.

Start the Engine: Open Docker Desktop. You must see the "green whale" icon in your system tray before running any commands. Remember, the PowerShell CLI is just a "client" that talks to the Docker "engine" running in the background.

## Step 2: Organize the Workspace

/SQL_injection_detector_comparison

├── setup/           # Docker configuration

├── tools/           # sqlmap, dsss, etc.

├── scripts/         # PowerShell automation

└── data/            # Raw scan results
## Step 3: Deploy Vulnerable Targets
We will use a single file to launch all targets at once .

In the /setup folder, there is a file named compose.yaml.

Run it: Open PowerShell in the /setup folder and run:

`docker compose up -d`

Visit juice-shop: Visit http://localhost:3000

OWASP WebGoat: http://localhost:8080

Initialize DVWA: Visit http://localhost:8081/setup.php and click "Create / Reset Database". Use admin/password to log in.

Initialize bWAPP: Visit http://localhost:8082/install.php

Run in powershell to terminate the containers:

`docker compose down`

## Step 4: Download Injection Tools
We will compare a "Gold Standard" tool against a "Minimalist" tool to analyze detection logic differences.

Open PowerShell in the /tools folder.

Clone sqlmap: git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git.

Clone DSSS: git clone https://github.com/stamparm/DSSS.git.

You could also download those tools manually and save in a different location.

## Step 5: Automate with PowerShell (.ps1)
To ensure our benchmark is "rigorous and reproducible," we don't run commands manually. We write a script to log time and output.

In the /scripts folder, there is a file run_scans.ps1.

You can use it or write your own script.

**Store secrets like cookie and tool path in config file is a good practice.**

The Script Logic:

PowerShell
```
\# Configuration
$sqlmapPath = "../tools/sqlmap/sqlmap.py"
$targetUrl = "http://localhost:8081/vulnerabilities/sqli/?id=1&Submit=Submit"
$cookie = "security=low; PHPSESSID=your_session_id" # Get this from your browser

Write-Host "--- Starting Benchmark for DVWA ---" -ForegroundColor Cyan

\# 1. Start Timer
$start = Get-Date

\# 2. Run sqlmap [cite: 138-140]
\# --batch: automated mode (no user input required)
python $sqlmapPath -u $targetUrl --cookie $cookie --batch --output-dir="../data/raw/dvwa_sqlmap"

\# 3. Calculate Duration
$end = Get-Date
$duration = $end - $start
Write-Host "Scan completed in $($duration.TotalSeconds) seconds." -ForegroundColor Green
```
