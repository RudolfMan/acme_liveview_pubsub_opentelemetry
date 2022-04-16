defmodule Acme.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Acme.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        account_id: 42,
        status: 42
      })
      |> Acme.Orders.create_order()

    order
  end
end
