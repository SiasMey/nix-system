#!/usr/bin/env bash

HOST=$(uname -n)
sudo nixos-rebuild boot --flake ".#$HOST"
