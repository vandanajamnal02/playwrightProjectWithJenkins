# 1. Remove Podman-docker compatibility layer
sudo apt remove podman-docker -y 2>/dev/null || true
sudo rm -f /usr/bin/podman-docker

# 2. Clean up all container configurations
sudo rm -rf /etc/containers/registries.conf.d/

# 3. Verify Docker is the default
sudo update-alternatives --config container-runtime
# Select docker if available

# 4. Restart Docker
sudo systemctl restart docker