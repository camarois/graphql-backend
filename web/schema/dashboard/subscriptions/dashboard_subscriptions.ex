defmodule Backend.App.Web.Schema.Dashboard.Subscriptions.DashboardSubscriptions do
    @moduledoc """
    Provides dashboard subscriptions.
    """

    use Absinthe.Schema.Notation

    object :dashboard_subscriptions do
        @desc "Trigger subscription when new field"
        field :new_field, :field do
            config fn _args, _info ->
                {:ok, topic: "*"}
            end
        end
    end
  end
