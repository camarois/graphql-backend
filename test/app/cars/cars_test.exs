defmodule Backend.App.Cars.CarsTest do
  use ExUnit.Case
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

  describe "car" do
    alias Backend.App.Cars.Car

    @valid_attrs %{
      serial_id: "some serial_id",
      plate: "some plate"
    }
    @invalid_attrs %{
      serial_id: nil,
      plate: nil
    }

    def car_fixture do
      {:ok, car} = Cars.create_car(@valid_attrs)
      car
    end

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Enum.member?(Cars.list_cars(), car)
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Cars.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      assert {:ok, %Car{} = car} = Cars.create_car(@valid_attrs)

      assert car.serial_id == "some serial_id"
      assert car.plate == "some plate"
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cars.create_car(@invalid_attrs)
    end
  end

  describe "car_description" do
    alias Backend.App.Cars.CarDescription

    @valid_attrs %{
      vin: "some vin",
      make: "some make",
      model: "some model",
      advanced_model: "some advanced_model",
      k_type: "some k_type",
      year_of_first_circulation: 2019,
      month_of_first_circulation: 01,
      day_of_first_circulation: 01,
      year_of_sale: 2000,
      month_of_sale: 01,
      day_of_sale: 01,
      country: "some country",
      url_image_car: "some url",
      engine_code: "some engine_code",
      engine_fuel_type: "some engine_fuel_type",
      engine_displacement: 0,
      engine_ouput_power: 0
    }
    @invalid_attrs %{
      vin: nil,
      make: nil,
      model: nil,
      advanced_model: nil,
      k_type: nil,
      year_of_first_circulation: nil,
      month_of_first_circulation: nil,
      day_of_first_circulation: nil,
      year_of_sale: nil,
      month_of_sale: nil,
      day_of_sale: nil,
      country: nil,
      url_image_car: nil,
      engine_code: nil,
      engine_fuel_type: nil,
      engine_displacement: nil,
      engine_ouput_power: nil
    }

    def car_description_fixture do
      {:ok, car_description} = Cars.create_car_description(@valid_attrs)
      car_description
    end

    test "list_car_descriptions/0 returns all car_descriptions" do
      car_description = car_description_fixture()
      assert Enum.member?(Cars.list_car_descriptions(), car_description)
    end

    test "get_car_description!/1 returns the car_description with given id" do
      car_description = car_description_fixture()
      assert Cars.get_car_description!(car_description.id) == car_description
    end

    test "create_car_description/1 with valid data creates a car_description" do
      assert {:ok, %CarDescription{} = car_description} =
               Cars.create_car_description(@valid_attrs)

      assert car_description.vin == "some vin"
      assert car_description.advanced_model == "some advanced_model"
      assert car_description.make == "some make"
      assert car_description.model == "some model"
      assert car_description.k_type == "some k_type"
      assert car_description.year_of_first_circulation == 2019
      assert car_description.month_of_first_circulation == 01
      assert car_description.day_of_first_circulation == 01
      assert car_description.year_of_sale == 2000
      assert car_description.month_of_sale == 01
      assert car_description.day_of_sale == 01
      assert car_description.country == "some country"
      assert car_description.url_image_car == "some url"
      assert car_description.engine_code == "some engine_code"
      assert car_description.engine_fuel_type == "some engine_fuel_type"
      assert car_description.engine_displacement == 0
      assert car_description.engine_ouput_power == 0
    end

    test "create_car_description/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cars.create_car_description(@invalid_attrs)
    end
  end
end
