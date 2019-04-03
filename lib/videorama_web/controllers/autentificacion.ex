defmodule VideoramaWeb.Autentificacion do
	import Plug.Conn
	import Phoenix.Controller
	alias Videorama.Cuentas
	alias VideoramaWeb.Router.Helpers, as: Routes

	def init(opciones), do: opciones
	
	def call(conn, _opciones) do
		usuario_id = get_session(conn, :usuario_id)
		usuario = usuario_id && Cuentas.get_usuario(usuario_id)
		assign(conn, :usuario_concurrente, usuario)
	end

	def acceso(conn, usuario) do
		conn
			|> assign(:usuario_concurrente, usuario)
			|> put_session(:usuario_id, usuario.id)
			|> configure_session(renew: true)
	end

	def salir(conn) do
		configure_session(conn, drop: true)
	end

	def login_correo_contraseña(conn, correo, contraseña) do
		case Cuentas.validacion_correo_contraseña(correo, contraseña) do
			{:ok, usuario} -> {:ok, acceso(conn, usuario)}
			{:error, :sin_autorizacion} -> {:error, conn}
			{:error, :no_encontrado} -> {:error, conn}
		end
	end

	def autenticacion_usuario(conn, _opciones) do
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
