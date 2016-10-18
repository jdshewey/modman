# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# https://docs.puppet.com/guides/tests_smoke.html
#

class
{
        'modman':
                target_dir  => "/etc/puppet/environment/test"
                environment => "QA"
                modules     => [
                        { name  => "puppetlabs-stdlib", version => "4.10" },  #try_get_value deprecated in version 4.12, but we require it
                        { name  => "puppetlabs-firewall" },
                        { name  => "example42-nfs", ignore_dependancies => true }
                ]
}
