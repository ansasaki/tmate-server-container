#!/bin/bash

create_keys
print_tmate_conf >> /dev/stdout
tmate-ssh-server -k "${SSH_KEY_DIR}" -p "${SSH_PORT_LISTEN}" -h "${SSH_HOSTNAME}"
