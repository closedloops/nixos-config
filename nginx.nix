{ config, ... }:

let
  enableACME = true;
  forceSSL = true;
in
{
  security.acme = {
    acceptTerms = true;
    email = "hi@xtian.us";
    certs = {
      "alexbaumhoer.com".email = "alexbaumhoer@gmail.com";
      "katepembrooke.com".email = "alexbaumhoer@gmail.com";
    };
  };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."default" = {
      default = true;
      root = "/srv/www/default";
    };

    virtualHosts."alexbaumhoer.com" = {
      inherit enableACME forceSSL;
      serverAliases = [ "www.alexbaumhoer.com" ];
      root = "/srv/www/alexbaumhoer.com";
    };

    virtualHosts."dir.xtian.us" = {
      inherit enableACME forceSSL;
      root = "/srv/www/dir.xtian.us";
      extraConfig = ''
        autoindex on;
        autoindex_exact_size off;
      '';
    };

    virtualHosts."katepembrooke.com" = {
      inherit enableACME forceSSL;
      serverAliases = [ "www.katepembrooke.com" ];
      root = "/srv/www/katepembrooke.com";
    };

    virtualHosts."xtian.us" = {
      inherit enableACME forceSSL;
      serverAliases = [ "www.xtian.us" ];
      root = "/srv/www/xtian.us";
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
