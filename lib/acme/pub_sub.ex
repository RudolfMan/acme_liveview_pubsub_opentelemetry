defmodule Acme.PubSub do
  defmodule Event do
    defstruct [:message, :span_ctx]
  end

  defmacro __using__(_opts) do
    quote do
      def handle_info(%Acme.PubSub.Event{} = event, socket) do
        require OpenTelemetry.Tracer

        OpenTelemetry.Tracer.set_current_span(event.span_ctx)
        opts = %{attributes: %{handler: inspect(__ENV__.module)}}

        OpenTelemetry.Tracer.with_span "acme:handle_event", opts do
          handle_info(event.message, socket)
        end
      end
    end
  end

  defmacro broadcast(topic, message) do
    quote do
      current_function = Acme.PubSub.current_function(__ENV__)
      Acme.PubSub.broadcast_from_function(unquote(topic), unquote(message), current_function)
    end
  end

  def broadcast_from_function(topic, message, function_name) do
    require OpenTelemetry.Tracer

    opts = %{attributes: %{broadcaster: function_name}}

    OpenTelemetry.Tracer.with_span "acme.pubsub:broadcast", opts do
      event = %Event{message: message, span_ctx: OpenTelemetry.Tracer.current_span_ctx()}
      Phoenix.PubSub.broadcast(__MODULE__, topic, event)
    end
  end

  def current_function(env) do
    {fun, arity} = env.function
    "#{inspect(env.module)}.#{fun}/#{arity}"
  end
end
