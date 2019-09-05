defmodule Backend.App.Cars.CarListCars do
  @moduledoc """
  Provides a schema for car list cars table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.App.Cars.Car
  alias Backend.App.Cars.CarList

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "car_list_cars" do
    belongs_to(:car_list, CarList,
      type: Ecto.UUID,
      references: :car_list_id,
      primary_key: true
    )

    belongs_to(:car, Car, type: Ecto.UUID, primary_key: true)
    timestamps()
  end

  @doc false
  def changeset(car_list_cars, attrs) do
    car_list_cars
    |> cast(attrs, [:car_list_id, :car_id])
    |> validate_required([:car_list_id, :car_id])
    |> foreign_key_constraint(:car_list_id)
    |> foreign_key_constraint(:car_id)
  end
end
