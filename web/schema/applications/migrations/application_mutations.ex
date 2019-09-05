defmodule Backend.App.Web.Schema.Applications.Mutations.ApplicationMutations do
    @moduledoc """
    Provides applications mutations.
    """
    use Absinthe.Schema.Notation

    alias Backend.App.Web.Resolvers.ApplicationResolvers

     object :application_mutations do
            field :update_application, type: :application do
              arg(:id, non_null(:id))
              arg :application, :update_application_params
              resolve &ApplicationResolvers.update/2
            end
            field :create_application, type: :application do
              arg(:id, non_null(:id))
              arg :application, :update_application_params
              resolve &ApplicationResolvers.create/2
            end
            field :delete_application, type: :application_status do
              arg(:id, non_null(:id))
              resolve &ApplicationResolvers.delete/2
            end
        end

    end
