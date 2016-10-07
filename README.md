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

This module can also ensure that all of your modules are at the latest versions or install
updates during a specified maintenance window.

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
if it is already installed, them modman will check for updates. 

However, you may find that you need to install to a non-default environment or directory,
need to pin to a specific version of a module, that you want to intall updates only during a 
specified maintenance window, and/or that you have dependancy conflicts and you need to ignore
dependancies. If you need all of these, then the most complicated usage of modman would be:

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

## Development

Development of modman takes place at https://github.com/jdshewey/modman. If you wish to contribute 
or have an issue to file, you may do so there.

## Release Notes

This module has not yet been released and is still in alpha
TODO:
 * Test version pinning
 * Test ignoring dependancies
 * Test non-default env
 * Test non-default target dir
 * Creat cron logic for maintenance window
