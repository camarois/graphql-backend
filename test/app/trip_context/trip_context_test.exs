defmodule Backend.App.Trip.TripTest do
  use ExUnit.Case

  alias Backend.App.Repo
  alias Backend.App.Trip
  alias Ecto.Adapters.SQL.Sandbox

  setup do
    # Explicitly get a connection before each test
    # By default the test is wrapped in a transaction
    :ok = Sandbox.checkout(Repo)
    # The :shared mode allows a process to share
    # its connection with any other process automatically
    Sandbox.mode(Repo, {:shared, self()})
  end

  describe "trips" do
    alias Backend.App.Trip.Trip

    @valid_attrs %{
      average_speed: 120.5,
      breaks: 42,
      end_time: ~N[2010-04-17 14:00:00],
      fuel_consumption: 120.5,
      fuel_economy: 120.5,
      start_address: "some start_address",
      start_time: ~N[2010-04-17 14:00:00],
      stop_address: "some stop_address",
      car_id: "7488a646-e31f-11e4-aace-600308960662"
    }
    @invalid_attrs %{
      average_speed: nil,
      breaks: nil,
      end_time: nil,
      fuel_consumption: nil,
      fuel_economy: nil,
      start_address: nil,
      start_time: nil,
      stop_address: nil,
      car_id: nil
    }

    def trip_fixture(attrs \\ %{}) do
      {:ok, trip} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trip.create_trip()

      trip
    end

    test "list_trips/0 returns all trips" do
      trip = trip_fixture()
      assert Trip.list_trips() == [trip]
    end

    test "get_trip!/1 returns the trip with given id" do
      trip = trip_fixture()
      assert Trip.get_trip!(trip.trip_id) == trip
    end

    test "create_trip/1 with valid data creates a trip" do
      assert {:ok, %Trip{} = trip} = Trip.create_trip(@valid_attrs)
      assert trip.average_speed == 120.5
      assert trip.breaks == 42
      assert trip.end_time == ~N[2010-04-17 14:00:00]
      assert trip.fuel_consumption == 120.5
      assert trip.fuel_economy == 120.5
      assert trip.start_address == "some start_address"
      assert trip.start_time == ~N[2010-04-17 14:00:00]
      assert trip.stop_address == "some stop_address"
      assert trip.car_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_trip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trip.create_trip(@invalid_attrs)
    end
  end
end
