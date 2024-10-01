{
  kubernetes.resources.recurringJobs.backup = {
    metadata = {
      name = "backup";
      namespace = "longhorn-system";
    };
    spec = {
      # At 04:00 on Monday and Friday
      cron = "0 4 * * 1,5";
      task = "backup";
      retain = 2;
      concurrency = 1;
    };
  };
}
