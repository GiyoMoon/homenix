{
  imports = [
    ./jellyfin
    ./jellyseerr
    ./nzbget
    ./prowlarr
    ./radarr
    ./sonarr
    # ./tdarr
  ];

  kubernetes.resources.namespaces.media = { };
}
