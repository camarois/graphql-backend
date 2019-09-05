defmodule Backend.App.Web.Resolvers.SettingsResolvers do
  @moduledoc """
  Provides settings query resolvers.
  """
  alias Backend.App.Configuration
  def all(_args, _info) do
    {:ok, Configuration.list_settings()}
  end

  def find(%{email: email}, _info) do
    case Configuration.get_setting_email!(email)do
      nil -> {:error, "User email #{email} not found"}
      settings -> {:ok, settings}
    end
  end

  def update(%{email: email, setting: setting_params}, info) do
    case find(%{email: email}, info) do
      {:ok, settings} -> settings |> Configuration.update_setting(setting_params)
      {:error, _} -> {:error, "settings of #{email} not found"}
    end
  end

  def create(%{email: email, setting: setting_params}, info) do
    case find(%{email: email}, info)do
      {:error, _} ->  Configuration.create_setting(setting_params)
      {:ok, _settings} -> {:error, "this email #{email} already exist"}
    end
  end
end
