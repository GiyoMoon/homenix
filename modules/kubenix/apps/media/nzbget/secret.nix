{ sops, ... }:
{
  kubernetes.resources.secrets = {
    nzbget-auth = {
      metadata = {
        namespace = "media";
      };
      stringData = {
        user = "ref+file://" + sops.secrets.nzbget_auth_user.path;
        password = "ref+file://" + sops.secrets.nzbget_auth_password.path;
      };
    };
  };
}
