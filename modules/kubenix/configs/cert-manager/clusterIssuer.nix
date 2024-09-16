{ sops, ... }:
{
  kubernetes.resources.clusterIssuers.letsencrypt = {
    metadata = {
      name = "letsencrypt";
    };
    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory";
        email = "ref+file://" + sops.secrets.letsencrypt_email.path;
        privateKeySecretRef = {
          name = "letsencrypt";
        };
        solvers = [
          {
            dns01 = {
              cloudflare = {
                email = "ref+file://" + sops.secrets.cloudflare_email.path;
                apiTokenSecretRef = {
                  name = "cloudflare";
                  key = "api_key";
                };
              };
            };
            selector = {
              dnsZones = [ "jasi.app" ];
            };
          }
        ];
      };
    };
  };
}
