#!/bin/bash -e

# Make sure that the Pipeline 2 Web Service can bind to the remote endpoint.
# For instance, if container is exposed as pipeline.example.com, then PIPELINE2_WS_HOST
# must be set to pipeline.example.com so that the web service responses include the
# correct hostname when returning URLs. However, the web service will also try to bind
# to the host declared in PIPELINE2_WS_HOST (this cannot be declared separately), so
# we map PIPELINE2_WS_HOST to 0.0.0.0 ("all interfaces") in /etc/hosts so that Pipeline 2
# are able to bind to the correct interface and listen for requests.

if [ "$PIPELINE2_WS_HOST" != "" ] && [ "$PIPELINE2_WS_HOST" != "0.0.0.0" ] ; then
    echo "0.0.0.0 $PIPELINE2_WS_HOST" >> /etc/hosts
fi

/opt/daisy-pipeline2/bin/pipeline2 "$@"
