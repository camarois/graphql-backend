defmodule Backend.App.Web.Schema.Cars.Queries.CarsQueries do
    @moduledoc """
    Provides Car queries.
    """
    use Absinthe.Schema.Notation

    alias Backend.App.Web.Resolvers.CarsResolvers

    object :cars_queries do
        @desc "Get a list of cars"
        field :cars, list_of(:car) do
            resolve &CarsResolvers.cars/2
        end

        @desc "Get a car by its id"
        field :car, :car do
            arg :id, non_null(:id)
            resolve &CarsResolvers.car/2
        end

        @desc "Get a list of car_descriptions"
        field :car_descriptions, list_of(:car_description) do
            resolve &CarsResolvers.car_descriptions/2
        end

        @desc "Get a car_description by its id"
        field :car_description, :car_description do
            arg :id, non_null(:id)
            resolve &CarsResolvers.car_description/2
        end

        @desc "Get a car by its serial_id"
        field :car_by_serial_id, list_of(:car) do
            arg :serial_id, non_null(:string)
            arg :token, non_null(:string)
            resolve &CarsResolvers.car_by_serial_id/2
        end
    end
  end
