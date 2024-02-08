
# Use the official image as a parent image
FROM ubuntu

ARG ssh_pub_key
ARG hostname

# Update the system, install OpenSSH Server, and set up users
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y openssh-server && \
    apt-get install -y python3 python3-pip python-is-python3 git

# Create user and set password for user and root user
RUN  useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu && \
    echo 'ubuntu:root' | chpasswd && \
    echo 'root:root' | chpasswd

# Set up configuration for SSH
RUN mkdir /var/run/sshd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "export VISIBLE=now" >> /etc/profile && \
    mkdir /app && \
    mkdir -p /home/ubuntu/.ssh && \
    echo "$ssh_pub_key" > /home/ubuntu/.ssh/authorized_keys 

# Expose the SSH port
EXPOSE 22

# Run SSH
CMD ["/usr/sbin/sshd", "-D"]

