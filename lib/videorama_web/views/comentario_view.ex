defmodule VideoramaWeb.ComentarioView do
	use VideoramaWeb, :view

    def render("comentario.json", %{comentario: comentario}) do
        IO.inspect(comentario)
        %{
            id: comentario.id,
            body: comentario.body,
            at: comentario.at,
            usuario: render_one(comentario.usuario, VideoramaWeb.UsuarioView, "usuario.json")
        }
    end

end