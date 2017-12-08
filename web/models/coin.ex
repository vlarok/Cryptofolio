defmodule Cryptofolio.Coin do
  use Cryptofolio.Web, :model

  schema "coins" do
    field :name, :string
    field :node, :integer
    field :total, :integer
    field :value, :integer
    field :earned, :integer
    field :invested, :integer
    field :all, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :node, :total, :value, :earned, :invested, :all])
    |> validate_required([:name, :node, :total, :value])
  end
end
