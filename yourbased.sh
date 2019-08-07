#!/usr/bin/env bash
set -ex

export DEBIAN_FRONTEND=noninteractive
export BUNDLE_GEMFILE=$PWD/gemfiles/rails_6_0.gemfile

#before install
echo 'gem: --no-document' > ~/.gemrc
echo '--colour' > ~/.rspec
export DISPLAY=:99.0

#install
gem install tzinfo-data
gem install bundler
bundle install -j4

#script
bundle update rails
bundle exec rubocop
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rspec
