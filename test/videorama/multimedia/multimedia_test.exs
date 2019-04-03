defmodule Videorama.MultimediaTest do
	use Videorama.DataCase

	alias Videorama.Multimedia
	alias Videorama.Multimedia.Categoria

	describe "categorias" do
		test "listado alfabetico de categorias/0" do
			for nombre <- ~w(Drama Accion Comedia), do: Categoria.crea_categoria(nombre, "Descripcion de " <> nombre)
			
			nombres_alfabeticos = for %Categoria{nombre: nombre} <- Multimedia.lista_alfabetica_categorias() do
				nombre
			end
			assert nombres_alfabeticos == ~w(Accion Comedia Drama)
		end
	end

	describe "videos" do
		alias Videorama.Multimedia.Video
		@atributos_validos %{descripcion: "Desc", titulo: "TITITULO", url: "https://santiago.mx"}
		@atributos_invalidos %{descripcion: nil, titulo: nil, url: nil}

		test "lista de videos, retorna todos los videos" do
			usuariox = usuario_fixture()
			%Video{id: id_1} = video_fixture(usuariox)
			assert [%Video{id: id}] = Multimedia.list_video()
			%Video{id: id_2} = video_fixture(usuariox)
			assert [%Video{id: ^id_1}, %Video{id: ^id_2}] = Multimedia.list_video()
		end


	end
	

end