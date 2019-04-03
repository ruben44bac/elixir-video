defmodule VideoramaWeb.VideoChannel do
    use VideoramaWeb, :channel

    def join("videos:" <> video_id, _params, socket) do
        {:ok, socket}
    end

    # def handle_info(:ping, socket) do
    #     contador = socket.assigns[:count] || 1
    #     push(socket, "ping  --> " <> Kernel.inspect(contador), %{count: contador})

    #     {:noreply, assign(socket, :count, contador+1)}
    # end

    def handle_in("new_annotation", params, socket) do
        broadcast!(socket, "new_annotation", %{
            usuario: %{nombre_usuario: "LALALA"},
            body: params["body"],
            at: params["at"]
        })
        {:reply, :ok, socket}
    end

end