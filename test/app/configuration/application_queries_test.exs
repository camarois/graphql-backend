defmodule Backend.App.Configuration.ApplicationQueriesTest do
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

    Accounts.create_user(%{
      application_id: app_uuid,
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
    })

    {:ok, user = Accounts.get_user!(uuid)}
    {:ok, application = Configuration.get_application!(app_uuid)}

    {:ok,
     _context = %{
       uuid: uuid,
       application: application,
       user: user
     }}
  end

  describe "application queries" do
    @query_all """
     query applications{
        applications{
          users{
            applicationId
            address
            age
            country
            email
            enableWifi
            gender
            name
            phone
            userId
            wifiPwd
            wifiSsid
          }
          applicationId
          version
          defaultLanguage
       }
     }
    """

    @query_one """
      query application($id: ID) {
        application(id: $id) {
          users{
            applicationId
            address
            age
            country
            email
            enableWifi
            gender
            name
            phone
            userId
            wifiPwd
            wifiSsid
          }
          applicationId
          version
          defaultLanguage
            }
          }
    """

    test "gets application by application_id", context do
      variables = %{id: context.application.application_id}

      res =
        context.conn
        |> post("/graphiql", query: @query_one, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["application"]["applicationId"] == context.application.application_id
      assert res["application"]["version"] == context.application.version
      assert res["application"]["defaultLanguage"] == context.application.default_language

      assert Enum.find(res["application"]["users"], fn child ->
               child["applicationId"] == context.user.application_id
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["userId"] == context.user.user_id
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["address"] == context.user.address
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["age"] == context.user.age
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["country"] == context.user.country
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["email"] == context.user.email
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["enableWifi"] == context.user.enable_wifi
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["gender"] == context.user.gender
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["name"] == context.user.name
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["phone"] == context.user.phone
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["wifiPwd"] == context.user.wifi_pwd
             end)

      assert Enum.find(res["application"]["users"], fn child ->
               child["wifiSsid"] == context.user.wifi_ssid
             end)
    end

    test "gets all applications", context do
      res =
        context.conn
        |> post("/graphiql", query: @query_all)
        |> json_response(200)
        |> Map.get("data")

      assert Enum.find(res["applications"], fn child ->
               child["applicationId"] == context.application.application_id
             end)

      assert Enum.find(res["applications"], fn child ->
               child["version"] == context.application.version
             end)

      assert Enum.find(res["applications"], fn child ->
               child["defaultLanguage"] == context.application.default_language
             end)

      assert Enum.find(res["applications"], fn child ->
               context_user = %{
                 "applicationId" => context.user.application_id,
                 "address" => context.user.address,
                 "age" => context.user.age,
                 "country" => context.user.country,
                 "email" => context.user.email,
                 "enableWifi" => context.user.enable_wifi,
                 "gender" => context.user.gender,
                 "name" => context.user.name,
                 "phone" => context.user.phone,
                 "userId" => context.user.user_id,
                 "wifiPwd" => context.user.wifi_pwd,
                 "wifiSsid" => context.user.wifi_ssid
               }

               Enum.member?(child["users"], context_user)
             end)
    end
  end
end
