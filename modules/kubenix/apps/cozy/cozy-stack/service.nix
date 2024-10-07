{
  kubernetes.resources.services.cozy-stack = {
    metadata = {
      name = "cozy-stack";
      namespace = "cozy";
    };
    spec = {
      selector = {
        app = "cozy-stack";
      };
      ports = [
        {
          protocol = "TCP";
          port = 80;
          targetPort = 8080;
        }
      ];
    };
  };
}
