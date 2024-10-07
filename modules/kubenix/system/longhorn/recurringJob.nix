{
  kubernetes.resources.recurringJobs.backup = {
    metadata = {
      name = "backup";
      namespace = "longhorn-system";
    };
    spec = {
      # Daily at 04:00
      cron = "0 4 * * *";
      task = "backup";
      retain = 1;
      concurrency = 1;
    };
  };
}
