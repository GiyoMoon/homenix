{
  kubernetes.resources.persistentVolumeClaims.pihole = {
    metadata = {
      name = "pihole";
      namespace = "pihole";
    };
    spec = {
      accessModes = [ "ReadWriteOnce" ];
      storageClassName = "longhorn-ssd";
      resources = {
        requests = {
          storage = "10Gi";
        };
      };
    };
  };
}
