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
    g++ \
    gnupg2 \
    gnupg \
    build-essential \
    xz-utils \
    ca-certificates

#
# NODEJS - LTS 12 for TestCafe
#
RUN curl --insecure -o /opt/node-v12.13.1-linux-x64.tar.xz https://nodejs.org/dist/v12.13.1/node-v12.13.1-linux-x64.tar.xz && \
    tar xfv /opt/node-v12.13.1-linux-x64.tar.xz -C /opt/ && \
    ln -s /opt/node-v12.13.1-linux-x64/bin/node /usr/local/bin/node && \
    ln -s /opt/node-v12.13.1-linux-x64/bin/npm /usr/local/bin/npm && \
    rm -f /opt/node-v12.13.1-linux-x64.tar.xz

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
WORKDIR /app

# Add e2e
COPY ./src /app/src
COPY ./package.json /app

# Switch to user space
RUN chown -R worker /app
USER worker

EXPOSE 4000
ENTRYPOINT ["/work-private/docker-entrypoint.sh"]
CMD ["node", "src/index.js"]