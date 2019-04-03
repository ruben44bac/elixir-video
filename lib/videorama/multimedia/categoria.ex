defmodule Videorama.Multimedia.Categoria do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Videorama.Multimedia.Categoria
  alias Videorama.Repo

  schema "categoria" do
    field :nombre, :string, null: false
    field :descripcion, :string
    timestamps()
  end

  @doc false
  def changeset(categoria, attrs) do
    categoria
    |> cast(attrs, [:nombre, :descripcion])
    |> validate_required([:nombre])
  end


  def crea_categoria(nombre, descripcion) do
    tester = Repo.get_by(Categoria, [nombre: nombre, descripcion: descripcion])
    case tester == nil do
      true -> actualiza(nombre, descripcion)
      false -> tester
    end
  end

  defp actualiza(nombre, descripcion) do
    tester = Repo.get_by(Categoria, [nombre: nombre])
    case tester == nil do
      true -> Repo.insert!(%Categoria{nombre: nombre, descripcion: descripcion})
      false -> 
        tester
          |> changeset(%{"nombre" => nombre, "descripcion" => descripcion})
          |> Repo.update!()
    end
  end

  def orden_alfabetico(query) do
    from c in query, order_by: c.nombre
  end

end
