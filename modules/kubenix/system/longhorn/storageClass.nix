{
  kubernetes.resources.storageClasses = {
    longhorn-ssd = {
      metadata = {
        name = "longhorn-ssd";
      };
      provisioner = "driver.longhorn.io";
      allowVolumeExpansion = true;
      parameters = {
        numberOfReplicas = "1";
        diskSelector = "ssd";
      };
    };
    longhorn-hdd = {
      metadata = {
        name = "longhorn-hdd";
      };
      provisioner = "driver.longhorn.io";
      allowVolumeExpansion = true;
      parameters = {
        numberOfReplicas = "1";
        diskSelector = "hdd";
      };
    };
  };
}
