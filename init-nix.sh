#!/usr/bin/env bash

HOST=$(uname -n)
sudo nixos-rebuild switch --flake ".#$HOST"
