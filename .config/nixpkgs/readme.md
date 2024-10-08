# Nixos

To bootstrap a host:

in nixos:
```bash
nixos-rebuild --flake ~/path/to/flake/dir/#puerh switch
# this just chooses the first nixos config in the flake:
nixos-rebuild --flake . switch
# (ideally it should infer it from $USER@$HOST)
```

linux and macos:
```bash
# uses the default $USER@$HOST, as configured in this flake:
home-manager switch --flake .
```

macos (nix-darwin):
```bash
# http://daiderd.com/nix-darwin/#flakes
darwin-rebuild switch --flake ~/.config/nix-darwin

# or:
# nix --extra-experimental-features 'flakes nix-command' run nix-darwin -- switch --flake flake.nix
```

to upgrade packages/system:
(the `--upgrade` flag doesn't work on nixos-rebuild for flakes)
```bash
nix flake update .
```
which will update the `flake.lock` file

