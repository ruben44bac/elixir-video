defmodule VideoramaWeb.VisorView do
    use VideoramaWeb, :view

    def algo(video) do
        ~r{^.*(?:youtu\.be/|\w+/|v=)(?<id>[^#&?]*)}
            |> Regex.named_captures(video.url)
            |> get_in(["id"])
    end

end