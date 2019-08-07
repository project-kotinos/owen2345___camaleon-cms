#!/usr/bin/env bash
set -ex

systemctl start xvfb

export DEBIAN_FRONTEND=noninteractive
export BUNDLE_GEMFILE=$PWD/gemfiles/rails_4_2.gemfile

#before install
"echo 'gem: --no-document' > ~/.gemrc"
"echo '--colour' > ~/.rspec"
export DISPLAY=:99.0

#install
bundle install -j4

#script
bundle update rails
bundle exec rubocop
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rspec
