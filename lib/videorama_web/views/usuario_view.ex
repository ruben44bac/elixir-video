defmodule VideoramaWeb.UsuarioView do
    use VideoramaWeb, :view
    alias Videorama.Cuentas

		def primer_nombre(%Cuentas.Usuario{nombre: nombre}) do
			nombre
				|> String.split(" ")
				|> Enum.at(0)

    end

end
