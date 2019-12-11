FROM ubuntu:18.04

#
# USERS
#
RUN groupadd -g 10777 worker && \
    useradd -c "user" -d /e2e -u 10777 -g 10777 -m worker

#
# BASE PACKAGES
#
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    apt-get -qqy update \
    && apt-get -qqy --no-install-recommends install \
    wget \
    bzip2 \
    curl \
    jq \
    zip \
    xvfb \
    pulseaudio \
    ffmpeg \
    g++ \
    gnupg2 \
    gnupg \
    build-essential \
    dbus \
    dbus-x11 \
    fluxbox \
    xz-utils \
    ca-certificates

#
# FIX X11
#
RUN mkdir /tmp/.X11-unix | true && \
    chown -R root:root /tmp/.X11-unix && \
    chmod 1777 /tmp/.X11-unix

#
# NODEJS - LTS 12 for TestCafe
#
RUN curl --insecure -o /opt/node-v12.13.1-linux-x64.tar.xz https://nodejs.org/dist/v12.13.1/node-v12.13.1-linux-x64.tar.xz && \
    tar xfv /opt/node-v12.13.1-linux-x64.tar.xz -C /opt/ && \
    ln -s /opt/node-v12.13.1-linux-x64/bin/node /usr/local/bin/node && \
    ln -s /opt/node-v12.13.1-linux-x64/bin/npm /usr/local/bin/npm && \
    rm -f /opt/node-v12.13.1-linux-x64.tar.xz

#
# FIREFOX - Stable v70
#
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    apt-get -qqy update \
    && apt-get -qqy install libgtk-3-0 libx11-xcb1 libdbus-glib-1-2 libxt6 && \
    curl -o /opt/firefox-70.0.tar.bz2 "https://download-installer.cdn.mozilla.net/pub/firefox/releases/70.0/linux-x86_64/de/firefox-70.0.tar.bz2" && \
    tar xfv /opt/firefox-70.0.tar.bz2 -C /opt/ && \
    rm -f /opt/firefox-70.0.tar.bz2 && \
    ln -s /opt/firefox/firefox /usr/local/bin/firefox

#
# CHROME
#
ARG CHROME_VERSION="google-chrome-stable"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update -qqy && apt-get -qqy install ${CHROME_VERSION:-google-chrome-stable} && \
    rm /etc/apt/sources.list.d/google-chrome.list && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    ln -s /usr/bin/google-chrome /usr/bin/chromium-browser


#
# YARN
#
RUN wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qqy && apt-get -qqy install yarn && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#
# DOCKER ENTRYPOINT + UTILS
#
COPY docker-entrypoint.sh /work-private/docker-entrypoint.sh
RUN chmod u+rx,g+rx,o+rx,a-w /work-private/docker-entrypoint.sh
WORKDIR /e2e

# Add e2e
COPY ./tests /e2e/tests
COPY ./package.json /e2e

# Switch to user space
RUN chown -R worker /e2e
USER worker

# DEFAULT ENV VARS
ENV FFMPEG_PATH /usr/bin/ffmpeg
ENV USE_BROWSER chrome

ENTRYPOINT ["/work-private/docker-entrypoint.sh"]
CMD ["echo", "ALL DONE"]