defmodule AcmeWeb.OrderLive.Show do
  use AcmeWeb, :live_view

  alias Acme.Orders

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(Acme.PubSub, "orders:#{id}")

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:order, Orders.get_order!(id))}
  end

  @impl true
  def handle_info({:order_updated, order}, socket) do
    {:noreply, assign(socket, :order, order)}
  end

  defp page_title(:show), do: "Show Order"
  defp page_title(:edit), do: "Edit Order"
end
