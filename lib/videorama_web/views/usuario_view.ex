defmodule VideoramaWeb.UsuarioView do
    use VideoramaWeb, :view
    alias Videorama.Cuentas

	def primer_nombre(%Cuentas.Usuario{nombre: nombre}) do
		nombre
			|> String.split(" ")
			|> Enum.at(0)
	end
	
	def render("usuario.json", %{usuario: usuario}) do

		IO.puts("usuario.jsonusuario.jsonusuario.jsonusuario.jsonusuario.jsonusuario.jsonusuario.jsonusuario.json")
		IO.inspect(usuario)
		IO.puts("usuario.jsonusuario.jsonusuario.jsonusuario.jsonusuario.jsonusuario.jsonusuario.jsonusuario.json")

		%{id: usuario.id, nombre_usuario: usuario.nombre_usuario}
	end

end
