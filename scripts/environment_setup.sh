#!/bin/bash
apt-get update && apt-get -y install postgresql-client
mix local.hex --force
mix local.rebar --force
mix deps.get
mix deps.compile

# Voir db seed par defaut
# mix ecto.create
# mix ecto.migrate
