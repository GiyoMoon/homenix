{
  kubernetes.resources.services.nzbget = {
    metadata = {
      name = "nzbget";
      namespace = "media";
    };
    spec = {
      selector = {
        app = "nzbget";
      };
      ports = [
        {
          protocol = "TCP";
          port = 80;
          targetPort = 6789;
        }
      ];
    };
  };
}
