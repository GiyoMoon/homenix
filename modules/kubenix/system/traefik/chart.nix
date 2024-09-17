{ pkgs, inputs, ... }:
{
  kubernetes.helm.releases.traefik = {
    chart = pkgs.stdenvNoCC.mkDerivation {
      name = "traefik";
      src = inputs.traefik-chart;
      buildCommand = ''
        cp -r $src/traefik/ $out
      '';
    };
    namespace = "traefik";
    includeCRDs = true;
    values = {
      globalArguments = [
        "--global.sendanonymoususage=false"
        "--global.checknewversion=false"
      ];
      additionalArguments = [
        "--serversTransport.insecureSkipVerify=true"
        "--log.level=DEBUG"
      ];
      deployment = {
        enabled = true;
        replicas = 1;
        annotations = { };
        podAnnotations = { };
        additionalContainers = [ ];
        initContainers = [ ];
      };
      ports = {
        web = {
          redirectTo = {
            port = "websecure";
            priority = 10;
          };
        };
        websecure = {
          http3 = {
            enabled = true;
          };
          advertisedPort = 4443;
          tls = {
            enabled = true;
          };
        };
      };
      ingressRoute = {
        dashboard = {
          enabled = false;
        };
      };
      providers = {
        kubernetesCRD = {
          enabled = true;
          ingressClass = "traefik-external";
          allowExternalNameServices = true;
        };
        kubernetesIngress = {
          enabled = true;
          allowExternalNameServices = true;
          publishedService = {
            enabled = false;
          };
        };
      };
      rbac = {
        enabled = true;
      };
      service = {
        enabled = true;
        type = "LoadBalancer";
        annotations = { };
        labels = { };
        spec = {
          loadBalancerIP = "192.168.30.80";
        };
        loadBalancerSourceRanges = [ ];
        externalIPs = [ ];
      };
    };
  };
}
