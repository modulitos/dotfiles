# Nixos

To bootstrap a host:

in nixos:
```bash
nixos-rebuild --flake .#name-of-nixos-config switch
# this just chooses the first nixos config in the flake:
nixos-rebuild --flake . switch
# (ideally it should infer it from $USER@$HOST)
```

linux:
```bash
# uses the default $USER@$HOST, as configured in this flake:
home-manager switch --flake .
```

to upgrade packages/system:
(the `--upgrade` flag doesn't work on nixos-rebuild for flakes)
```bash
nix flake update .
```
which will update the `flake.lock` file

