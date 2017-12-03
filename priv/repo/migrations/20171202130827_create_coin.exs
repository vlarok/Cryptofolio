defmodule Cryptofolio.Repo.Migrations.CreateCoin do
  use Ecto.Migration

  def change do
    create table(:coins) do
      add :name, :string
      add :total, :integer
      add :value, :integer

      timestamps()
    end
  end
end
