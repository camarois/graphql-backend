defmodule Backend.App.Accounts.UserQueriesTest do
  use Backend.App.ConnCase
  alias Backend.App.Accounts
  alias Backend.App.Configuration

  setup do
    {:ok, uuid = Ecto.UUID.generate()}
    {:ok, app_uuid = Ecto.UUID.generate()}

    Configuration.create_application(%{
      application_id: app_uuid,
      version: 0.1,
      default_language: "fr"
    })

    {:ok, application = Configuration.get_application!(app_uuid)}

    {:ok,
     _context = %{
       uuid: uuid,
       application: application,
       valid_attrs: %{
         application_id: application.application_id,
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
       }
     }}
  end

  describe "user queries" do
    @query_all """
     query users{
      users{
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

    @query_one """
      query user($email: String) {
          user(email: $email) {
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

    def user_fixture(attrs) do
      {:ok, user} = Accounts.create_user(attrs)
      user
    end

    test "gets a user by email", context do
      user = user_fixture(context.valid_attrs)
      variables = %{email: user.email}

      res =
        context.conn
        |> post("/graphiql", query: @query_one, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["user"]["applicationId"] == user.application_id
      assert res["user"]["userId"] == user.user_id
      assert res["user"]["address"] == user.address
      assert res["user"]["age"] == user.age
      assert res["user"]["country"] == user.country
      assert res["user"]["email"] == user.email
      assert res["user"]["enableWifi"] == user.enable_wifi
      assert res["user"]["gender"] == user.gender
      assert res["user"]["name"] == user.name
      assert res["user"]["phone"] == user.phone
      assert res["user"]["wifiPwd"] == user.wifi_pwd
      assert res["user"]["wifiSsid"] == user.wifi_ssid
    end

    test "gets all users", context do
      user = user_fixture(context.valid_attrs)

      res =
        context.conn
        |> post("/graphiql", query: @query_all)
        |> json_response(200)
        |> Map.get("data")

      assert Enum.find(res["users"], fn child ->
               child["applicationId"] == user.application_id
             end)

      assert Enum.find(res["users"], fn child ->
               child["userId"] == user.user_id
             end)

      assert Enum.find(res["users"], fn child ->
               child["address"] == user.address
             end)

      assert Enum.find(res["users"], fn child ->
               child["age"] == user.age
             end)

      assert Enum.find(res["users"], fn child ->
               child["country"] == user.country
             end)

      assert Enum.find(res["users"], fn child ->
               child["email"] == user.email
             end)

      assert Enum.find(res["users"], fn child ->
               child["enableWifi"] == user.enable_wifi
             end)

      assert Enum.find(res["users"], fn child ->
               child["name"] == user.name
             end)

      assert Enum.find(res["users"], fn child ->
               child["phone"] == user.phone
             end)

      assert Enum.find(res["users"], fn child ->
               child["wifiPwd"] == user.wifi_pwd
             end)

      assert Enum.find(res["users"], fn child ->
               child["wifiSsid"] == user.wifi_ssid
             end)

      assert Enum.find(res["users"], fn child ->
               child["gender"] == user.gender
             end)
    end
  end
end
