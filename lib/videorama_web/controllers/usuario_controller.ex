defmodule VideoramaWeb.UsuarioController do
	use VideoramaWeb, :controller
	
	alias Videorama.Cuentas
	alias Videorama.Cuentas.Usuario
	alias VideoramaWeb.Autentificacion
	plug :autenticacion_usuario when action in [:index, :show ]

	def index(conn, _params) do
		
				usuarios = Cuentas.lista_usuarios()
				render(conn, "index.html", usuarios: usuarios)
	end

	def show(conn, %{"id" => id}) do
		id_entero = String.to_integer(id)
		usuario = Cuentas.get_usuario(id_entero)
		render(conn, "show.html", usuario: usuario)
	end

	def new(conn, _params) do
		changeset = Cuentas.cambio_registro(%Usuario{}, %{})
		render(conn, "new.html", changeset: changeset)
	end

	def create(conn, %{"usuario" => parametros}) do
		IO.inspect(parametros)
		case Cuentas.registro_usuario(parametros) do
			{:ok, usuario} ->
				conn
					|> Autentificacion.acceso(usuario)
					|> put_flash(:info, "#{usuario.nombre} ha sido creado, amigo")
					|> redirect(to: Routes.usuario_path(conn, :index))
			
			{:error, %Ecto.Changeset{} = changeset} ->
				render(conn, "new.html", changeset: changeset)
		
		end
	end

	defp autenticacion(conn, _opciones) do
		if conn.assigns.usuario_concurrente do
			conn
		else
			conn
				|> put_flash(:error, "Inicia sesion para ver esto")
				|> redirect(to: Routes.page_path(conn, :index))
				|> halt()
		end
	end

end