{
  lib,
  meta,
  ...
}:
{
  nix.settings = {
    auto-optimise-store = true;
    builders-use-substitutes = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  documentation = {
    man.enable = lib.mkDefault false;
    nixos.enable = lib.mkDefault false;
  };

  services.openssh = {
    enable = lib.mkDefault true;
    settings = {
      X11Forwarding = lib.mkDefault true;
      PermitRootLogin = lib.mkDefault "yes";
    };
    openFirewall = lib.mkDefault true;
  };

  networking.hostName = meta.hostname;

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGuqO1wNDEdQ8nSxDzcKFXhLQAaaFKAAOV+OX/Sk0WoO lima-vm"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKokeEDCkwISIkctnn5TkjMbJa+h/rq2Ek/0dN9LIHjF macbook"
    ];
  };

  system.stateVersion = "24.05";
}
