#! /usr/bin/env ruby -S rspec
require 'spec_helper_acceptance'

describe 'check_module function', :unless => UNSUPPORTED_PLATFORMS.include?(fact('operatingsystem')) do
  describe 'success' do
    it 'check_modules dne' do
      pp = <<-EOS
      $a = $::is_pe ? {
        'true'  => '/etc/puppetlabs/puppet/modules/dne',
        'false' => '/etc/puppet/modules/dne',
      }
      $o = check_module('dne')
      if $o == $a {
        notify { 'output correct': }
      } else {
        notify { "failed; module path is '$o'": }
      }
      EOS

      apply_manifest(pp, :expect_failures => true)
    end
  end
  describe 'failure' do
    it 'handles improper argument counts'
    it 'handles non-numbers'
  end
end
