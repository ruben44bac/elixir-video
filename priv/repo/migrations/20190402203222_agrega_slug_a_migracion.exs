defmodule Videorama.Repo.Migrations.AgregaSlugAMigracion do
  use Ecto.Migration

  def change do
    alter table(:video) do
      add :slug, :string
    end
  end
end
