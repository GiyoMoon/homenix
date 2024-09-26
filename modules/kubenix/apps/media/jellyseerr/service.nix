{
  kubernetes.resources.services.jellyseerr = {
    metadata = {
      name = "jellyseerr";
      namespace = "media";
    };
    spec = {
      selector = {
        app = "jellyseerr";
      };
      ports = [
        {
          protocol = "TCP";
          port = 80;
          targetPort = 5055;
        }
      ];
    };
  };
}
