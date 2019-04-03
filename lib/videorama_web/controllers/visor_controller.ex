defmodule VideoramaWeb.VisorController do
    use VideoramaWeb, :controller

    alias Videorama.Multimedia

    def ver(conn, %{"id" => id}) do
        video = Multimedia.get_video!(id)
        render(conn, "ver.html", video: video)
    end



end