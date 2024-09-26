{
  kubernetes.resources.services.sonarr = {
    metadata = {
      name = "sonarr";
      namespace = "media";
    };
    spec = {
      selector = {
        app = "sonarr";
      };
      ports = [
        {
          protocol = "TCP";
          port = 80;
          targetPort = 8989;
        }
      ];
    };
  };
}
