defmodule Videorama.CuentasTest do
    use Videorama.DataCase

    alias Videorama.Cuentas
    alias Videorama.Cuentas.Usuario

    describe "registra usuario/1" do
        @valid_attrs %{
            nombre: "Usuariso1",
            nombre_usuario: "curiosin2",
            credencial: %{
                correo: "ruben@jaja.com",
                contraseña: "qaz123456"
            }
        }
        @invalid_attrs %{}

        test "con valores validos, se insertan datos" do
            assert {:ok, %Usuario{id: id} = usuario} = Cuentas.registro_usuario(@valid_attrs)
            assert usuario.nombre == "Usuariso1"
            assert usuario.nombre_usuario == "curiosin2"
            assert usuario.credencial.correo == "ruben@jaja.com"
            assert [%Usuario{id: ^id}] = Cuentas.lista_usuarios()
        end

        test "datos invalidos sin insertar datos" do
            assert {:error, _changeset} = Cuentas.registro_usuario(@invalid_attrs)
            assert Cuentas.lista_usuarios() == [] 
        end

        test "forzar nombre de usuario unico" do
           assert {:ok, %Usuario{id: id}} = Cuentas.registro_usuario(@valid_attrs)
           assert {:error, changeset} = Cuentas.registro_usuario(@valid_attrs)
           assert %{nombre_usuario: ["has already been taken"]} = errors_on(changeset)

           assert [%Usuario{id: ^id}] = Cuentas.lista_usuarios()
        end

        test "No se aceptan longitudes largas en el nombre de usuario" do
            attrs = Map.put(@valid_attrs, :nombre_usuario, String.duplicate("a", 30))
            {:error, changeset} = Cuentas.registro_usuario(attrs)

            assert %{nombre_usuario: ["should be at most 20 character(s)"]} = 
                errors_on(changeset)
            assert Cuentas.lista_usuarios() == []
        end

        test "La contraseña debe de ser mayor a los 6 caracteres" do
            attrs = put_in(@valid_attrs, [:credencial, :contraseña], "12345")
            {:error, changeset} = Cuentas.registro_usuario(attrs)

            assert %{contraseña: ["should be at least 6 character(s)"]} = 
                errors_on(changeset)[:credencial]
            assert Cuentas.lista_usuarios() == []
        end

		end
		

		describe  "Autenticación por correo y contraseña/2" do
			@correo_de_prueba "rubeng44@hotmail.com"
			@contraseña "123456"

			setup do
				{:ok, usuario: usuario_fixture(correo: @correo_de_prueba, contraseña: @contraseña)}
			end

			test "retorna usuario con contraseña correcta", %{usuario: %Usuario{id: id}} do
				assert {:ok, %Usuario{id: id}} = Cuentas.validacion_correo_contraseña(@correo_de_prueba, @contraseña)
			end

			test "retorna error de acceso con contraseña invalida" do
				assert {:error, :sin_autorizacion} = Cuentas.validacion_correo_contraseña(@correo_de_prueba, "jajajaja")
			end

			test "retorna el error de no encontrado por correo" do
				assert {:error, :no_encontrado} = Cuentas.validacion_correo_contraseña("cladimir@putin.com", @contraseña)
			end

		end

end