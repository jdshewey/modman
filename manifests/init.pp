# Class: modman
# ===========================
#
# Full description of class modman here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'modman':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
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
	$target_dir = undef,
	$environment = undef,
	$modules = []
){
	each($modules) |$module|
	{
		$module_name = split($module['name'], '-')
		$module_path = get_module_path("${module_name[1]}")

		if ($module['ignore_dependancies'])
		{
			$ignore_dependancies = "--ignore-dependencies "
		}
                
		if has_key($module, 'version')
		{
			$version = "--version ${module['version']}"
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

