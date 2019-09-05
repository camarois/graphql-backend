defmodule Backend.App.Web.Schema.Settings.Queries.SettingsQueries do
  @moduledoc """
  Provides settings queries.
  """
  use Absinthe.Schema.Notation

  alias Backend.App.Web.Resolvers.SettingsResolvers

  object :settings_queries do
     field :settings, list_of(:setting) do
        resolve &SettingsResolvers.all/2
      end

      field :setting, type: :setting do
        arg(:email, non_null(:string))
        resolve &SettingsResolvers.find/2
      end

    end
  end
