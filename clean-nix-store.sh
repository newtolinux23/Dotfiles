#!/bin/bash

# Delete old generations
sudo nix-collect-garbage -d

# Garbage collect unused paths
sudo nix-store --gc

# Optimize the Nix store
sudo nix-store --optimize

# Clean the Nix store logs
sudo rm -rf /nix/var/log/nix/drvs/*
