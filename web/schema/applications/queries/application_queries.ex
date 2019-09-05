defmodule Backend.App.Web.Schema.Applications.Queries.ApplicationQueries do
    @moduledoc """
    Provides application queries.
    """
    use Absinthe.Schema.Notation

    alias Backend.App.Web.Resolvers.ApplicationResolvers

    object :application_queries do
        @desc "Get a list of applications"
        field :applications, list_of(:application) do
            resolve &ApplicationResolvers.applications/2
        end

        @desc "Get an application by its id"
        field :application, :application do
            arg :id, non_null(:id)
            resolve &ApplicationResolvers.application/2
        end
    end
  end
