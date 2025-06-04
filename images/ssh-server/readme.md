### Build

docker build -t ssh-mock-server .

### Run

 docker run -d \
  --name sshd-test-container \
  -p 2222:22 \
  -v sshd_config:/etc/ssh/sshd_config:ro \
  ssh-mock-server
