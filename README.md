See blog post [N+1 problem by misusing Phoenix PubSub and how to spot it with OpenTelemetry.](https://manusachi.com/blog/n%2B1-with-pubsub-liveviews-detect-with-open-telemetry)

Start Zipkin

```shell
docker run -d -p 9411:9411 openzipkin/zipkin
```

Set `OTEL_SERVICE_NAME` environment variable

```shell
export OTEL_SERVICE_NAME=acme
```

Start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000/orders`](http://localhost:4000/orders).
  * Create an order.
  * Open the order page in multpile browser windows (to get multiple concurrent liveview connections established).
  * Edit the order in one window and confirm that it was updated in other windows.
  * Go to Zipkin [`localhost:9411/zipkin`](http://localhost:9411/zipkin).
  * Add tagQuery in search `tagQuery=broadcaster` and Run Query.
  * Observe traces and spands.


## Learn more

  * Official OpenTelemetry website: https://opentelemetry.io
  * Official Zipkin website: https://zipkin.io
  * Official phoenix website: https://www.phoenixframework.org/
  * Phoenix guides: https://hexdocs.pm/phoenix/overview.html
  * Phoenix docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
