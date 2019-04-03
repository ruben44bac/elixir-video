defmodule Videorama.Cuentas do

		import Ecto.Query

    @moduledoc """
        Context de cuentas
    """
    alias Videorama.Cuentas.Usuario
    alias Videorama.Repo

    def lista_usuarios do
        Repo.all(Usuario)
    end

    def get_usuario(id) do
        Repo.get(Usuario, id)
    end

    def get_usuario!(id) do
        Repo.get!(Usuario, id)
    end

    def get_usuario_por(parametros) do
        Repo.get_by(Usuario, parametros)
    end

    def change_usuario(%Usuario{} = usuario) do 
        Usuario.changeset(usuario, %{})
    end

    def create_usuario(atributos \\ %{}) do
        %Usuario{}
			|> Usuario.changeset(atributos)
			|> Repo.insert()
	end
	def cambio_registro(%Usuario{} = usuario, parametros) do
		Usuario.registro_changeset(usuario, parametros)
	end
	
	def registro_usuario(atributos \\ %{}) do
		%Usuario{}
			|> Usuario.registro_changeset(atributos)	
			|> Repo.insert()
	end


	def get_usuario_correo(correo) do
		IO.puts(correo)
		from(u in Usuario, join: c in assoc(u, :credencial), where: c.correo == ^correo)
			|> Repo.one()
			|> Repo.preload(:credencial)
	end

	def validacion_correo_contraseña(correo, contraseña) do
		usuario = get_usuario_correo(correo)
		cond do 
			usuario && Comeonin.Bcrypt.checkpw(contraseña, usuario.credencial.contraseña_hash) ->
				{:ok, usuario}

			usuario -> {:error, :sin_autorizacion}

			true ->
				Comeonin.Bcrypt.dummy_checkpw()
				{:error, :no_encontrado}
		end
	end

end