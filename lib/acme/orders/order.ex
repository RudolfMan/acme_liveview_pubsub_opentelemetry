defmodule Acme.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :account_id, :integer
    field :status, Ecto.Enum, values: [placed: 1, shipped: 2, delivered: 3]

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:account_id, :status])
    |> validate_required([:account_id, :status])
  end
end
