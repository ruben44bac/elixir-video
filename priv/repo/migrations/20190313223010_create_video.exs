defmodule Videorama.Repo.Migrations.CreateVideo do
  use Ecto.Migration

  def change do
    create table(:video) do
      add :url, :string
      add :titulo, :string
      add :descripcion, :string
      add :usuario_id, references(:usuario, on_delete: :nothing)

      timestamps()
    end

    create index(:video, [:usuario_id])
  end
end
