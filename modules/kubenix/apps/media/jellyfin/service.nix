{
  kubernetes.resources.services = {
    jellyfin-tcp = {
      metadata = {
        name = "jellyfin-tcp";
        namespace = "media";
        annotations = {
          "metallb.universe.tf/allow-shared-ip" = "jellyfin";
        };
      };
      spec = {
        selector = {
          app = "jellyfin";
        };
        ports = [
          {
            port = 80;
            targetPort = 8096;
            name = "http-tcp";
            protocol = "TCP";
          }
          {
            port = 8920;
            targetPort = 8920;
            name = "https-tcp";
            protocol = "TCP";
          }
        ];
        sessionAffinity = "ClientIP";
      };
    };
    jellyfin-udp = {
      metadata = {
        name = "jellyfin-udp";
        namespace = "media";
        annotations = {
          "metallb.universe.tf/allow-shared-ip" = "jellyfin";
        };
      };
      spec = {
        selector = {
          app = "jellyfin";
        };
        ports = [
          {
            port = 1900;
            targetPort = 1900;
            name = "dlna-udp";
            protocol = "UDP";
          }
          {
            port = 7359;
            targetPort = 7359;
            name = "discovery-udp";
            protocol = "UDP";
          }
        ];
        sessionAffinity = "ClientIP";
      };
    };
  };
}
