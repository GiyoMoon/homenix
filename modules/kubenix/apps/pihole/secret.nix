{ sops, ... }:
{
  kubernetes.resources.secrets = {
    pihole-auth = {
      metadata = {
        namespace = "pihole";
      };
      stringData = {
        password = "ref+file://" + sops.secrets.pihole_password.path;
      };
    };
  };
}
