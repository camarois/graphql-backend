defmodule Backend.App.Web.Resolvers.UserResolvers do
  @moduledoc """
  Provides User query resolvers.
  """
  alias Backend.App.Accounts
  def all(_args, _info) do
    {:ok, Accounts.list_users()}
  end

  def find(%{email: email}, _info) do
    case Accounts.get_user_email!(email)do
      nil -> {:error, "User email #{email} not found"}
      user -> {:ok, user}
    end
  end

  def update(%{email: email, user: user_params}, info) do
    case find(%{email: email}, info) do
      {:ok, user} -> user |> Accounts.update_user(user_params)
      {:error, _} -> {:error, "user of #{email} not found"}
    end
  end

  def create(%{email: email, user: user_params}, info) do
    case find(%{email: email}, info) do
      {:error, _} ->  Accounts.create_user(user_params)
      {:ok, _user} -> {:error, "this email #{email} already exist"}
    end
  end

  def delete(%{email: email}, info) do
    case find(%{email: email}, info) do
    {:ok, user} ->
      Accounts.delete_user(user)
      {:ok, %{done: true, email: email, user_id: user.user_id}}
    {:error, _} -> {:error, %{done: false, email: email, user_id: nil}}
    end
  end
end
