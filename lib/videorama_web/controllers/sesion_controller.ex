defmodule VideoramaWeb.SesionController do
  use VideoramaWeb, :controller
	alias VideoramaWeb.Autentificacion

	def new(conn, _) do
		render(conn, "new.html")
	end

	def create(conn, %{"sesion" => %{"correo" => correo, "contraseña" => contraseña }}) do
		case Autentificacion.login_correo_contraseña(conn, correo, contraseña) do
			{:ok, conn} ->
				conn
					|> put_flash(:info, "Bienvenido a videorama chavo")
					|> redirect(to: Routes.page_path(conn, :index))

			{:error, conn} ->
				conn 
					|> put_flash(:error, "Fallaste al intentar ingresar jajajaja")
					|> render("new.html")
		end

	end

	def delete(conn, _) do
		conn
			|> Autentificacion.salir()
			|> redirect(to: Routes.page_path(conn, :index))
	end

end