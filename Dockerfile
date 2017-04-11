FROM jenkinsci/jnlp-slave

USER root

# Set the RU locale
RUN apt-get update && apt-get install -y locales \
 && localedef -f UTF-8 -i ru_RU ru_RU.UTF-8

ENV LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8
#Set RU TimeZone
ENV TZ "Europe/Moscow"

USER jenkins

# Install Maven
ENV MAVEN_VERSION=3.3.9
ENV MAVEN_HOME=/home/jenkins/apache-maven-${MAVEN_VERSION}
WORKDIR /home/jenkins

# Download and extract maven to home folder
RUN wget --no-check-certificate --no-cookies http://mirror.olnevhost.net/pub/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && tar xvf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz.md5
	
ENV M2_HOME=${MAVEN_HOME}
ENV M2=$M2_HOME/bin 
ENV PATH=$M2:$PATH

VOLUME /home/jenkins

ENTRYPOINT ["jenkins-slave"]
