# Nix Shell for OpenStack

This is for users with  a [Nix](https://nixos.org/nix/) installation:

1. From this directory `nix-shell .`
2. Create a `.openrc.sh` in `$HOME` according to your cloud provider.
3. `source .openrc.sh`
4. Confirm working, e.g., `openstack image list`