defmodule Backend.App.Web.Schema.Types.CarType do
    @moduledoc """
    Provides types related to cars.
    """
    use Absinthe.Schema.Notation

    object :car do
        field :id, non_null(:id)
        field :serial_id, non_null(:string)
        field :plate, non_null(:string)
        field :car_description, :car_description
    end

    input_object :update_car_params do
      field :id, non_null(:id)
      field :serial_id, non_null(:string)
      field :plate, non_null(:string)
      field :car_description, :update_car_description_params
    end

    object :car_status do
      field(:done, :boolean)
      field(:serial_id, :string)
      field(:car_id, :string)
    end

    object :car_description do
      field :id, non_null(:id)
      field :vin, :string
      field :make, :string
      field :model, :string
      field :advanced_model, :string
      field :k_type, :string
      field :year_of_first_circulation, :integer
      field :month_of_first_circulation, :integer
      field :day_of_first_circulation, :integer
      field :year_of_sale, :integer
      field :month_of_sale, :integer
      field :day_of_sale, :integer
      field :country, :string
      field :url_image_car, :string
      field :engine_code, :string
      field :engine_fuel_type, :string
      field :engine_displacement, :integer
      field :engine_ouput_power, :integer
    end

    input_object :update_car_description_params do
      field :id, non_null(:id)
      field :vin, :string
      field :make, :string
      field :model, :string
      field :advanced_model, :string
      field :k_type, :string
      field :year_of_first_circulation, :integer
      field :month_of_first_circulation, :integer
      field :day_of_first_circulation, :integer
      field :year_of_sale, :integer
      field :month_of_sale, :integer
      field :day_of_sale, :integer
      field :country, :string
      field :url_image_car, :string
      field :engine_code, :string
      field :engine_fuel_type, :string
      field :engine_displacement, :integer
      field :engine_ouput_power, :integer
    end

    object :car_description_status do
      field(:done, :boolean)
      field(:id, :id)
    end
  end
