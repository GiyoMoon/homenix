{ ... }:

{
  sops.defaultSopsFile = ../secrets/secrets.json;
  sops.defaultSopsFormat = "json";

  sops.secrets.k3s_token = { };
}
