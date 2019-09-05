defmodule Backend.App.Accounts.UserMutationsTest do
  use Backend.App.ConnCase
  alias Backend.App.Configuration

  setup do
    {:ok, uuid = Ecto.UUID.generate()}
    {:ok, app1_uuid = Ecto.UUID.generate()}
    {:ok, app2_uuid = Ecto.UUID.generate()}

    Configuration.create_application(%{
      application_id: app1_uuid,
      version: 0.1,
      default_language: "fr"
    })

    Configuration.create_application(%{
      application_id: app2_uuid,
      version: 0.2,
      default_language: "en"
    })

    {:ok, application1 = Configuration.get_application!(app1_uuid)}
    {:ok, application2 = Configuration.get_application!(app2_uuid)}

    {:ok,
     _context = %{
       uuid: uuid,
       application1: application1,
       application2: application2,
       valid_attrs: %{
         application_id: application1.application_id,
         address: "some address",
         age: 14,
         country: "some country",
         email: "some email",
         enable_wifi: true,
         gender: 0,
         name: "some name",
         phone: 336_066_666,
         user_id: uuid,
         wifi_pwd: "some wifi_pwd",
         wifi_ssid: "some wifi_ssid"
       },
       update_attrs: %{
         application_id: application2.application_id,
         address: "updated address",
         age: 20,
         country: "updated country",
         email: "updated email",
         enable_wifi: false,
         gender: 1,
         name: "updated name",
         phone: 336_666_666,
         user_id: uuid,
         wifi_pwd: "updated wifi_pwd",
         wifi_ssid: "updated wifi_ssid"
       }
     }}
  end

  describe "user mutations" do
    @invalid_attrs %{
      application_id: nil,
      address: nil,
      age: nil,
      country: nil,
      email: nil,
      enable_wifi: nil,
      gender: nil,
      name: nil,
      phone: nil,
      user_id: nil,
      wifi_pwd: nil,
      wifi_ssid: nil
    }

    @create """
      mutation CreateUser($email: String, $user: UpdateUserParams) {
            createUser(email: $email, user: $user){
              applicationId
              userId
              address
              age
              country
              email
              enableWifi
              gender
              name
              phone
              wifiPwd
              wifiSsid
            }
        }
    """

    @update """
      mutation UpdateUser($email: String, $user: UpdateUserParams) {
            updateUser(email: $email, user: $user){
              applicationId
              userId
              address
              age
              country
              email
              enableWifi
              gender
              name
              phone
              wifiPwd
              wifiSsid
            }
        }
    """

    @delete """
      mutation DeleteUser($email: String) {
            deleteUser(email: $email){
              done
              email
              user_id
            }
        }
    """

    test "create a valid user", context do
      variables = %{email: context.valid_attrs.email, user: context.valid_attrs}
      delete_variables = %{email: context.valid_attrs.email}

      res =
        context.conn
        |> post("/graphiql", query: @create, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["createUser"]["applicationId"] == context.valid_attrs.application_id
      assert res["createUser"]["userId"] == context.valid_attrs.user_id
      assert res["createUser"]["address"] == context.valid_attrs.address
      assert res["createUser"]["age"] == context.valid_attrs.age
      assert res["createUser"]["country"] == context.valid_attrs.country
      assert res["createUser"]["email"] == context.valid_attrs.email
      assert res["createUser"]["enableWifi"] == context.valid_attrs.enable_wifi
      assert res["createUser"]["gender"] == context.valid_attrs.gender
      assert res["createUser"]["name"] == context.valid_attrs.name
      assert res["createUser"]["phone"] == context.valid_attrs.phone
      assert res["createUser"]["wifiPwd"] == context.valid_attrs.wifi_pwd
      assert res["createUser"]["wifiSsid"] == context.valid_attrs.wifi_ssid

      res =
        context.conn
        |> post("/graphiql", query: @delete, variables: delete_variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["deleteUser"]["done"] == true
      assert res["deleteUser"]["email"] == context.valid_attrs.email
      assert res["deleteUser"]["user_id"] == context.valid_attrs.user_id
    end

    test "create a user with an email that already exists", context do
      user1_variables = %{email: context.valid_attrs.email, user: context.valid_attrs}
      user2_variables = %{email: context.valid_attrs.email, user: context.update_attrs}

      context.conn
      |> post("/graphiql", query: @create, variables: user1_variables)
      |> json_response(200)

      user2_res =
        context.conn
        |> post("/graphiql", query: @create, variables: user2_variables)
        |> json_response(200)

      assert Enum.at(user2_res["errors"], 0)["message"] == "this email some email already exist"
    end

    test "create an invalid user", context do
      variables = %{email: @invalid_attrs.email, user: @invalid_attrs}

      res =
        context.conn
        |> post("/api", query: @create, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["createUser"] == nil
    end

    test "update a user", context do
      create_variables = %{email: context.valid_attrs.email, user: context.valid_attrs}
      update_variables = %{email: context.valid_attrs.email, user: context.update_attrs}

      context.conn
      |> post("/graphiql", query: @create, variables: create_variables)
      |> json_response(200)

      update_res =
        context.conn
        |> post("/graphiql", query: @update, variables: update_variables)
        |> json_response(200)
        |> Map.get("data")

      assert update_res["updateUser"]["applicationId"] == context.update_attrs.application_id
      assert update_res["updateUser"]["userId"] == context.update_attrs.user_id
      assert update_res["updateUser"]["address"] == context.update_attrs.address
      assert update_res["updateUser"]["age"] == context.update_attrs.age
      assert update_res["updateUser"]["country"] == context.update_attrs.country
      assert update_res["updateUser"]["email"] == context.update_attrs.email
      assert update_res["updateUser"]["enableWifi"] == context.update_attrs.enable_wifi
      assert update_res["updateUser"]["gender"] == context.update_attrs.gender
      assert update_res["updateUser"]["name"] == context.update_attrs.name
      assert update_res["updateUser"]["phone"] == context.update_attrs.phone
      assert update_res["updateUser"]["wifiPwd"] == context.update_attrs.wifi_pwd
      assert update_res["updateUser"]["wifiSsid"] == context.update_attrs.wifi_ssid
    end

    test "update an invalid user", context do
      create_variables = %{email: context.valid_attrs.email, user: context.valid_attrs}
      update_variables = %{email: context.update_attrs.email, user: context.update_attrs}

      context.conn
      |> post("/graphiql", query: @create, variables: create_variables)
      |> json_response(200)

      update_res =
        context.conn
        |> post("/graphiql", query: @update, variables: update_variables)
        |> json_response(200)

      assert Enum.at(update_res["errors"], 0)["message"] == "user of updated email not found"
    end
  end
end
