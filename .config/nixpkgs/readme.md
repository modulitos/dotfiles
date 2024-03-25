# Nixos

To bootstrap a host:

in nixos:
```bash
nixos-rebuild --flake . switch
```

linux:
```bash
home-manager switch --flake .
```

to upgrade packages/system:
(the `--upgrade` flag doesn't work on nixos-rebuild for flakes)
```bash
nix flake update .
```
which will update the `flake.lock` file

