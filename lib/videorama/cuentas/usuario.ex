defmodule Videorama.Cuentas.Usuario do
	use Ecto.Schema
	import Ecto.Changeset

	alias Videorama.Cuentas.Credencial

	schema "usuario" do
		field :nombre, :string
		field :nombre_usuario, :string
		has_one :credencial, Credencial

		timestamps()
	end

	def changeset(usuario, atributos) do
		usuario
			|> cast(atributos, [:nombre, :nombre_usuario])
			|> validate_required([:nombre, :nombre_usuario])
			|> validate_length(:nombre_usuario, min: 1, max: 20)
			|> unique_constraint(:nombre_usuario)
	end

	def registro_changeset(usuario, atributos) do	
		usuario
			|> changeset(atributos)
			|> cast_assoc(:credencial, with: &Credencial.changeset/2, required: true)
  end
end