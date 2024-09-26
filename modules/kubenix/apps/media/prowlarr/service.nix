{
  kubernetes.resources.services.prowlarr = {
    metadata = {
      name = "prowlarr";
      namespace = "media";
    };
    spec = {
      selector = {
        app = "prowlarr";
      };
      ports = [
        {
          protocol = "TCP";
          port = 80;
          targetPort = 9696;
        }
      ];
    };
  };
}
