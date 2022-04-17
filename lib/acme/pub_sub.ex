defmodule Acme.PubSub do
  defmodule Event do
    defstruct [:message, :span_ctx]
  end

  defmacro __using__(_opts) do
    quote do
      def handle_info(%Acme.PubSub.Event{} = event, socket) do
        OpenTelemetry.Tracer.set_current_span(event.span_ctx)
        handle_info(event.message, socket)
      end
    end
  end

  def broadcast(topic, message) do
    require OpenTelemetry.Tracer

    OpenTelemetry.Tracer.with_span "acme.pubsub:broadcast" do
      event = %Event{message: message, span_ctx: OpenTelemetry.Tracer.current_span_ctx()}
      Phoenix.PubSub.broadcast(__MODULE__, topic, event)
    end
  end
end
