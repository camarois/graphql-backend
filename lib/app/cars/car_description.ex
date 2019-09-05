defmodule Backend.App.Cars.CarDescription do
  @moduledoc """
  Provides a schema for car description table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.App.Cars.Car

  schema "car_descriptions" do
    field(:advanced_model, :string)
    field(:country, :string)
    field(:day_of_first_circulation, :integer)
    field(:day_of_sale, :integer)
    field(:engine_code, :string)
    field(:engine_displacement, :integer)
    field(:engine_fuel_type, :string)
    field(:engine_ouput_power, :integer)
    field(:k_type, :string)
    field(:make, :string)
    field(:model, :string)
    field(:month_of_first_circulation, :integer)
    field(:month_of_sale, :integer)
    field(:url_image_car, :string)
    field(:vin, :string)
    field(:year_of_first_circulation, :integer)
    field(:year_of_sale, :integer)
    belongs_to(:car, Car)
    timestamps()
  end

  @doc false
  def changeset(car_description, attrs) do
    car_description
    |> cast(attrs, [
      :vin,
      :make,
      :model,
      :advanced_model,
      :k_type,
      :year_of_first_circulation,
      :month_of_first_circulation,
      :day_of_first_circulation,
      :year_of_sale,
      :month_of_sale,
      :day_of_sale,
      :country,
      :url_image_car,
      :engine_code,
      :engine_fuel_type,
      :engine_displacement,
      :engine_ouput_power
    ])
    |> validate_required([
      :vin,
      :make,
      :model,
      :advanced_model,
      :k_type,
      :year_of_first_circulation,
      :month_of_first_circulation,
      :day_of_first_circulation,
      :year_of_sale,
      :month_of_sale,
      :day_of_sale,
      :country,
      :url_image_car,
      :engine_code,
      :engine_fuel_type,
      :engine_displacement,
      :engine_ouput_power
    ])
    |> foreign_key_constraint(:car_id)
  end
end
