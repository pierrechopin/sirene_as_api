#!/bin/sh
set -e
rm -f /docker_build/tmp/pids/server.pid
export RAILS_ENV=production
bundle exec rake sunspot:solr:start
exec "$@"
