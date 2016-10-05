module Puppet::Parser::Functions
  newfunction(:check_module, :type =>:rvalue, :doc => <<-EOT
    Returns the absolute path of the specified module for the current
    environment.

    Example:
      $module_path = check_module('stdlib')
  EOT
  ) do |args|
    raise(Puppet::ParseError, "check_module(): Wrong number of arguments, expects one") unless args.size == 1
    if module_path = Puppet::Module.find(args[0], compiler.environment.to_s)
      module_path.path
    end
  end
end
