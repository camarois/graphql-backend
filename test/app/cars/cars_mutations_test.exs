# defmodule Backend.App.Cars.CarsMutationsTest do
#   use Backend.App.ConnCase
#   alias Backend.App.Cars

#   describe "cars mutations" do
#     @valid_attrs %{
#       serial_id: "some serial_id",
#       plate: "some plate",
#       car_description: %{
#         vin: "some vin",
#         make: "some make",
#         model: "some model",
#         advanced_model: "some advanced_model",
#         k_type: "some k_type",
#         year_of_first_circulation: 2019,
#         month_of_first_circulation: 01,
#         day_of_first_circulation: 01,
#         year_of_sale: 2000,
#         month_of_sale: 01,
#         day_of_sale: 01,
#         country: "some country",
#         url_image_car: "some url",
#         engine_code: "some engine_code",
#         engine_fuel_type: "some engine_fuel_type",
#         engine_displacement: 0,
#         engine_ouput_power: 0
#       }
#     }

#     @update_attrs %{
#       serial_id: "updated serial_id",
#       plate: "updated plate",
#       car_description: %{
#         vin: "updated vin",
#         make: "updated make",
#         model: "updated model",
#         advanced_model: "updated advanced_model",
#         k_type: "updated k_type",
#         year_of_first_circulation: 2020,
#         month_of_first_circulation: 02,
#         day_of_first_circulation: 02,
#         year_of_sale: 2001,
#         month_of_sale: 02,
#         day_of_sale: 02,
#         country: "updated country",
#         url_image_car: "updated url",
#         engine_code: "updated engine_code",
#         engine_fuel_type: "updated engine_fuel_type",
#         engine_displacement: 1,
#         engine_ouput_power: 1
#       }
#     }

#     @invalid_attrs %{
#       serial_id: nil,
#       plate: nil,
#       car_description: nil
#     }

#     @create """
#       mutation CreateCar($serial_id: String, $token: String, $car: UpdateCarParams) {
#             createCar(serial_id: $serial_id, token: $token, car: $car){
#               serial_id
#               plate
#               car_description
#             }
#         }
#     """

#     @update """
#       mutation UpdateCar($serial_id: String, $token: String, $car: UpdateCarParams) {
#             updateCar(serial_id: $serialIId, token: $token, car: $car){
#               serial_id
#               plate
#               car_description
#             }
#         }
#     """

#     @delete """
#       mutation DeleteCar($serial_id: String, $token: String) {
#             deleteCar(serial_id: $serial_id, $token: token){
#               done
#               serial_id
#               carId
#             }
#         }
#     """

#     def car_fixture do
#       {:ok, car} = Cars.create_car(@valid_attrs)
#       car
#     end

#     test "create a valid car", context do
#       variables = %{serial_id: @valid_attrs.serial_id, car: @valid_attrs}
#       delete_variables = %{serial_id: @valid_attrs.serial_id}

#       res =
#         context.conn
#         |> post("/graphiql", query: @create, variables: variables)
#         |> json_response(200)

#       assert res["createCar"]["serial_id"] == @valid_attrs.serial_id
#       assert res["createCar"]["plate"] == @valid_attrs.plate

#     #   res =
#     #     context.conn
#     #     |> post("/graphiql", query: @delete, variables: delete_variables)
#     #     |> json_response(200)
#     #     |> Map.get("data")

#     #   assert res["deleteCar"]["done"] == true
#     #   assert res["deleteCar"]["serial_id"] == @valid_attrs.serial_id
#     #   assert res["deleteCar"]["car_id"] == @valid_attrs.car_id
#     end

#     test "create a car with an serial_id that already exists", context do
#       car1_variables = %{serial_id: @valid_attrs.serial_id, car: @valid_attrs}
#       car2_variables = %{serial_id: @valid_attrs.serial_id, car: @update_attrs}

#       context.conn
#       |> post("/graphiql", query: @create, variables: car1_variables)
#       |> json_response(200)

#       car2_res =
#         context.conn
#         |> post("/graphiql", query: @create, variables: car2_variables)
#         |> json_response(200)

#       assert Enum.at(car2_res["errors"], 0)["message"] ==
#                "This car some serial_id already exists"
#     end

#     test "create an invalid car", context do
#       variables = %{serial_id: @invalid_attrs.serial_id, car: @invalid_attrs}

#       res =
#         context.conn
#         |> post("/api", query: @create, variables: variables)
#         |> json_response(200)
#         |> Map.get("data")

#       assert res["createCar"] == nil
#     end

#     test "update a car", context do
#       create_variables = %{serial_id: @valid_attrs.serial_id, car: @valid_attrs}
#       update_variables = %{serial_id: @valid_attrs.serial_id, car: @update_attrs}

#       context.conn
#       |> post("/graphiql", query: @create, variables: create_variables)
#       |> json_response(200)

#       update_res =
#         context.conn
#         |> post("/graphiql", query: @update, variables: update_variables)
#         |> json_response(200)
#         |> Map.get("data")

#       assert update_res["updateCar"]["serial_id"] == @update_attrs.serial_id
#       assert update_res["updateCar"]["plate"] == @update_attrs.plate
#     end

#     test "update an invalid car", context do
#       create_variables = %{serial_id: @valid_attrs.serial_id, car: @valid_attrs}
#       update_variables = %{serial_id: @update_attrs.serial_id, car: @update_attrs}

#       context.conn
#       |> post("/graphiql", query: @create, variables: create_variables)
#       |> json_response(200)

#       update_res =
#         context.conn
#         |> post("/graphiql", query: @update, variables: update_variables)
#         |> json_response(200)

#       assert Enum.at(update_res["errors"], 0)["message"] == "Car serial_id some serial_id not found"
#     end
#   end
# end
