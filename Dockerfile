FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

COPY shorty/mix.exs .
COPY shorty/mix.lock .

RUN mkdir assets

COPY shorty/assets/package.json assets
COPY shorty/assets/package-lock.json assets

CMD mix deps.get && cd assets && npm install && cd ..