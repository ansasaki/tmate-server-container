# tmate-server-container
A container to run a tmate server

# Setup
Run the script to generate keys from `tmate-io/tmate-ssh-server` repository

```
$ curl https://raw.githubusercontent.com/tmate-io/tmate-ssh-server/refs/heads/master/create_keys.sh > create_keys.sh
$ chmod +x create_keys.sh
$ ./create_keys.sh
```

This will generate a `keys` directory containing some SSH keys for the server

# Usage
```
$ podman run --name tmate-server \
    --rm -d \
    -v $(pwd)/keys:/root/keys:z \
    --cap-add CAP_SYS_ADMIN \
    -p 2222:2222 -P \
    ghcr.io/ansasaki/tmate-server-container \
    -k /root/keys -p 2222 -h $(hostname)
```

This will make the server to listen to port `2222`
