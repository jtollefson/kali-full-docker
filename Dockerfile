FROM kalilinux/kali-rolling:latest

# Forked from https://github.com/XaviTorello/kali-full-docker
# Original author="Xavi Torelló"

LABEL maintainer="https://github.com/jtollefson/kali-full-docker"
LABEL author="J. Tollefson"

ENV DEBIAN_FRONTEND noninteractive

# Install Kali Full
RUN rm -fR /var/lib/apt/ && \
    apt-get clean && \
    apt-get update -y && \
    apt-get install -y software-properties-common kali-linux-headless --fix-missing && \
    echo 'VERSION_CODENAME=kali-rolling' >> /etc/os-release

# Some system tools
RUN apt-get install -y git colordiff colortail unzip vim tmux curl telnet strace ltrace less build-essential wget python3-setuptools python3-pip zstd net-tools bash-completion iputils* dnsutils netcat nmap tcpdump

# secLists!
RUN git clone https://github.com/danielmiessler/SecLists /usr/share/seclists

# May add this back in at some point, for now we use burp suite
# w3af
# RUN git clone https://github.com/andresriancho/w3af.git /opt/w3af && \
#     apt-get install -y libssl-dev libxml2-dev libxslt1-dev zlib1g-dev python-dev python-pybloomfiltermmap ; \
#     /opt/w3af/w3af_console ; \
#     bash /tmp/w3af_dependency_install.sh ; \
#     echo 'export PATH=/opt/w3af:$PATH' >> /etc/profile

# nmapAutomator
RUN git clone https://github.com/21y4d/nmapAutomator.git /tools/nmapAutomator \
    && ln -s /tools/nmapAutomator/nmapAutomator.sh /usr/local/bin/nmapAutomator

# Install vimrc awesome
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && \
    bash ~/.vim_runtime/install_awesome_vimrc.sh && \
    python3 ~/.vim_runtime/update_plugins.py

# virtualenv config
RUN pip install virtualenvwrapper && \
    echo 'export WORKON_HOME=$HOME/.virtualenvs' >> /etc/profile && \
    echo 'export PROJECT_HOME=$HOME/projects' >> /etc/profile && mkdir /root/projects && \
    echo 'export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh' >> /etc/profile && \
    bash /usr/local/bin/virtualenvwrapper.sh && \
    echo 'source /usr/local/bin/virtualenvwrapper.sh' >> /etc/profile

# Update DB and clean'up!
RUN updatedb && \
    apt-get autoremove -y && \
    apt-get clean 

CMD ["/bin/bash", "--init-file", "/etc/profile"]
