# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Videorama.Repo.insert!(%Videorama.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Videorama.Multimedia.Categoria

for categoria <- ~w(Futbol PaBailar PaCorrer Comedia Terror Chidas Rockeras Darks Rap) do
    Categoria.crea_categoria(categoria, categoria <> " de los amigos")
end