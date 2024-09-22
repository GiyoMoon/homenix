{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mdadm
  ];

  boot.swraid = {
    enable = true;
    mdadmConf = ''
      ARRAY /dev/md0 level=raid1 num-devices=2 metadata=1.2 UUID=97d4f5d1:0792395f:c0449562:88039d0c devices=/dev/sda,/dev/sdb
      PROGRAM ${pkgs.coreutils}/bin/true
    '';
  };
  fileSystems = {
    # Mount only works if the ext4 filesystem is already created on the device
    # $ mkfs.ext4 /dev/md0
    "/mnt/hdd" = {
      device = "/dev/md0";
      fsType = "ext4";
      options = [
        "defaults"
        "nofail"
      ];
      noCheck = true;
    };
  };
}
