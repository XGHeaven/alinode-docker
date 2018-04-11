#!/bin/bash
set -e
source $HOME/.bashrc

if [ -n "$ALINODE_APP_ID" ] && [ -n "$ALINODE_APP_SECRET" ]; then
    export ENABLE_NODE_LOG="YES"
elif [ -n "$ALINODE_APP_ID" ]; then
    echo "Please inject ALINODE_APP_SECRET."
    exit 1
elif [ -n "$ALINODE_APP_SECRET" ]; then
    echo "Please inject ALINODE_APP_ID."
    exit 1
fi

if [ "$ENABLE_NODE_LOG" = "YES" ]; then
    if [ ! -n "$NODE_LOG_DIR" ]; then
        export NODE_LOG_DIR="/var/log/alinode/"
    fi

    if [ ! -d $NODE_LOG_DIR ]; then
        mkdir $NODE_LOG_DIR
    fi

    if [ ! -n "$ALINODE_CONFIG" ]; then
        export ALINODE_CONFIG="/etc/agentx.json"
    fi

    if [ ! -f $ALINODE_CONFIG ]; then
        echo "
{
    \"appid\": \"$ALINODE_APP_ID\",
    \"secret\": \"$ALINODE_APP_SECRET\",
    \"logdir\": \"$NODE_LOG_DIR\"
}
" > $ALINODE_CONFIG
    fi

    nohup agenthub $ALINODE_CONFIG &
fi

exec "$@"
