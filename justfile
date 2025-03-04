default:
    @just --list --unsorted

host := `uname -n`
user := `whoami`

alias os := switch_os
alias ob := build_os
alias hs := home_switch
alias hb := home_build
alias u := update
alias uc := update_commit

# Build nixos
build_os:
    nh os build . -H {{ host }}

# Build nixos
switch_os:
    nh os switch . -H {{ host }}

# Switch home-manager
home_switch:
    nh home switch . -c {{ user }}@{{ host }}

# Build home-manager
home_build:
    nh home build . -c {{ user }}@{{ host }}

# Show flake output
show:
    nix flake show

# Commit flake.lock
commit_lock:
    git add flake.lock
    git commit -m "chore: update flake"

# Update flake
update:
    nix flake update

# Update flake and commit flake.lock
update_commit: update commit_lock

# Check flake
check:
    nix flake check

# Clean
clean:
    nh clean all --keep-since 7d

fix-mac:
    # Nix
    # if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    #   source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    # fi
    # End Nix
