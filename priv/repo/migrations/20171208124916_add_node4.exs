defmodule Cryptofolio.Repo.Migrations.AddNode4 do
  use Ecto.Migration

  def change do
    alter table(:coins) do
      add :all, :integer
    end
  end
end
