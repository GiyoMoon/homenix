{
  kubernetes.resources.services.enclosed = {
    metadata = {
      name = "enclosed";
      namespace = "enclosed";
    };
    spec = {
      selector = {
        app = "enclosed";
      };
      ports = [
        {
          protocol = "TCP";
          port = 80;
          targetPort = 8787;
        }
      ];
    };
  };
}
