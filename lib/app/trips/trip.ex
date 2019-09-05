defmodule Backend.App.Trips.Trip do
  @moduledoc """
  Provides a schema for trips table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:trip_id, :id, autogenerate: true}
  schema "trips" do
    field(:average_speed, :float)
    field(:breaks, :integer)
    field(:end_time, :naive_datetime)
    field(:fuel_consumption, :float)
    field(:fuel_economy, :float)
    field(:start_address, :string)
    field(:start_time, :naive_datetime)
    field(:stop_address, :string)
    field(:car_id, Ecto.UUID)

    timestamps()
  end

  @doc false
  def changeset(trip, attrs) do
    trip
    |> cast(attrs, [
      :car_id,
      :start_time,
      :end_time,
      :breaks,
      :fuel_economy,
      :fuel_consumption,
      :start_address,
      :stop_address,
      :average_speed
    ])
    |> validate_required([
      :car_id,
      :start_time,
      :end_time,
      :breaks,
      :fuel_economy,
      :fuel_consumption,
      :start_address,
      :stop_address,
      :average_speed
    ])
  end
end
