defmodule Backend.App.Cars.CarsQueriesTest do
  use Backend.App.ConnCase
  alias Backend.App.Cars

  describe "cars queries" do
    @valid_car_attrs %{
      serial_id: "some type",
      plate: "some asset"
    }

    @valid_car_description_attrs %{
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

    @query_all_cars """
     query cars{
       cars{
           id
           serial_id
           plate
       }
     }
    """

    @query_one_car """
      query car($id: ID) {
            car(id: $id) {
              id
              serial_id
              plate
            }
          }
    """

    @query_all_car_descriptions """
    query car_descriptions{
        car_descriptions{
            id
            vin
            make
            model
            advanced_model
            k_type
            year_of_first_circulation
            month_of_first_circulation
            day_of_first_circulation
            year_of_sale
            month_of_sale
            day_of_sale
            country
            url_image_car
            engine_code
            engine_fuel_type
            engine_displacement
            engine_ouput_power
        }
    }
    """

    @query_one_car_description """
      query car_description($id: ID) {
            car_description(id: $id) {
              id
              vin
              make
              model
              advanced_model
              k_type
              year_of_first_circulation
              month_of_first_circulation
              day_of_first_circulation
              year_of_sale
              month_of_sale
              day_of_sale
              country
              url_image_car
              engine_code
              engine_fuel_type
              engine_displacement
              engine_ouput_power
            }
          }
    """

    def car_fixture do
      {:ok, car} = Cars.create_car(@valid_car_attrs)
      car
    end

    def car_description_fixture do
      {:ok, car_description} =
        Cars.create_car_description(@valid_car_description_attrs)

      car_description
    end

    test "gets a car by id", context do
      car = car_fixture()
      variables = %{id: car.id}

      res =
        context.conn
        |> post("/graphiql", query: @query_one_car, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["car"]["id"] == car.id
      assert res["car"]["serial_id"] == car.serial_id
      assert res["car"]["plate"] == car.plate
    end

    test "gets all cars", context do
      car = car_fixture()

      res =
        context.conn
        |> post("/graphiql", query: @query_all_cars)
        |> json_response(200)
        |> Map.get("data")

      assert Enum.find(res["cars"], fn child -> child["id"] == car.id end)
      assert Enum.find(res["cars"], fn child -> child["serial_id"] == car.serial_id end)
      assert Enum.find(res["cars"], fn child -> child["plate"] == car.plate end)
    end

    test "gets a car_description by id", context do
      car_description = car_description_fixture()
      variables = %{id: car_description.id}

      res =
        context.conn
        |> post("/graphiql", query: @query_one_car_description, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["car_description"]["id"] == Integer.to_string(car_description.id)
      assert res["car_description"]["vin"] == car_description.vin
      assert res["car_description"]["advanced_model"] == car_description.advanced_model
      assert res["car_description"]["make"] == car_description.make
      assert res["car_description"]["model"] == car_description.model
      assert res["car_description"]["k_type"] == car_description.k_type

      assert res["car_description"]["year_of_first_circulation"] ==
               car_description.year_of_first_circulation

      assert res["car_description"]["month_of_first_circulation"] ==
               car_description.month_of_first_circulation

      assert res["car_description"]["day_of_first_circulation"] ==
               car_description.day_of_first_circulation

      assert res["car_description"]["year_of_sale"] == car_description.year_of_sale
      assert res["car_description"]["month_of_sale"] == car_description.month_of_sale
      assert res["car_description"]["day_of_sale"] == car_description.day_of_sale
      assert res["car_description"]["country"] == car_description.country

      assert res["car_description"]["url_image_car"] ==
               car_description.url_image_car

      assert res["car_description"]["engine_code"] == car_description.engine_code

      assert res["car_description"]["engine_fuel_type"] ==
               car_description.engine_fuel_type

      assert res["car_description"]["engine_displacement"] ==
               car_description.engine_displacement

      assert res["car_description"]["engine_ouput_power"] ==
               car_description.engine_ouput_power
    end

    test "gets all car_descriptions", context do
      car_description = car_description_fixture()

      res =
        context.conn
        |> post("/graphiql", query: @query_all_car_descriptions)
        |> json_response(200)
        |> Map.get("data")

      assert Enum.find(res["car_descriptions"], fn child ->
               child["id"] == Integer.to_string(car_description.id)
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["vin"] == car_description.vin
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["advanced_model"] == car_description.advanced_model
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["make"] == car_description.make
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["model"] == car_description.model
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["k_type"] == car_description.k_type
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["year_of_first_circulation"] == car_description.year_of_first_circulation
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["month_of_first_circulation"] ==
                 car_description.month_of_first_circulation
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["day_of_first_circulation"] == car_description.day_of_first_circulation
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["year_of_sale"] == car_description.year_of_sale
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["month_of_sale"] == car_description.month_of_sale
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["day_of_sale"] == car_description.day_of_sale
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["country"] == car_description.country
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["url_image_car"] == car_description.url_image_car
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["engine_code"] == car_description.engine_code
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["engine_fuel_type"] == car_description.engine_fuel_type
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["engine_displacement"] == car_description.engine_displacement
             end)

      assert Enum.find(res["car_descriptions"], fn child ->
               child["engine_ouput_power"] == car_description.engine_ouput_power
             end)
    end
  end
end
