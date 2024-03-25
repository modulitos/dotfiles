{ config, pkgs, lib, ... }:

# Regularly check the battery status and send a notification when it discharges
# below certain thresholds.
# Implemented by calling the `acpi` program regularly. This is the simpler and
# safer approach because the battery might not send discharging events.

let conf = config.modules.battery_monitor;

in {
  options.modules.battery_monitor = with lib; {
    enable = mkEnableOption "battery_monitor";
  };

  # https://github.com/Julow/env/blob/master/modules/battery_monitor.nix
  config = lib.mkIf conf.enable {
    # Regularly check battery status
    #
    # systemctl --user status battery_monitor
    systemd.user.services.battery_monitor = {
      wantedBy = [ "default.target" ];
      description = "battery monitor.";
      script = ''
        prev_val=100
        check () { [[ $1 -ge $val ]] && [[ $1 -lt $prev_val ]]; }
        notify () {
          ${pkgs.libnotify}/bin/notify-send -a Battery "$@" \
            -h "int:value:$val" "Discharging, $val%, $remaining."
        }
        while true; do
          # eg bat0: "Battery 0: Discharging, 99%, 01:23:45"
          IFS=: read _ bat0 < <(${pkgs.acpi}/bin/acpi -b)
          # `<<<"$bat0"` is equal to `< <(echo "$bat0")`:
          IFS=\ , read status val remaining <<<"$bat0"
          val=''${val%\%}
          # eg: "val: 99, prev_val: 100, status: Discharging, remaining: 01:23:45"
          # echo "running battery monitor: val: $val, prev_val: $prev_val, status: $status, remaining: $remaining"
          if [[ $status = Discharging ]]; then
            echo "$val%, $remaining"
            if check 70 || check 50 || check 30 || check 25 || check 20; then notify
            elif check 15 || [[ $val -le 10 ]]; then notify -u critical
            fi
          fi
          prev_val=$val
          # Sleep longer when battery is high to save CPU
          if [[ $val -gt 30 ]]; then sleep 10m; elif [[ $val -ge 20 ]]; then sleep 5m; else sleep 1m; fi
        done
      '';
    };

  };
}
