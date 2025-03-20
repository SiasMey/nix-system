#!/usr/bin/env bash
echo "if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then" >> ~/.zprofile
echo "  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'" >> ~/.zprofile
echo "fi" >> ~/.zprofile
