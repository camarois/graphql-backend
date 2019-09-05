defmodule Backend.App.Cars.CarListTest do
  use ExUnit.Case
  alias Backend.App.Accounts
  alias Backend.App.Repo
  alias Backend.App.Cars
  alias Ecto.Adapters.SQL.Sandbox

  setup do
    # Explicitly get a connection before each test
    # By default the test is wrapped in a transaction
    :ok = Sandbox.checkout(Repo)
    # The :shared mode allows a process to share
    # its connection with any other process automatically
    Sandbox.mode(Repo, {:shared, self()})
  end

  describe "carList and carListCars" do
    {:ok, user_uuid = Ecto.UUID.generate()}
    {:ok, car_list_uuid = Ecto.UUID.generate()}
    {:ok, app_uuid = Ecto.UUID.generate()}

    @user_attrs %{
      application: %{
        application_id: app_uuid,
        version: 0.1,
        default_language: "fr"
      },
      address: "some address",
      age: 14,
      country: "some country",
      email: "some email",
      enable_wifi: true,
      gender: 0,
      name: "some name",
      phone: 336_066_666,
      user_id: user_uuid,
      wifi_pwd: "some wifi_pwd",
      wifi_ssid: "some wifi_ssid"
    }

    @valid_attrs %{
      car_list_id: car_list_uuid,
      user_id: user_uuid
    }
    @invalid_attrs %{
      # car_list_id: nil,
      user_id: nil
    }

    def user_fixture do
      {:ok, user} = Accounts.create_user(@user_attrs)
      user
    end

    def car_list_fixture(attr) do
      {:ok, car} = Cars.create_car_list(attr)
      car
    end

    test "create_car_list/1" do
      user_fixture()
      car_list = car_list_fixture(@valid_attrs)

      assert car_list.user_id == @valid_attrs.user_id
    end

    test "create_car_list/1 with invalid data" do
      user_fixture()
      assert {:error, %Ecto.Changeset{}} = Cars.create_car_list(@invalid_attrs)
    end

    @car_attrs %{
      serial_id: "some serial_id",
      plate: "some plate"
    }

    @car_list_attrs %{
      car_list_id: car_list_uuid,
      user_id: user_uuid
    }

    @invalid_attrs %{
      user_id: nil
    }

    def car_fixture do
      {:ok, car} = Cars.create_car(@car_attrs)
      car
    end

    def car_list_cars_fixture(attr) do
      {:ok, car_list_cars} = Cars.create_car_list_cars(attr)
      car_list_cars
    end

    test "create_car_list_cars/1" do
      car = car_fixture()
      user_fixture()
      car_list = car_list_fixture(@car_list_attrs)

      car_list_cars_struct = %{
        car_list_id: car_list.car_list_id,
        car_id: car.id
      }

      car_list_cars = car_list_cars_fixture(car_list_cars_struct)

      assert car_list_cars.car_id == car_list_cars_struct.car_id
      assert car_list_cars.car_list_id == car_list_cars_struct.car_list_id
    end

    test "create_car_list_cars/1 with invalid data" do
      car_fixture()
      user_fixture()
      car_list_fixture(@car_list_attrs)
      assert {:error, %Ecto.Changeset{}} = Cars.create_car_list_cars(@invalid_attrs)
    end
  end
end
