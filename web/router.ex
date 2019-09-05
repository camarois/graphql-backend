defmodule Backend.App.Router do
  use Backend.App.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api
    forward "/api", Absinthe.Plug,
      schema:  Backend.App.Web.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: Backend.App.Web.Schema,
      interface: :simple,
      socket: Backend.App.Web.Channels.UserSocket
  end
end
