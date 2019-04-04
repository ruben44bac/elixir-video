defmodule Videorama.Multimedia.Comentario do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comentarios" do
    field :at, :integer
    field :body, :string

    belongs_to :usuario, Videorama.Cuentas.Usuario
    belongs_to :video, Videorama.Multimedia.Video

    timestamps()
  end

  @doc false
  def changeset(comentario, attrs) do
    comentario
    |> cast(attrs, [:body, :at])
    |> validate_required([:body, :at])
  end
end
