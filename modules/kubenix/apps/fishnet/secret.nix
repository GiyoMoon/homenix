{ sops, ... }:
{
  kubernetes.resources.secrets.fishnet = {
    metadata = {
      name = "fishnet";
      namespace = "fishnet";
    };
    stringData = {
      fishnet_private_key = "ref+file://" + sops.secrets.fishnet_private_key.path;
    };
  };
}
