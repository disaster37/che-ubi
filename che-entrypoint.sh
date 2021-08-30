#!/bin/sh

# Check if use default path or not
if [ ! -z "$1" ]; then
    EXTRA_CERTICATE_PATH=$1
else
    EXTRA_CERTICATE_PATH=/public-certs
fi

# Copy and load certificats if path exist
if [ -d $EXTRA_CERTICATE_PATH ]; then
    sudo cp $EXTRA_CERTICATE_PATH/*.crt /usr/share/pki/ca-trust-source/anchors/
    sudo update-ca-trust
fi

# Sleep forever
sleep infinity

