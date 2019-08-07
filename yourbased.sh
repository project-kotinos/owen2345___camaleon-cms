#!/usr/bin/env bash
set -ex

export DEBIAN_FRONTEND=noninteractive
export BUNDLE_GEMFILE=$PWD/gemfiles/rails_6_0.gemfile

export CHROME_SOURCE_URL=https://dl.google.com/dl/linux/direct/google-chrome-stable_current_amd64.deb
wget --no-verbose -O /tmp/$(basename $CHROME_SOURCE_URL) $CHROME_SOURCE_URL
dpkg -i /tmp/$(basename $CHROME_SOURCE_URL)

#before install
echo 'gem: --no-document' > ~/.gemrc
echo '--colour' > ~/.rspec
export DISPLAY=:99.0

#install
gem install bundler
bundle install -j4

#script
bundle update rails
bundle exec rubocop
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rspec
