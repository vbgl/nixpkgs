{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.services.routedns;
  settingsFormat = pkgs.formats.toml { };
in
{
  options.services.routedns = {
    enable = mkEnableOption "RouteDNS - DNS stub resolver, proxy and router";

    settings = mkOption {
      type = settingsFormat.type;
      example = literalExpression ''
        {
          resolvers.cloudflare-dot = {
            address = "1.1.1.1:853";
            protocol = "dot";
          };
          groups.cloudflare-cached = {
            type = "cache";
            resolvers = ["cloudflare-dot"];
          };
          listeners.local-udp = {
            address = "127.0.0.1:53";
            protocol = "udp";
            resolver = "cloudflare-cached";
          };
          listeners.local-tcp = {
            address = "127.0.0.1:53";
            protocol = "tcp";
            resolver = "cloudflare-cached";
          };
        }
      '';
      description = ''
        Configuration for RouteDNS, see <https://github.com/folbricht/routedns/blob/master/doc/configuration.md>
        for more information.
      '';
    };

    configFile = mkOption {
      default = settingsFormat.generate "routedns.toml" cfg.settings;
      defaultText = "A RouteDNS configuration file automatically generated by values from services.routedns.*";
      type = types.path;
      example = literalExpression ''"''${pkgs.routedns}/cmd/routedns/example-config/use-case-1.toml"'';
      description = "Path to RouteDNS TOML configuration file.";
    };

    package = mkPackageOption pkgs "routedns" { };
  };

  config = mkIf cfg.enable {
    systemd.services.routedns = {
      description = "RouteDNS - DNS stub resolver, proxy and router";
      after = [ "network.target" ]; # in case a bootstrap resolver is used, this might fail a few times until the respective server is actually reachable
      wantedBy = [ "multi-user.target" ];
      wants = [ "network.target" ];
      startLimitIntervalSec = 30;
      startLimitBurst = 5;
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = "5s";
        LimitNPROC = 512;
        LimitNOFILE = 1048576;
        DynamicUser = true;
        AmbientCapabilities = "CAP_NET_BIND_SERVICE";
        NoNewPrivileges = true;
        ExecStart = "${getBin cfg.package}/bin/routedns -l 4 ${cfg.configFile}";
      };
    };
  };
  meta.maintainers = with maintainers; [ jsimonetti ];
}
