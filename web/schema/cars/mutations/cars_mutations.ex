defmodule Backend.App.Web.Schema.Cars.Mutations.CarsMutations do
    @moduledoc """
    Provides Car mutations.
    """
    use Absinthe.Schema.Notation

    alias Backend.App.Web.Resolvers.CarsResolvers

     object :car_mutations do
            field :update_car, type: :car do
              arg :serial_id, non_null(:string)
              arg :token, non_null(:string)
              arg :car, :update_car_params
              resolve &CarsResolvers.update_car/2
            end
            field :create_car, type: :car do
              arg :car, :update_car_params
              arg :serial_id, non_null(:string)
              arg :token, non_null(:string)
              resolve &CarsResolvers.create_car/2
            end
            field :delete_car, type: :car_status do
              arg :serial_id, non_null(:string)
              arg :token, non_null(:string)
              resolve &CarsResolvers.delete_car/2
            end
        end

    end
