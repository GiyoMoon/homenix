{
  kubernetes.resources.deployments.jellyfin = {
    metadata = {
      name = "jellyfin";
      namespace = "media";
    };
    spec = {
      replicas = 1;
      strategy = {
        type = "RollingUpdate";
        rollingUpdate = {
          maxSurge = 1;
          maxUnavailable = 1;
        };
      };
      selector = {
        matchLabels = {
          app = "jellyfin";
        };
      };
      template = {
        metadata = {
          labels = {
            app = "jellyfin";
          };
        };
        spec = {
          affinity = {
            nodeAffinity = {
              requiredDuringSchedulingIgnoredDuringExecution = {
                nodeSelectorTerms = [
                  {
                    matchExpressions = [
                      {
                        key = "kubernetes.io/hostname";
                        operator = "In";
                        values = [ "node3" ];
                      }
                    ];
                  }
                ];
              };
            };
          };
          volumes = [
            {
              name = "jellyfin-config";
              persistentVolumeClaim = {
                claimName = "jellyfin-config";
              };
            }
            {
              name = "jellyfin-data";
              persistentVolumeClaim = {
                claimName = "jellyfin-data";
              };
            }
            # {
            #   name = "device-dri";
            #   hostPath = {
            #     path = "/dev/dri";
            #   };
            # }
            # {
            #   name = "device-dma-heap";
            #   hostPath = {
            #     path = "/dev/dma_heap";
            #   };
            # }
            # {
            #   name = "device-mali";
            #   hostPath = {
            #     path = "/dev/mali0";
            #   };
            # }
            # {
            #   name = "device-rga";
            #   hostPath = {
            #     path = "/dev/rga";
            #   };
            # }
            # {
            #   name = "device-mpp-service";
            #   hostPath = {
            #     path = "/dev/mpp_service";
            #   };
            # }
          ];
          containers = [
            {
              name = "jellyfin";
              image = "ghcr.io/linuxserver/jellyfin:10.9.11@sha256:50e541e59ef6b3adc667eee4eeb0c88af09cad46ac15a7e66cf335dfd2cc05bf";
              imagePullPolicy = "Always";
              ports = [
                {
                  containerPort = 8096;
                  name = "http-tcp";
                  protocol = "TCP";
                }
                {
                  containerPort = 8920;
                  name = "https-tcp";
                  protocol = "TCP";
                }
                {
                  containerPort = 1900;
                  name = "dlna-udp";
                  protocol = "UDP";
                }
                {
                  containerPort = 7359;
                  name = "discovery-udp";
                  protocol = "UDP";
                }
              ];
              env = [
                {
                  name = "JELLYFIN_PublishedServerUrl";
                  value = "https://jellyfin.jasi.app";
                }
                {
                  name = "PGID";
                  value = "\\x36\\x35\\x35\\x34\\x31"; # ASCII codes for '65541'
                }
                {
                  name = "PUID";
                  value = "\\x31\\x30\\x34\\x34"; # ASCII codes for '1044'
                }
                {
                  name = "TZ";
                  value = "Europe/Zurich";
                }
              ];
              securityContext = {
                privileged = true;
              };
              resources = { };
              stdin = true;
              tty = true;
              volumeMounts = [
                {
                  mountPath = "/config";
                  name = "jellyfin-config";
                }
                {
                  mountPath = "/data";
                  name = "jellyfin-data";
                }
                # {
                #   mountPath = "/dev/dri";
                #   name = "device-dri";
                # }
                # {
                #   mountPath = "/dev/dma_heap";
                #   name = "device-dma-heap";
                # }
                # {
                #   mountPath = "/dev/mali0";
                #   name = "device-mali";
                # }
                # {
                #   mountPath = "/dev/rga";
                #   name = "device-rga";
                # }
                # {
                #   mountPath = "/dev/mpp_service";
                #   name = "device-mpp-service";
                # }
              ];
            }
          ];
          dnsPolicy = "ClusterFirst";
          restartPolicy = "Always";
        };
      };
    };
  };
}
