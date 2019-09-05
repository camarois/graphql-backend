defmodule Backend.App.Cars do
  @moduledoc """
  Provides Car CRUD methods.
  """
  import Ecto.Query, warn: false
  alias Backend.App.Constant
  alias Backend.App.Repo
  alias Backend.App.Cars.Car

  def list_cars do
    Repo.all(Car)
  end

  def get_car!(id), do: Repo.get!(Car, id)

  def create_car(attrs \\ %{}) do
    %Car{}
    |> Car.changeset(attrs)
    |> Repo.insert()
  end

  def update_car(%Car{} = car, attrs) do
    car
    |> Car.changeset(attrs)
    |> Repo.update()
  end

  def delete_car(car) do
    Repo.delete(car)
  end

  alias Backend.App.Cars.CarDescription

  def list_car_descriptions do
    Repo.all(CarDescription)
  end

  def get_car_description!(id), do: Repo.get!(CarDescription, id)

  def get_car_by_serial_id(serial_id, token) do
    uri = Constant.car_url() <> serial_id

    case HTTPoison.get(uri, [{"Authorization", "Bearer " <> token}]) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} -> body |> Jason.decode()
      {:ok, %HTTPoison.Response{status_code: 401}} -> nil
      {:error, %HTTPoison.Error{reason: reason}} -> reason
    end
  end

  def create_car_description(attrs \\ %{}) do
    %CarDescription{}
    |> CarDescription.changeset(attrs)
    |> Repo.insert()
  end

  alias Backend.App.Cars.CarList

  def list_car_lists do
    Repo.all(from(l in CarList, preload: [:user_id]))
  end

  def create_car_list(attrs \\ %{}) do
    %CarList{}
    |> CarList.changeset(attrs)
    |> Repo.insert()
  end

  alias Backend.App.Cars.CarListCars

  def create_car_list_cars(attrs \\ %{}) do
    %CarListCars{}
    |> CarListCars.changeset(attrs)
    |> Repo.insert()
  end
end
