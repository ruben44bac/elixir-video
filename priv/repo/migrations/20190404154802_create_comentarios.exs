defmodule Videorama.Repo.Migrations.CreateComentarios do
  use Ecto.Migration

  def change do
    create table(:comentarios) do
      add :body, :text
      add :at, :integer
      add :usuario_id, references(:usuario, on_delete: :nothing)
      add :video_id, references(:video, on_delete: :nothing)

      timestamps()
    end

    create index(:comentarios, [:usuario_id])
    create index(:comentarios, [:video_id])
  end
end
