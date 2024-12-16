{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.vscode-remote-workaround;
in {
  config = {
    systemd.user = {
      paths.vscode-remote-workaround = {
        wantedBy = ["default.target"];
        pathConfig.PathChanged = "%h/.vscode-server/bin";
      };

      services.vscode-remote-workaround.script = ''
        for i in ~/.vscode-server/bin/*; do
          echo "Fixing vscode-server in $i..."
          ln -sf ${pkgs.nodejs_23}/bin/node $i/node
        done
      '';
    };
  };
}
