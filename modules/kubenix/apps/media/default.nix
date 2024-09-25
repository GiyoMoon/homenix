{
  imports = [
    ./jellyfin
  ];

  kubernetes.resources.namespaces.media = { };
}
