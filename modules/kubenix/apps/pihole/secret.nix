{ sops, ... }:
{
  kubernetes.resources.secrets.pihole-auth = {
    metadata = {
      name = "pihole-auth";
      namespace = "pihole";
    };
    stringData = {
      password = "ref+file://" + sops.secrets.pihole_password.path;
    };
  };
}
