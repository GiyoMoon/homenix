{
  kubernetes.resources.services.radarr = {
    metadata = {
      name = "radarr";
      namespace = "media";
    };
    spec = {
      selector = {
        app = "radarr";
      };
      ports = [
        {
          protocol = "TCP";
          port = 80;
          targetPort = 7878;
        }
      ];
    };
  };
}
