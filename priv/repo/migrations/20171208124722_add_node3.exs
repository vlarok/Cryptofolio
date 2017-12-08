defmodule Cryptofolio.Repo.Migrations.AddNode3 do
  use Ecto.Migration

  def change do
    alter table(:coins) do
      add :earned, :integer
      add :invested, :integer
    end
  end
end
