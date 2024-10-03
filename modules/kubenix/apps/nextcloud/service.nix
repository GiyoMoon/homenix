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
          port = 443;
          targetPort = 443;
        }
      ];
    };
  };
}
