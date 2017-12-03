defmodule Cryptofolio.CoinTest do
  use Cryptofolio.ModelCase

  alias Cryptofolio.Coin

  @valid_attrs %{name: "some name", total: 42, value: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Coin.changeset(%Coin{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Coin.changeset(%Coin{}, @invalid_attrs)
    refute changeset.valid?
  end
end
