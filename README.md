# Modman

#### Table of Contents

1. [Description](#description)
1. [Setup](#setup)
1. [Usage](#usage)
1. [Development - Guide for contributing to the module](#development)

## Description

Modman is a Puppet module for managing Puppet modules. Perhaps you have multiple 
environments or locations and you need a puppet master for each location. If so, this module
can Puppetize the setup of the Puppet server in your new environment by installing any missing 
modules from a given list.

This module can also ensure that all of your modules are at the latest versions by installing
updates. While Code Manager or r10k can do this and much more, Code Manager requires a Puppet
Enterprise licese and r10k setup and management is extremely complicated. This is a much simpler 
system and can be thought of at Code Manager/r10k lite. It is perfect for those who are not 
coding much more than a basic module and are using mostly off-the-shelf Puppet Forge modules.

## Setup

To install modman, use

    puppet module install jdshewey-modman

## Usage

In it's least complicated usage, simply include the modman class in your main init.pp manifest
with a list of modules you want to install or keep up to date

```
class
{
         'modman':
                 modules => [
                         { name  => "crayfishx-firewalld"},
                         { name  => "puppetlabs-stdlib"}
                 ]
}
```

In the above example, if a module is not detected, the latest version will be installed. If it is
if it is already installed, then modman will check for updates. 

However, you may find that you need need to pin to a specific version of a module and/or that you 
have dependancy conflicts and you need to ignore dependancies. If you need all of these, then the
most complicated usage of modman would be:

```
class
{
        'modman':
                modules 	=> [
                        { name  => "puppetlabs-stdlib", version => "4.10" },  #try_get_value deprecated in version 4.12, but we require it
                        { name	=> "puppetlabs-firewall" },
                        { name 	=> "example42-nfs", ignore_dependancies => true }
                ]
}
```

Optionally, the ignore_dependancies and version options can be combined if needed.

## Development

Development of modman takes place at https://github.com/jdshewey/modman. If you wish to contribute 
or have an issue to file, you may do so there.

## Release Notes

 * We are planning to allow you to supply a cron-style time to the class to allow you to schedule the updates for a specific maintenance window
