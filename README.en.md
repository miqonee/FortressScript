# Server Security Setup Script

*Read this in other languages: [Русский](README.md), [Deutsch](README.de.md)*

---

## Script Description

This script is written in the Bash (Bourne Again SHell) command-line language and is designed to automate the security setup of a Linux server.

The script performs a series of operations, including system updates, web server configuration, installation and configuration of various security tools, creation of a non-root user, and the application of appropriate security settings.

---

## How to Use

To apply this script, you need to have access to a Linux server with root privileges. Follow these steps:

1. Download the script to your server. You can do this, for example, using the `scp` command or `wget` if the script is available for download from the internet.
2. Make the script executable by running the command `chmod +x script.sh`, where `script.sh` is the name of the script file.
3. Run the script using the command `sudo ./script.sh` (if you're not root) or `./script.sh` (if you're already root).

---

## Command Line Options

This script supports the `-i` command line option, which runs the script in interactive mode.

In this mode, the script will prompt for user confirmation before executing each operation.

For example, `sudo ./script.sh -i` will run the script in interactive mode.

---

## Script Functionality

The script performs a series of operations to automate the security setup of a Linux server. Here's what is included in its functionality:

- System Updates: The script starts by updating the package list in your Linux distribution's repositories and then upgrades all installed packages to their latest versions. This helps ensure that your server has the latest security updates.

- Web Server Configuration: The script proceeds to configure the web server. It installs and configures the Apache web server, including the setup of certain security parameters.

- Installation and Configuration of Security Tools: The script installs and configures several security tools, including fail2ban (for preventing password brute force attempts), UFW (for firewall management), and ClamAV (for virus detection).

- Creation of Non-Root User: To enhance security, the script creates a new user with limited privileges (non-root) and sets a password for it. This prevents potential breaches using the root account.

- SSH Security Configuration: The script also configures SSH security by disabling root login and setting other settings to reduce the risk of intrusion.

- iptables Configuration: The script configures iptables and sets firewall rules to prevent unwanted traffic.

- Audit System Configuration: The script installs and configures an audit system, which helps track all actions and events within the system for security purposes and issue resolution.

- File Integrity Monitoring Setup: The script installs and configures a file integrity monitoring system, such as AIDE (Advanced Intrusion Detection Environment). This allows you to monitor any unexpected or suspicious changes to files on your server, which could be indicative of a breach or other security threat.

- Intrusion Detection System (IDS) Setup: The script also installs and configures an IDS, such as Snort, which can detect suspicious activity that may indicate an intrusion attempt.

---
