defmodule Cryptofolio.Repo.Migrations.AddNode2 do
  use Ecto.Migration

  def change do
    alter table(:coins) do
      add :node, :integer
    end
  end
end
