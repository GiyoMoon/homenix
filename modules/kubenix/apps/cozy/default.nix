{
  imports = [
    ./couchdb
    ./cozy-stack
  ];

  kubernetes.resources.namespaces.cozy = { };
}
