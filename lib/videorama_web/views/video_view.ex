defmodule VideoramaWeb.VideoView do
  use VideoramaWeb, :view

  def categoria_seleccionada(categorias) do
    IO.puts("///////////////23432/4/324/23/4/23/4/32/4/234/23/4/23/4/23/4/234/32/4/324//42/342/3 ")
    IO.inspect(categorias)
    for categoria <-  categorias, do: {categoria.nombre, categoria.id}
  end
end
