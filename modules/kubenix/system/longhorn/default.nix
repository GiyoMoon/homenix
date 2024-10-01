{
  imports = [
    ./chart.nix
    ./ingressRoute.nix
    ./recurringJob.nix
    ./secret.nix
    ./storageClass.nix
  ];

  kubernetes = {
    resources.namespaces.longhorn-system = { };
    customTypes = [
      {
        attrName = "recurringJobs";
        group = "longhorn.io";
        kind = "RecurringJob";
        version = "v1beta1";
      }
    ];
  };
}
