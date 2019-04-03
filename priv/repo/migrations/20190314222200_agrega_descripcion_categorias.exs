defmodule Videorama.Repo.Migrations.AgregaDescripcionCategorias do
  use Ecto.Migration

  def change do
    alter table(:categoria) do
      add :descripcion, :string
    end
  end
end
