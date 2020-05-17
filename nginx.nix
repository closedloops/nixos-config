{ config, ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts."dir.xtian.us" = {
      enableACME = true;
      forceSSL = true;
      root = "/srv/www/dir.xtian.us/public_html";
      extraConfig = ''
        autoindex on;
        autoindex_exact_size off;
      '';
    };
  };

  security.acme.acceptTerms = true;
  security.acme.certs = {
    "dir.xtian.us".email = "hi@xtian.us";
  };
}
