defmodule Backend.App.Web.Schema.Users.Queries.UsersQueries do
  @moduledoc """
  Provides User queries.
  """
  use Absinthe.Schema.Notation

  alias Backend.App.Web.Resolvers.UserResolvers

  object :users_queries do
     field :users, list_of(:user) do
        resolve &UserResolvers.all/2
      end

      field :user, type: :user do
        arg(:email, non_null(:string))
        resolve &UserResolvers.find/2
      end

    end
  end
