#! /bin/bash

export NODE_PATH=/usr/local/node/lib/node_modules
export NODE_ENV=production

exec /usr/local/node/bin/node "$@"
