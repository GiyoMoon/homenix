{ sops, ... }:
{
  kubernetes.resources.secrets.enclosed = {
    metadata = {
      name = "enclosed";
      namespace = "enclosed";
    };
    stringData = {
      jwt_secret = "ref+file://" + sops.secrets.enclosed_jwt_secret.path;
    };
  };
}
