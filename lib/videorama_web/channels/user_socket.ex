defmodule VideoramaWeb.UserSocket do
  use Phoenix.Socket


  @max_age 2 * 7 * 24 * 60 * 60
  def connect(%{"token" => token}, socket) do
    IO.puts(" laralala laralala laralala laralala laralala laralala laralala")
    IO.inspect(token)
    case Phoenix.Token.verify(
      socket, 
      "usuario socket", 
      token, 
      max_age: @max_age
    ) do
        {:ok, usuario_id} -> {:ok, assign(socket, :usuario_id, usuario_id)}
        {:error, _reason} -> :error
    end
  end

  def connect(_params, _socket), do: :error
  
  def id(socket), do: "usuario_socket:#{socket.assigns.usuario_id}"

  ## Channels
  channel "videos:*", VideoramaWeb.VideoChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(_params, socket) do
    {:ok, socket}
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     VideoramaWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
