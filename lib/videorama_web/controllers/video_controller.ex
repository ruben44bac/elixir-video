defmodule VideoramaWeb.VideoController do
  use VideoramaWeb, :controller

  alias Videorama.Multimedia
  alias Videorama.Multimedia.Video

  

  def index(conn, _params, usuario_concurrente) do
    video = Multimedia.lista_usuario_video(usuario_concurrente)
    render(conn, "index.html", video: video)
  end

  def new(conn, _params, usuario_concurrente) do
    IO.puts("0909090909090909090909090909090909090909090")
    changeset = Multimedia.change_video(usuario_concurrente, %Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}, usuario_concurrente) do
    case Multimedia.create_video(usuario_concurrente, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, usuario_concurrente) do
    video = Multimedia.get_usuario_video(usuario_concurrente, id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}, usuario_concurrente) do
    video = Multimedia.get_usuario_video(usuario_concurrente, id)
    changeset = Multimedia.change_video(usuario_concurrente, video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}, usuario_concurrente) do
    video = Multimedia.get_usuario_video(usuario_concurrente, id)

    case Multimedia.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, usuario_concurrente) do
    video = Multimedia.get_usuario_video(usuario_concurrente, id)
    {:ok, _video} = Multimedia.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: Routes.video_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.usuario_concurrente]
    apply(__MODULE__, action_name(conn), args)
  end
  plug :carga_categorias when action in [:new, :create, :edit, :update]
  defp carga_categorias(conn, _) do
    assign(conn, :categoria, Multimedia.lista_alfabetica_categorias())
  end
end
