#!/bin/bash
cd /var/app/staging
gem install bundler -v 2.6.2
bundle config set --local deployment true
bundle install --path vendor/bundle
