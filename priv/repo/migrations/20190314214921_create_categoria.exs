defmodule Videorama.Repo.Migrations.CreateCategoria do
  use Ecto.Migration

  def change do
    create table(:categoria) do
      add :nombre, :string

      timestamps()
    end

  end
end
