# ./Dockerfile

FROM elixir:1.9.0-slim
RUN apt-get update \
&& apt-get install -y inotify-tools \
&& apt-get install --yes postgresql-client 
ADD . /app
RUN mix local.rebar
RUN mix local.hex --force
WORKDIR /app
EXPOSE 4000
RUN mix deps.get
RUN mix deps.compile
ENTRYPOINT ["./entrypoint.sh"]

