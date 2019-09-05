defmodule Backend.App.Dashboard.Field do
  @moduledoc """
  Provides a schema for fields table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:field_id, :id, autogenerate: true}
  schema "fields" do
    field(:type, :string)
    field(:asset, :string)
    field(:field_name, :string)
    field(:field_value, :float)
    field(:latitude, :float)
    field(:longitude, :float)
    field(:timestamp, :string)

    timestamps()
  end

  @doc false
  def changeset(attribute, attrs) do
    attribute
    |> cast(attrs, [:type, :asset, :field_name, :field_value, :latitude, :longitude, :timestamp])
    |> validate_required([
      :type,
      :asset,
      :field_name,
      :field_value,
      :latitude,
      :longitude,
      :timestamp
    ])
  end
end
