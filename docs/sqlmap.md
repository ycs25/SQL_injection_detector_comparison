# Sqlmap

I tried making everything automatic but it's hard to do considering the differences between targets and difficulty levels. But each script does finish its task of corresponding target & difficulty level.

## Scripts
I have stored all the powershell scripts in \script folder. The scripts run sqlmap scans on each target with different security level. 

Those scripts must be run with a `config.json` file. I posted a sample file in the \docs folder. If you are interested in setting up targets and run sqlmap scan scripts yourself, you need to activate/install DVWA and WebGoat manually, find cookies of each target site and put those information in `config.json`. Contact me if you need more information.

## Results
I put all the sqlmap raw scan results in the \data\raw folder. Inside you see folders with targetname_level, which indicate target and difficulty level. Inside localhost folder you will see 3 files, log tells you the vulnerabilities found, session.sqlite stores more informatin of scanning process, and target.txt tells you what's the real command and payload used by sqlmap.

We would mostly likely to use and compare `log` files for now, as it tells you the injection points and weaknesses.