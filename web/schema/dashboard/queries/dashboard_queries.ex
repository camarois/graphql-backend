defmodule Backend.App.Web.Schema.Dashboard.Queries.DashboardQueries do
    @moduledoc """
    Provides dashboard queries.
    """
    use Absinthe.Schema.Notation

    alias Backend.App.Web.Resolvers.DashboardResolvers

    object :dashboard_queries do
        @desc "Get a list of fields"
        field :fields, list_of(:field) do
            resolve &DashboardResolvers.fields/3
        end

        @desc "Get a field by its id"
        field :field, :field do
            arg :id, non_null(:id)
            resolve &DashboardResolvers.field/3
        end

        @desc "Get a field by its asset"
        field :field_by_asset, list_of(:field) do
            arg :asset, non_null(:string)
            arg :token, non_null(:string)
            resolve &DashboardResolvers.field_by_asset/3
        end
    end
  end
