# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  networking.hostName = "closedloops-nanode"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  networking.usePredictableInterfaceNames = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time.timeZone = "America/Denver";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bash
    docker
    git
    nginx
    vim
    
    # Debug packages from Linode tutorial
    inetutils
    mtr
    sysstat
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.longview = {
    enable = true;
    apiKeyFile = "/var/lib/longview/apiKeyFile";
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  security.sudo.wheelNeedsPassword = false;

  users.users.abau = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjj37CtVDII+e1zWQYTGEvs4eNXHt2G8pTFfvlrQC0i/V1cAk5UtbXgbaBYFTGwzoacp8X+0uI9lIvd/pxbCoRmbVNOkZluBZpzYRjyDMmDlzcB9a6GirBI3v5yEbZImH42SDrxDr1MTnd3gzVYlNiibHBh7DhDsY0Z/CsmSaJJcEzJ58l7fFmlhQGwVmk9GHdUm3RJLu3/7d3IQ/SZoXy6eu7EY4J2Xmcm7Cpk5GsQhiVs/DlFj2XUGEWMm8ENaE+qT7LVpKAYGc1/m8DCyg2qhpzjPGtGugxWxUAVFIX+B+xMAfo+mBn54ar9iTiWENWj2YXGAX+gzl8GvBG2vReF8zGpdEQFVv9/JQXfJ9jfm9CRIpAmad+S9vtZ+i0rYVbqS49kp1U6GMqtXFVglNMudxBd3cgUVk/vATFu+G0ZXP6JwpLjD1Q2wO4KB2ct73p2qyjpplRHHrfA+kWLsSZZ1OYcu7cCTMk6bkAVNzl/t9U2nRG9XY7umY8J9RRllHiIS8cQmz00mC0pyvlyu9hOgwkooeP/eDfKdZocx8+IyVgDMn9Ojk7zAma52nK7hBL4wLhftle6zr7uxkpOmSRkp8WDZkuMVCucipl4f7Z/dgRGlYmyCDCY8EelAmt2gemd4TM7p6tHQmEiKLe1zng4SDbT6AILcWlKQ5MItYxww== alexbaumhoer@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrjUw5IHfQQlHpEDP/IHtUW0CHlDz39vkprhuiNrcSkypqNBI8TlZtGBZ4xzQLNzsnjvPeyJbWDlExxbSFxTx04iekHY2tm2GSVqust3DtyI0Djjo1AE7TLl76OD1cdoq7DU1nSa1LCGS6cKFKBmwt1gDMQPJnD8KcYRBULOvs94GntWxFlVzy3/j6VMn17HH6goKsRlsNvln2VnJ9AEVoUcbgJkaK3RTpKdJvobQ3f0fiI3okLZcX/5gG2rSAARIQn7cCISb7KcLkl2Lx9s1E8/e57FkyQptB1k2iBN3UNpDwGOu9EvhxVEP9nrzC37RDiNCT7oBRJFFKIWi/io7f alexbaumhoer@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA1ZQmRW5mYl1yKSlPRpsMlKvxu4tDIK7XWZFNRfesJVQrPQ69KFdmWydekmAEWA+P6o5pueP8DCrCF3P+zblsYwjIPkKRfCERLMxqDAHQjUQAXD1+OIdURTq3xd2Xu0FJKjUrR0wc9/1t2qPa8YvSAAc05kr3IGZMIkS2a/BQyNxxUcnvPvgNVQTCgSVCjORm+fVmElTmAAusiKA3YqnYJqxKW7hsxLWin0rw+LN/nYCSrfl+trvcZtamdkj7KsuJt7fgp6THhvk/mpwjGKVByEzl6ZPcfhx2heRJJaqgxeNqxyrkB3xucNLHMwdsqtzkniCJC5Cy09MGW9ewGnMVfQ== rsa-key-20160225"
    ];
  };

  users.users.xtian = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILE/LhXpi1E1ggGKBfbgFUp3AIOFTrNrvkAYiJJ8cVuQ hi@xtian.us" ];
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}

