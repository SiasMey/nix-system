#!/usr/bin/env bash
HOST=$(uname -n)
USER=$(whoami)

nix run home-manager/master -- switch --flake ".#$USER@$HOST"
