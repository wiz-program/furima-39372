#!/usr/bin/env bash
# exit on error
set -o errexit

export RAILS_ENV=production
# Webpack 4（Webpacker 5）は Node 17+ の OpenSSL 3 と非互換
export NODE_OPTIONS=--openssl-legacy-provider

bundle install
yarn install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate