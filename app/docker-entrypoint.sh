#!/bin/bash

set -e

#
# UMASK
#
umask u+rxw,g+rwx,o-rwx

#
# INSTALL DEPS
#
yarn install

#
# EXEC COMMAND
#
exec "$@"