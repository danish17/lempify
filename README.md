# Lempify 
### A simple bash script to install LEMP stack on Ubuntu-based distributions with WordPress CLI 
<br>

## How to run
1. Clone the repository with `git clone https://github.com/danish17/lempify.git`
2. `cd lempify`
3. `chmod +x setup.sh`
4. `sudo ./setup.sh`

## Things to keep in mind
1. Ensure that port `80` is free.
2. If you are running this on a freshly created server, run `apt update && apt upgrade` 
   before executing this script.

## Example
```bash
$ apt update && apt upgrade
$ git clone https://github.com/danish17/lempify.git && cd lempify
$ chmod +x setup.sh
$ sudo ./setup.sh
 ____ ____ ____ ____ ____ ____ ____ 
||l |||e |||m |||p |||i |||f |||y ||
||__|||__|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
 
A simple bash script to setup LEMP stack with WordPress CLI


➜ Checking permissions...
✓ Permissions OK.
➜ Creating Logfile...
✓ Logfile created.
➜ Setting up permissions...
✓ Permissions set.
➜ Checking Linux distribution...
✓ Ubuntu detected.
➜ Checking port 80 availability...
✓ Port 80 is free.
➜ Checking Nginx...
✓ Nginx not detected.
➜ Checking PHP...
✓ PHP not detected.
➜ Checking MySQL...
✓ MySQL not detected.
➜ Checking WP-CLI...
⚠ WP-CLI installation detected.
➜ Installing Nginx...
✓ Nginx installed successfully.
➜ Installing PHP...
✓ PHP installed successfully.
➜ Installing MySQL...
✓ MySQL installed successfully.
➜ Checking Nginx Service Status...
✓ Nginx is enabled.
✓ Nginx is running.
➜ Creating test site: http://example.local
➜ Enabling test site: http://example.local
✓ Nginx configuration copied and enabled.
➜ Copying site files to /var/www/html/example.local
✓ Site files copied.
➜ Creating hosts file entry for test site: http://example.local
✓ Hosts file entry for test site created.
➜ Testing Nginx configuration
✓ Nginx configuration test passed.
➜ Restarting Nginx
✓ Nginx restarted.
➜ Testing if site is OK.
✓ Test site is up.
✓ Test site created and configured. Visit http://example.local
```
