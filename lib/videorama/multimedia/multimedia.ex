defmodule Videorama.Multimedia do
  @moduledoc """
  The Multimedia context.
  """

  import Ecto.Query, warn: false
  alias Videorama.Repo

  alias Videorama.Multimedia.Video
  alias Videorama.Cuentas.Usuario
  alias Videorama.Multimedia.Categoria

  @doc """
  Returns the list of video.

  ## Examples

      iex> list_video()
      [%Video{}, ...]

  """
  def list_video do
    Video
      |> Repo.all()
      |> preload_usuario()
  end

  @doc """
  Gets a single video.

  Raises `Ecto.NoResultsError` if the Video does not exist.

  ## Examples

      iex> get_video!(123)
      %Video{}

      iex> get_video!(456)
      ** (Ecto.NoResultsError)

  """
  def get_video!(id), do: preload_usuario(Repo.get!(Video, id))

  @doc """
  Creates a video.

  ## Examples

      iex> create_video(%{field: value})
      {:ok, %Video{}}

      iex> create_video(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_video(%Usuario{} = usuario, attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> put_usuario(usuario)
    |> Repo.insert()
  end
  

  @doc """
  Updates a video.

  ## Examples

      iex> update_video(video, %{field: new_value})
      {:ok, %Video{}}

      iex> update_video(video, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Video.

  ## Examples

      iex> delete_video(video)
      {:ok, %Video{}}

      iex> delete_video(video)
      {:error, %Ecto.Changeset{}}

  """
  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking video changes.

  ## Examples

      iex> change_video(video)
      %Ecto.Changeset{source: %Video{}}

  """
  def change_video(%Usuario{} = usuario, %Video{} = video) do
    video
      |> Video.changeset(%{})
      |> put_usuario(usuario)
  end

  defp put_usuario(changeset, usuario) do
    IO.puts("kakakakakakkakakakakakakakakaka")
    IO.inspect(changeset)
    IO.inspect(usuario)
    IO.puts("kakakakakakkakakakakakakakakaka")
    Ecto.Changeset.put_assoc(changeset, :usuario, usuario)
  end

  def lista_usuario_video(%Usuario{} = usuario) do
    Video
      |> query_usuario_video(usuario)
      |> Repo.all()
      |> preload_usuario()
  end

  def get_usuario_video(%Usuario{} = usuario, id) do
    from(v in Video, where: v.id == ^id)
    |> query_usuario_video(usuario)
    |> Repo.one()
    |> preload_usuario()
  end

  defp query_usuario_video(query, %Usuario{id: usuario_id}) do
    from(v in query, where: v.usuario_id == ^usuario_id)
  end

  defp preload_usuario(video_videos) do
    Repo.preload(video_videos, :usuario)
  end


  def lista_alfabetica_categorias() do
    Categoria
      |> Categoria.orden_alfabetico()
      |> Repo.all()
  end

end
