defmodule Backend.App.Dashboard do
  @moduledoc """
  Provides dashboard CRUD methods.
  """
  import Ecto.Query, warn: false
  alias Backend.App.Constant
  alias Backend.App.Dashboard.Field
  alias Backend.App.Repo

  def list_fields do
    Repo.all(Field)
  end

  def get_field!(id), do: Repo.get!(Field, id)

  def get_field_by_asset(asset, token) do
    fields = Enum.join(Constant.all_fields(), Constant.field_url_fields())

    uri =
      Constant.field_url() <>
        asset <> Constant.field_url_fields() <> fields

    {:ok, field} =
      HTTPoison.get!(
        uri,
        [{"Authorization", "Bearer " <> token}]
      ).body
      |> Jason.decode()

    for item <- field["data"],
        do: %Field{
          type: item["type"],
          asset: item["attributes"]["asset"],
          field_name: item["attributes"]["field_name"],
          field_value: item["attributes"]["field_value"],
          latitude: item["attributes"]["latitude"],
          longitude: item["attributes"]["longitude"],
          timestamp: item["attributes"]["timestamp"]
        }
  end

  def create_field(attrs \\ %{}) do
    %Field{}
    |> Field.changeset(attrs)
    |> Repo.insert()
  end
end
