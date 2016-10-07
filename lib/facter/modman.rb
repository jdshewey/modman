Facter.add('modman_cron_hour') do
  setcode do
    Facter::Core::Execution.exec('/bin/date +%H')
  end
end
Facter.add('modman_cron_day') do
  setcode do
    Facter::Core::Execution.exec('/bin/date +%d')
  end
end
Facter.add('modman_cron_month') do
  setcode do
    Facter::Core::Execution.exec('/bin/date +,%m')
  end
end
Facter.add('modman_cron_day_of_week') do
  setcode do
    Facter::Core::Execution.exec('/bin/expr `date +%u` - 1')
  end
end
