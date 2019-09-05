defmodule Backend.App.Web.Resolvers.CarsResolvers do
  @moduledoc """
  Provides Car query resolvers.
  """
    alias Backend.App.Cars

    def cars(_, _) do
      {:ok, Cars.list_cars()}
    end

    def car(%{id: id}, _) do
      {:ok, Cars.get_car!(id)}
    end

    def car_descriptions(_, _) do
      {:ok, Cars.list_car_descriptions()}
    end

    def car_description(%{id: id}, _) do
      {:ok, Cars.get_car_description!(id)}
    end

    def car_by_serial_id(%{serial_id: serial_id, token: token}, _) do
      case Cars.get_car_by_serial_id(serial_id, token) do
        nil -> {:error, "Car serial_id #{serial_id} not found"}
        car -> {:ok, car}
      end
    end

    def update_car(%{serial_id: serial_id, token: token, car: car_params}, info) do
      case car_by_serial_id(%{serial_id: serial_id, token: token}, info) do
        {:ok, car} -> car |> Cars.update_car(car_params)
        {:error, _} -> {:error, "car #{serial_id} not found"}
      end
    end

    def create_car(%{serial_id: serial_id, token: token, car: car_params}, info) do
      case car_by_serial_id(%{serial_id: serial_id, token: token}, info) do
        {:error, _} ->  Cars.create_car(car_params)
        {:ok, _car} -> {:error, "this car #{serial_id} already exist"}
      end
    end

    def delete_car(%{serial_id: serial_id, token: token}, info) do
      case car_by_serial_id(%{serial_id: serial_id, token: token}, info) do
        {:ok, car} ->
          Cars.delete_car(car)
          {:ok, %{done: true, serial_id: serial_id, car_id: car.car_id}}
        {:error, _} -> {:error, %{done: false, serial_id: serial_id, car_id: nil}}
      end
    end
  end
