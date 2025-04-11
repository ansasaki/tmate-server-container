# tmate-server-container
A container to run a tmate server

# Dependencies:
- podman

# Usage
```
podman run --name tmate-server \
    --rm -d \
    -v $(pwd)/keys:/root/keys:z \
    --cap-add CAP_SYS_ADMIN \
    -p 2222:2222 -P \
    -e SSH_PORT_LISTEN=2222 \
    -e SSH_HOSTNAME=$(hostname)
    ghcr.io/ansasaki/tmate-server-container/tmate-server:main
```

This will make the server to listen to port `2222`

# Configuration

The following environment variables can be set to configure the server:

- `SSH_PORT_LISTEN`: Sets the port to listen. Remember to map the local port
    with the container port by passing `-p <LOCAL_PORT>:<CONTAINER_PORT>`, for
    example `-p 2200:2200 -e SSH_PORT_LISTEN=2200`
- `SSH_HOSTNAME`: Sets the hostname to listen. Default is the result of `hostname`.
  Recommended: use the local hostname as in the usage line above.
