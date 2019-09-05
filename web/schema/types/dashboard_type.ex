defmodule Backend.App.Web.Schema.Types.DashboardType do
    @moduledoc """
    Provides types for fields.
    """
    use Absinthe.Schema.Notation

    object :field do
        field :field_id, non_null(:id)
        field :type, non_null(:string)
        field :asset, non_null(:string)
        field :field_name, non_null(:string)
        field :field_value, non_null(:float)
        field :latitude, non_null(:float)
        field :longitude, non_null(:float)
        field :timestamp, non_null(:string)
    end
  end
