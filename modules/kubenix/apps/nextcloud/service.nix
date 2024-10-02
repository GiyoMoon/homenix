{
  kubernetes.resources.services.nextcloud = {
    metadata = {
      name = "nextcloud";
      namespace = "nextcloud";
    };
    spec = {
      selector = {
        app = "nextcloud";
      };
      ports = [
        {
          protocol = "TCP";
          port = 80;
          targetPort = 80;
        }
      ];
    };
  };
}
