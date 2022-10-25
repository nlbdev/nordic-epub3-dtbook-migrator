#/bin/bash
printenv | grep -v 'no_proxy' >> /container.env
