# Class: modman
# ===========================
#
# Modman is a Puppet module for managing Puppet modules. Perhaps you 
# have multiple environments or locations and you need a puppet master for 
# each location. If so, this module can Puppetize the setup of the Puppet 
# server in your new environment by installing any missing modules from a 
# given list.
#
# This module can also ensure that all of your modules are at the latest 
# versions by installing updates
#
# Examples
# --------
#
# @example
#
# class
# {
#   'modman':
#      modules         => [
#              { name  => "puppetlabs-stdlib", version => "4.10" },  #try_get_value deprecated in version 4.12, but we require it
#              { name  => "puppetlabs-firewall" },
#              { name  => "example42-nfs", ignore_dependancies => true }
#      ]
# }
#
# Authors
# -------
#
# James Shewey <jdshewey@gmail.com>
#
# Copyright
# ---------
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org>
#

class modman (
	$modules = []
){
	each($modules) |$module|
	{
		$module_name = split($module['name'], '-')
		$module_path = check_module("${module_name[1]}")

		if ($module['ignore_dependancies'])
		{
			$ignore_dependancies = "--ignore-dependencies "
		}
                
		if has_key($module, 'version')
		{
			$version = "--version ${module['version']} "
		}

		if ( $module_path == undef )
		{
			exec
			{
				"bash -c \"`source ~/.bash_profile >> /dev/null; which puppet` module install ${ignore_dependancies}${version}${module['name']}\"":
					logoutput	=> on_failure,
					path		=> [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ]
			}

		}
		else
		{                        
			exec
			{
				"bash -c \"`source ~/.bash_profile >> /dev/null; which puppet` module upgrade ${ignore_dependancies}${version}${module['name']}\"":
					logoutput	=> on_failure,
					path		=> [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ]
			}
		}
	}
}

