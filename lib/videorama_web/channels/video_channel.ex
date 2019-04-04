defmodule VideoramaWeb.VideoChannel do
    use VideoramaWeb, :channel


    alias Videorama.{ Cuentas, Multimedia}
    alias VideoramaWeb.ComentarioView

    def join("videos:" <> video_id, parametros, socket) do
        last_seen_id = parametros["last_seen_id"] || 0
        video_id =  String.to_integer(video_id)
        video = Multimedia.get_video!(video_id)

        comentario = video
            |> Multimedia.lista_comentarios(last_seen_id)
            |> Phoenix.View.render_many(ComentarioView, "comentario.json")

        {:ok, %{comentarios: comentario}, assign(socket, :video_id, video_id)}
    end

    # def handle_info(:ping, socket) do
    #     contador = socket.assigns[:count] || 1
    #     push(socket, "ping  --> " <> Kernel.inspect(contador), %{count: contador})

    #     {:noreply, assign(socket, :count, contador+1)}
    # end

    def handle_in(event, params, socket) do
        usuario = Cuentas.get_usuario!(socket.assigns.usuario_id)
        handle_in(event, params, usuario, socket)
    end

    def handle_in("new_annotation", params, usuario, socket) do
        case Multimedia.comentario_video(usuario, socket.assigns.video_id, params) do
            {:ok, comentario} -> 
                broadcast!(socket, "new_annotation", %{
                    id: comentario.id,
                    usuario: VideoramaWeb.UsuarioView.render("usuario.json", %{usuario: usuario}),
                    body: comentario.body,
                    at: comentario.at
                })
                {:reply, :ok, socket}
            {:error, changeset} -> 
                    {:reply, {:error, %{errors: changeset}}, socket}
        end


        
    end

end