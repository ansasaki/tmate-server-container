#!/bin/bash

create_keys >> /dev/null
print_tmate_conf >> /dev/stdout
echo "" >> /dev/stdout
tmate-ssh-server -k "${SSH_KEY_DIR}" -p "${SSH_PORT_LISTEN}" -h "${SSH_HOSTNAME}"
