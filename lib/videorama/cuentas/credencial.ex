defmodule Videorama.Cuentas.Credencial do
  use Ecto.Schema
  import Ecto.Changeset


  schema "credenciales" do
    field :correo, :string
    field :contraseña, :string, virtual: true
    field :contraseña_hash, :string
    belongs_to :usuario, Videorama.Cuentas.Usuario

    timestamps()
  end

  @doc false
  def changeset(credencial, atributos) do
    credencial
    |> cast(atributos, [:correo, :contraseña])
    |> validate_required([:correo, :contraseña])
    |> validate_length(:contraseña, min: 6, max: 10)
    |> unique_constraint(:correo)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{contraseña: pass}} ->
      put_change(changeset, :contraseña_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

end
