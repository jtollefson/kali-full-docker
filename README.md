# Kali Linux

It provides a Kali Linux container with the latest full metapackage pre-installed ready to work!

Integrated with docker-compose and standalone builds

Be patient, this will install all Kali tools (just for the first install, at image generation time). Final image size `~10GB`.

## Tools

- Kali full metapackage with all available tools
  - See [Kali Tools](https://www.kali.org/tools/) for a list along with documentation
- [SecLists](https://github.com/danielmiessler/SecLists) at `/usr/share/seclists`
- [Subscraper](https://github.com/m8r0wn/subscraper) at `/tools/subscraper` symbolic link to `/usr/local/bin/subscraper`
- python virtualenvs via `virtualenvwrapper`
  - projects placed at `/root/projects`
- base packages
  - wget, curl, telnet, git, iputils-tracepath, net-tools
  - build-essential
  - tmux, tmate
  - xterm, zsh
  - zstd
  - ltrace, strace
  - vim, less, colordiff, colortail
  - unzip, unrar
  - python3-setuptools, python3-pip
  - bash-completion

## Usage

Just launch the container using our simple bash compose handler:

```bash
bash run.sh
```

This will prepare a temporal container (will be auto-destroyed at the end) with the latest available version of Kali
