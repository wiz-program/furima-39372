#!/usr/bin/env bash
# exit on error
set -o errexit

export RAILS_ENV=production

bundle install
yarn install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate