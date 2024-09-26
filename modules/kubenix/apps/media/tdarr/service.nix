{
  kubernetes.resources.services.tdarr = {
    metadata = {
      name = "tdarr";
      namespace = "media";
    };
    spec = {
      selector = {
        app = "tdarr";
      };
      ports = [
        {
          protocol = "TCP";
          port = 80;
          targetPort = 8265;
        }
      ];
    };
  };
}
