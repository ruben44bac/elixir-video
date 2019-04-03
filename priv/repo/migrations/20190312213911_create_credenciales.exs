defmodule Videorama.Repo.Migrations.CreateCredenciales do
  use Ecto.Migration

  def change do
    create table(:credenciales) do
      add :correo, :string
      add :contraseña_hash, :string
      add :usuario_id, references(:usuario, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:credenciales, [:correo])
    create index(:credenciales, [:usuario_id])
  end
end
