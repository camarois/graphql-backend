defmodule Backend.App.Web.Resolvers.DashboardResolvers do
    @moduledoc """
    Provides dashboard query resolvers.
    """
    alias Backend.App.Dashboard

    def fields(_, _, _) do
      {:ok, Dashboard.list_fields()}
    end

    def field(_, %{id: id}, _) do
      {:ok, Dashboard.get_field!(id)}
    end

    def field_by_asset(_, %{asset: asset, token: token}, _) do
      {:ok, Dashboard.get_field_by_asset(asset, token)}
    end
  end
