defmodule Videorama.TestAyudante do
  alias Videorama.{
		Cuentas,
		Multimedia
	}

	def usuario_fixture(atributos \\  %{}) do
		nombre_usuario = "usuario#{System.unique_integer([:positive])}"

		{:ok, usuario} = 
			atributos 
				|> Enum.into(%{
						nombre: "Ruben",
						nombre_usuario: "Rubennnnn3k",
						credencial: %{
							correo: atributos[:correo] || "#{nombre_usuario}@gmail.com",
							contraseña: atributos[:contraseña] || "123456"
						}
					})
				|> Cuentas.registro_usuario()

		usuario
	end

	def video_fixture(%Cuentas.Usuario{} = usuario, atributos \\ %{}) do
		atributos =
			Enum.into(atributos, %{
				titulo: "A Title",
				url: "http://example.com",
				descripcion: "a description"
			})
			{:ok, video} = Multimedia.create_video(usuario, atributos)
		video
		end
end