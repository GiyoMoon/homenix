{ sops, ... }:
{
  kubernetes.resources.secrets = {
    longhorn-backup = {
      metadata = {
        namespace = "longhorn-system";
      };
      stringData = {
        CIFS_USERNAME = "ref+file://" + sops.secrets.longhorn_backup_username.path;
        CIFS_PASSWORD = "ref+file://" + sops.secrets.longhorn_backup_password.path;
      };
    };
  };
}
