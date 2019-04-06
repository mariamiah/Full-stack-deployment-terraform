#!/usr/bin/env bash

set -x
# Install postgresql inorder to configure the database server
function add_postgres {
  sudo apt-get update -y
  sudo apt-get install postgresql postgresql-contrib -y
  sudo sed -i "s/#listen_address.*/listen_addresses '*'/" /etc/postgresql/10/main/postgresql.conf
  sudo -u postgres psql postgres --command  '\password 123'
  sudo service postgresql restart
  sudo -u postgres createdb storemanagerdb
}

add_postgres