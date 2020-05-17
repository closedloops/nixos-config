{ config, ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts."default" = {
      default = true;
      root = "/srv/www/default";
    };

    virtualHosts."alexbaumhoer.com" = {
      serverAliases = [ "www.alexbaumhoer.com" ];
      enableACME = true;
      forceSSL = true;
      root = "/srv/www/alexbaumhoer.com";
    };

    virtualHosts."dir.xtian.us" = {
      enableACME = true;
      forceSSL = true;
      root = "/srv/www/dir.xtian.us";
      extraConfig = ''
        autoindex on;
        autoindex_exact_size off;
      '';
    };

    virtualHosts."katepembrooke.com" = {
      serverAliases = [ "www.katepembrooke.com" ];
      enableACME = true;
      forceSSL = true;
      root = "/srv/www/katepembrooke.com";
    };

    virtualHosts."xtian.us" = {
      serverAliases = [ "www.xtian.us" ];
      enableACME = true;
      forceSSL = true;
      root = "/srv/www/xtian.us";
    };
  };

  security.acme.acceptTerms = true;
  security.acme.certs = {
    "alexbaumhoer.com".email = "alexbaumhoer@gmail.com";
    "dir.xtian.us".email = "hi@xtian.us";
    "katepembrooke.com".email = "alexbaumhoer@gmail.com";
    "xtian.us".email = "hi@xtian.us";
  };
}
