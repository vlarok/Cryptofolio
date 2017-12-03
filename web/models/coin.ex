defmodule Cryptofolio.Coin do
  use Cryptofolio.Web, :model

  schema "coins" do
    field :name, :string
    field :total, :integer
    field :value, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :total, :value])
    |> validate_required([:name, :total, :value])
  end
end
