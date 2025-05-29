# Linux Harden Script 🛡️

This script is designed to apply essential Linux system security measures quickly and efficiently. With a modular structure, each module can be executed independently and extended as needed.

## 🔧 Features

- SSH configuration and hardening
- UFW (Uncomplicated Firewall) setup
- Fail2Ban installation and configuration
- Secure file permission checks
- Detection of potentially dangerous services
- Logging system (all operations are recorded in the `logs/` directory)

## 📁 Modules

- `modules/ssh_hardening.sh`
- `modules/ufw_hardening.sh`
- `modules/fail2ban_hardening.sh`
- `modules/permissions_hardening.sh`
- `modules/service_hardening.sh`

## 🚀 Installation & Usage

```bash
git clone https://github.com/alperoztvrk/linux-harden-script.git
cd linux-harden-script
chmod +x harden.sh
sudo ./harden.sh
```

⚠️ WARNING: This script must be executed with sudo privileges.

📒 Log Files

Each module generates a separate log file under the logs/ directory. Examples:
	•	logs/ssh.log
	•	logs/ufw.log
	•	logs/permissions.log

🧠 Developer Notes
	•	Modules can be tested individually.
	•	Additional modules for advanced security (e.g., AppArmor, auditd) are planned for future updates.

👨‍💻 Developer
	•	Alper Ozturk – My GitHub Profile

⸻

✅ License

This project is licensed under the MIT License.
