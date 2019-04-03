defmodule VideoramaWeb.Router do
  use VideoramaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug VideoramaWeb.Autentificacion
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VideoramaWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/usuario", UsuarioController, only: [:index, :show, :new, :create]
    resources "/sesion", SesionController, only: [:new, :create, :delete]
    get "/visor/:id", VisorController, :ver
    resources "/video", VideoController
    
  end

  scope "/gestor", VideoramaWeb do
    pipe_through [:browser, :autenticacion_usuario]
    resources "/video", VideoController
  end

  # Other scopes may use custom stacks.
  # scope "/api", VideoramaWeb do
  #   pipe_through :api
  # end
end
