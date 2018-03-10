#!/usr/bin/env ruby
require 'bundler/setup'
require 'fileutils'

def shell(cmd)
  puts cmd
  fail "#{cmd} failed" unless system(cmd)
end

name = 'acquiadrush'


# TODO Get all this from the current Git tag instead.
major_ver = '9'
version = '9.2.1-acquia1'

file = version
Dir.chdir('..') do
  shell("composer install --no-dev --no-plugins --no-scripts")
end

cmd = 'fpm'
# dir in, deb out
cmd << ' -s dir -t deb'
file = '.'

cmd << ' --architecture all'
cmd << " --name #{name}#{major_ver}"
cmd << " --version #{version}"
cmd << " --vendor 'Acquia, Inc.'"
cmd << ' --license GPL-2.0+'
cmd << ' --url https://github.com/acquia/fields'
cmd << " --prefix /usr/local/drush#{major_ver}"
cmd << ' --exclude acquia'
cmd << ' --exclude acquia/*'
cmd << ' --chdir ..'
cmd << " #{file}"
shell(cmd)
