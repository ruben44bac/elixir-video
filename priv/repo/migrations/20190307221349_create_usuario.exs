defmodule Videorama.Repo.Migrations.CreateUsuario do
  use Ecto.Migration

  def change do
      create table(:usuario) do
        add :nombre, :string
        add :nombre_usuario, :string,  null: false

        timestamps()
      end

      create unique_index(:usuario, [:nombre_usuario])
  end
end
