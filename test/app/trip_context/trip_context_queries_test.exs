defmodule Backend.App.Trip.TripQueriesTest do
  use Backend.App.ConnCase
  alias Backend.App.Trip

  describe "trip queries" do
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

    @query_all """
     query trips{
       trips{
         tripId
         averageSpeed
         endTime
         fuelConsumption
         fuelEconomy
         startAddress
         startTime
         stopAddress
         carId
       }
     }
    """

    @query_one """
      query trip($id: ID) {
            trip(id: $id) {
              tripId
              averageSpeed
              endTime
              fuelConsumption
              fuelEconomy
              startAddress
              startTime
              stopAddress
              carId
            }
          }
    """

    def trip_fixture do
      {:ok, trip} = Trip.create_trip(@valid_attrs)
      trip
    end

    test "gets a field by id", context do
      trip = trip_fixture()
      variables = %{id: trip.trip_id}

      res =
        context.conn
        |> post("/graphiql", query: @query_one, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["trip"]["tripId"] ==
               Integer.to_string(trip.trip_id)

      assert res["trip"]["averageSpeed"] == trip.average_speed
      assert res["trip"]["endTime"] == NaiveDateTime.to_iso8601(trip.end_time)
      assert res["trip"]["fuelConsumption"] == trip.fuel_consumption
      assert res["trip"]["fuelEconomy"] == trip.fuel_economy
      assert res["trip"]["startAddress"] == trip.start_address
      assert res["trip"]["stopAddress"] == trip.stop_address
      assert res["trip"]["carId"] == trip.car_id
    end

    test "gets all fields", context do
      trip = trip_fixture()

      res =
        context.conn
        |> post("/graphiql", query: @query_all)
        |> json_response(200)
        |> Map.get("data")

      assert Enum.find(res["trips"], fn child ->
               child["tripId"] == Integer.to_string(trip.trip_id)
             end)

      assert Enum.find(res["trips"], fn child ->
               child["averageSpeed"] == trip.average_speed
             end)

      assert Enum.find(res["trips"], fn child ->
               child["endTime"] == NaiveDateTime.to_iso8601(trip.end_time)
             end)

      assert Enum.find(res["trips"], fn child ->
               child["fuelConsumption"] == trip.fuel_consumption
             end)

      assert Enum.find(res["trips"], fn child ->
               child["fuelEconomy"] == trip.fuel_economy
             end)

      assert Enum.find(res["trips"], fn child ->
               child["startAddress"] == trip.start_address
             end)

      assert Enum.find(res["trips"], fn child ->
               child["stopAddress"] == trip.stop_address
             end)

      assert Enum.find(res["trips"], fn child ->
               child["carId"] == trip.car_id
             end)
    end
  end
end
