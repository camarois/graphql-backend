defmodule Backend.App.Web.Schema.Users.Mutations.UsersMutations do
  @moduledoc """
  Provides User mutations.
  """
  use Absinthe.Schema.Notation

  alias Backend.App.Web.Resolvers.UserResolvers

   object :users_mutations do
          field :update_user, type: :user do
            arg(:email, non_null(:string))
            arg :user, :update_user_params
            resolve &UserResolvers.update/2
          end
          field :create_user, type: :user do
            arg :user, :update_user_params
            arg(:email, non_null(:string))
            resolve &UserResolvers.create/2
          end
          field :delete_user, type: :user_status do
            arg(:email, non_null(:string))
            resolve &UserResolvers.delete/2
          end
      end

  end
