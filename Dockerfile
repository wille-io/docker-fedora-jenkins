FROM fedora:latest
RUN dnf update -y
RUN dnf install java-latest-openjdk-headless openssh-server openssh-clients git -y
RUN useradd jenkins
RUN usermod -a -G wheel jenkins
RUN ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key

COPY jenkins.sudo /etc/sudoers.d/jenkins
COPY ssh_rsa.pub /home/jenkins/.ssh/authorized_keys
#COPY ssh_rsa.pub /root/.ssh/authorized_keys
COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22
CMD /usr/sbin/sshd -D -E /var/log/sshd.log
