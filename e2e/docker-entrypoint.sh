#!/bin/bash

set -e

#
# UMASK
#
umask u+rxw,g+rwx,o-rwx

#
# XVFB + FLUXBOX
#
echo "DOCKER-ENTRYPOINT-HOOK >> starting Xvfb"
Xvfb :99 -ac -screen 0 1280x1024x16 -nolisten tcp &
xvfb=$!
export DISPLAY=:99
fluxbox >/dev/null 2>&1 &

#
# DBUS
#
echo "DOCKER-ENTRYPOINT-HOOK >> starting dbus"
eval `dbus-launch --sh-syntax --config-file=/tmp/dbus-system.conf`

#
# INSTALL DEPS
#
yarn install

#
# WHICH BROWSER
#
temp="${USE_BROWSER%\"}"
USE_BROWSER_WITHOUT_QUOTES="${temp#\"}"
echo "==========================="
echo "BROWSER: $USE_BROWSER_WITHOUT_QUOTES"
echo "==========================="
if [ "$USE_BROWSER_WITHOUT_QUOTES" == "chrome" ]
then
  yarn test:ci:chrome
fi

if [ "$USE_BROWSER_WITHOUT_QUOTES" == "firefox" ]
then
  yarn test:ci:firefox
fi

#
# EXEC DUMMY COMMAND
#
exec "$@"
