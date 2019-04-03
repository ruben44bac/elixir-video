defmodule Videorama.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, Videorama.Multimedia.Permalink, autogenerate: true}
  schema "video" do
    field :url, :string
    field :descripcion, :string
    field :titulo, :string
    field :slug, :string
    belongs_to :usuario, Videorama.Cuentas.Usuario
    belongs_to :categoria, Videorama.Multimedia.Categoria

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :titulo, :descripcion, :categoria_id])
    |> validate_required([:url, :titulo, :descripcion])
    |> assoc_constraint(:categoria)
    |> slugify_titulo()
  end

  defp slugify_titulo(changeset) do
    case fetch_change(changeset, :titulo) do
      {:ok, nuevo_titulo} -> put_change(changeset, :slug, slugify(nuevo_titulo))
        :error -> changeset
    end
  end

  defp slugify(str) do
    str
      |> String.downcase()
      |> String.replace(~r/[^\w-]+/u, "-")
  end

end
