# Préambule

The purpose of this repository is to hold all the necessary configuration files in order for Ansible and some scripts to (almost) fully bootstrap Arch into a desired state.

It ensures that no packages require manual installation and that no configuration is to be done by hand.

It is split into 3 steps:
 - Installing Arch and bootstrapping it
 - Using Ansible to setup the system
 - Managing the Ansible configuration


# 1. Installing Arch

This goes through the steps to get Arch installed and roughly follows https://wiki.archlinux.org/title/Installation_guide.

Documents the steps in order to install Arch with sensible defaults for a 2tb drive.

---
## Boot into the iso

Start the installation process by selecting `Arch linux install medium`

---
## WiFi

Connect to WiFi before starting the installation process.

#### 1. Ensure valid network interface is present.

The following should return a valid network interface (wlan0).
```sh
ip link
```

#### 2. Activate iwd interfacae

Activate the command line interface for iwd, which is required to setup the WiFi.
```sh
iwctl
```

#### 3. Scan networks (while in iwd mode)

While in the iwd interface, scan the networks. It is normal for no output to be shown.
```iwd
station <interface> scan
```

#### 4. Check available networks

Obtain a list of available networks.
```iwd
station <interface> get-networks
```

#### 5. Connect to the network

After locating the desired network, connect to it.
```iwd
station <interface> connect <SSID>
```
Enter the password when prompted

#### 6. Final check

Leave the iwd interface, then ping arch.
```sh
ping ping.archlinux.org
```

#### 7. Ensure system clock is synchronized

Check if the system clock is synchronized
```sh
timedatectl
```

### Troubleshooting connection errors

It is possible that the connection to the WiFi fails, in such a case, the following is to be tried.
```sh
mkdir -p /etc/iwd
echo -e "[General]\nControlPortOverNL80211=false > /etc/iwd/main.conf"
systemctl restart iwd
```

---
## Get git

Install git with pacman
```sh
pacman -Sy git
```

---
## Install Arch

To  finish installing Arch, all that remains is to obtain the script and run it.

#### 1. Get the script

Get the install script for installing arch, it also comes ansible configs, but these will be useless in the iso environment.
```sh
git clone https://github.com/LouisBouch/monArchizer
```

#### 2. Run the installation script

Run the script that will automatically install Arch on your system.
```bash
./monArchizer/install_arch/install_arch.sh
```

#### 3. Reboot

Reboot your system to anchor changes.
```bash
reboot
```

The root password is **toor**.

# 2. System configuration with Ansible

The entire configuration of the system (with the exception of dot files, which are handled by chezmoi) is to be handled by Ansible. This allows a reproducible environment with nothing left to guesswork.

## WiFi

Before pulling in the config files for Ansible, a WiFi connection is required.

#### 1. Activate iwd and DNS resolver

Activate the iwd service to allow connection to internet and create the necessary files/directory to mount on later steps. Also activate DNS resolver to allow name conversion.
```sh
systemctl start iwd systemd-resolved
```

#### 2. Mount live memory temporarily

Mount a temporary "RAM disk" to avoid creating any permanent configuration not set by Ansible. This is done by pointing some location in the file system to RAM directly.
```sh
mount -t tmpfs tmpfs /etc/iwd
```

#### 3. Add iwd configs

Add configs to iwd to enable the builtin DHCP client, which will allow ip resolution.
> [!abstract]  /etc/iwd/main.conf
```conf
[General]  
EnableNetworkConfiguration=true
```

Restart the service.
```sh
systemctl restart iwd
```

#### 4. Connect to WiFi

Connect to the WiFi using the steps described [[1. Arch installation process#WiFi|here]].

#### 5. Unmount

Remove traces of any modifications.
```sh
umount /etc/iwd
```


---
## Clone Ansible configs

With access to the internet, clone the github repository holding the Ansible configs into a temporary directory.
```bash
cd /tmp && git clone https://github.com/LouisBouch/monArchizer
```

--- 
## Run bootstrap playbook

Once the configs have been cloned, move into the new directory and run the bootstrapping playbook. **THE BOOTSTRAP SCRIPT MUST BE RUN WHILE IN THE GIT REPO**
```bash
cd monArchizer && ./bootstrap.sh
```

It is recommended to get the package list from pacman first, to ensure the package list exists.
```bash
sudo pacman -Sy
```

Switch to new user before doing anything else, and then do the first synchronization.
```bash
./.local/bin/snc
```

It is possible that the command will fail, if it happens, run it again. Some errors will creep up and be gone the next time the command is run, this is most likely due to the fact that commands are executed one after the other a bit too fast, not giving the time for the previous command to fully finish.

# 3. Maintain

Now that everything is setup, all that remains is to keep the system up to date.

## Keep system synchronized

With the system bootstrapped, keep the system synchronized with ansible configs
```bash
snc
```

Or run only the desired roles.
```bsh
snc --tags security network
```

## Modify configs

To change things about your system, never manually install or modify files. Go through the Ansible pacman command to install packages and use chezmoi to change dot files.

The location of dotfiles are in `~/monArchizer/ansible/dotfiles`.
