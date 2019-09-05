defmodule Backend.App.Web.Schema.Settings.Mutations.SettingsMutations do
  @moduledoc """
  Provides settings mutations.
  """
  use Absinthe.Schema.Notation

  alias Backend.App.Web.Resolvers.SettingsResolvers

   object :settings_mutations do
          field :update_setting, type: :setting do
            arg(:email, non_null(:string))
            arg :setting, :update_setting_params
            resolve &SettingsResolvers.update/2
          end
          field :create_setting, type: :setting do
            arg :setting, :update_setting_params
            arg(:email, non_null(:string))
            resolve &SettingsResolvers.create/2
          end
      end

  end
