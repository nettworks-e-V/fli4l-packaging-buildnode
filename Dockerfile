FROM starwarsfan/fli4l-packaging-container:latest
MAINTAINER Yves Schumann <yves@eisfair.org>

# Configuration for Jenkins swarm

# Default values
ARG JENKINS_IP="localhost"
ARG USERNAME="admin"
ARG PASSWORD="admin"
ARG DESCRIPTION="Swarm node for fli4l-packaging"
ARG LABELS="linux swarm fli4l-packaging"
ARG NAME="generic-swarm-node"
ARG UID="1000"

# Environment variables for swarm client
ENV JENKINS_URL=http://$JENKINS_IP \
    JENKINS_USERNAME=$USERNAME \
    JENKINS_PASSWORD=$PASSWORD \
    EXECUTORS=1 \
    DESCRIPTION=$DESCRIPTION \
    LABELS=$LABELS \
    NAME=$NAME \
    SWARM_PLUGIN_VERSION=3.5

# Setup jenkins account
# Create working directory
# change user UID
RUN useradd -m -d /home/jenkins -s /bin/zsh jenkins \
 && echo "jenkins:jenkins" | chpasswd \
 && chown jenkins:jenkins /home/jenkins -R \
 && mkdir -p /data/jenkins-work \
 && chown -R jenkins:jenkins /data \
 && usermod -u ${UID} jenkins
RUN pacman -Syyu --noconfirm jre8-openjdk

# Start swarm client
ADD "https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_PLUGIN_VERSION}/swarm-client-${SWARM_PLUGIN_VERSION}.jar" /data/swarm-client.jar

USER jenkins
# Start ssh
#CMD ["/usr/sbin/sshd", "-D"]

CMD java \
    -jar /data/swarm-client.jar \
    -executors "${EXECUTORS}" \
    -noRetryAfterConnected \
    -description "${DESCRIPTION}" \
    -fsroot /data/jenkins-work \
    -master "${JENKINS_URL}" \
    -username "${JENKINS_USERNAME}" \
    -password "${JENKINS_PASSWORD}" \
    -labels "${LABELS}" \
    -name "${NAME}" \
    -sslFingerprints " "
