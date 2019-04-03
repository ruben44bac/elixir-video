defmodule Videorama.Repo.Migrations.AgregaCategoriaIdAVideo do
  use Ecto.Migration

  def change do
    alter table(:video) do
      add :categoria_id, references(:categoria)
    end
  end
end
