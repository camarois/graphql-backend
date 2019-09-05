defmodule Backend.App.Cars.Car do
  @moduledoc """
  Provides a schema for car table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.App.Cars.CarDescription

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "cars" do
    field(:serial_id, :string)
    field(:plate, :string)
    has_one(:car_description, CarDescription)
    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:serial_id, :plate])
    |> validate_required([:serial_id, :plate])
  end
end
