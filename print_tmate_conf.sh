#!/usr/bin/env bash
set -eu

keys=()
read_key() {
  keytype=$1
  ks="${keytype}_"
  key="keys/ssh_host_${ks}key"
  if [ ! -e "${key}" ] ; then
    echo "Key ${key} not found, did you generate the keys?"
  fi
  sig=$(ssh-keygen -l -E SHA256 -f "$key.pub" | cut -d ' ' -f 2)
  keys+=("set -g tmate-server-${keytype}-fingerprint ${sig}")
}

for alg in rsa ed25519; do
  read_key ${alg}
done

if [ ${#keys[@]} -eq 0 ]; then
  echo "No keys found, please generate the keys before running this script. Check the command in https://github.com/ansasaki/tmate-server-container README"
else
  echo "You may use the following settings this in your clients .tmate.conf:"
  echo ""
  echo "set -g tmate-server-host ${SSH_HOSTNAME}"
  echo "set -g tmate-server-port ${SSH_PORT_LISTEN}"
  for s in "${keys[@]}"; do
    echo "${s}"
  done
fi
