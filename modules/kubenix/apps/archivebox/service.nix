{
  kubernetes.resources.services.archivebox = {
    metadata = {
      name = "archivebox";
      namespace = "archivebox";
    };
    spec = {
      selector = {
        app = "archivebox";
      };
      ports = [
        {
          protocol = "TCP";
          port = 80;
          targetPort = 8000;
        }
      ];
    };
  };
}
