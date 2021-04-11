FROM ubuntu:bionic
LABEL MAINTANER owahltinez <oscar@wahltinez.org>

# Environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PACKAGES ${HOME}/debian-packages.txt

# Update root certificates
RUN apt update -yq && \
    apt install -yq ca-certificates && update-ca-certificates

# Install dependencies
WORKDIR ${HOME}
COPY debian-packages.txt ${DEBIAN_PACKAGES}
RUN apt install -yq `cat ${DEBIAN_PACKAGES}`
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Setup Git config
RUN git config --global user.name "bot"
RUN git config --global user.email "bot@android-rpi"
RUN git config --global color.ui false

# Install Android repo tool
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && \
    chmod a+x /usr/local/bin/repo
