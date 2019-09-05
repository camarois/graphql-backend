defmodule Backend.App.Configuration.SettingsQueriesTest do
  use Backend.App.ConnCase
  alias Backend.App.Configuration

  describe "settings queries" do
    @valid_attrs %{
      alerts: false,
      consumption: false,
      crash_detection: false,
      driving: false,
      driving_behaviour: 100,
      email: "some email",
      fuel_level: false,
      language: "some language",
      logged_in: false,
      maintenance: false,
      mileage: false,
      notif_alert: false,
      notif_offers: false,
      notif_stats: false,
      theme: false,
      units: "some units",
      car_data: 100,
      car_location: false,
      car_stopped: false,
      car_tracker: false
    }

    @query_all """
     query settings{
      settings{
          alerts
          consumption
          crashDetection
          driving
          drivingBehaviour
          email
          fuelLevel
          language
          loggedIn
          maintenance
          mileage
          notifAlert
          notifOffers
          notifStats
          theme
          units
          carData
          carLocation
          carStopped
          carTracker
       }
     }
    """

    @query_one """
      query setting($email: String) {
          setting(email: $email) {
              alerts
              consumption
              crashDetection
              driving
              drivingBehaviour
              email
              fuelLevel
              language
              loggedIn
              maintenance
              mileage
              notifAlert
              notifOffers
              notifStats
              theme
              units
              carData
              carLocation
              carStopped
              carTracker
            }
          }
    """

    def settings_fixture do
      {:ok, settings} = Configuration.create_setting(@valid_attrs)
      settings
    end

    test "gets settings by id", context do
      settings = settings_fixture()
      variables = %{email: settings.email}

      res =
        context.conn
        |> post("/graphiql", query: @query_one, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["setting"]["alerts"] == settings.alerts
      assert res["setting"]["consumption"] == settings.consumption
      assert res["setting"]["crashDetection"] == settings.crash_detection
      assert res["setting"]["driving"] == settings.driving
      assert res["setting"]["drivingBehaviour"] == settings.driving_behaviour
      assert res["setting"]["email"] == settings.email
      assert res["setting"]["fuelLevel"] == settings.fuel_level
      assert res["setting"]["language"] == settings.language
      assert res["setting"]["loggedIn"] == settings.logged_in
      assert res["setting"]["maintenance"] == settings.maintenance
      assert res["setting"]["notifAlert"] == settings.notif_alert
      assert res["setting"]["notifOffers"] == settings.notif_offers
      assert res["setting"]["notifStats"] == settings.notif_stats
      assert res["setting"]["theme"] == settings.theme
      assert res["setting"]["units"] == settings.units
      assert res["setting"]["carData"] == settings.car_data
      assert res["setting"]["carLocation"] == settings.car_location
      assert res["setting"]["carStopped"] == settings.car_stopped
      assert res["setting"]["carTracker"] == settings.car_tracker
    end

    test "gets all settings", context do
      settings = settings_fixture()

      res =
        context.conn
        |> post("/graphiql", query: @query_all)
        |> json_response(200)
        |> Map.get("data")

      assert Enum.find(res["settings"], fn child ->
               child["alerts"] == settings.alerts
             end)

      assert Enum.find(res["settings"], fn child ->
               child["consumption"] == settings.consumption
             end)

      assert Enum.find(res["settings"], fn child ->
               child["crashDetection"] == settings.crash_detection
             end)

      assert Enum.find(res["settings"], fn child ->
               child["driving"] == settings.driving
             end)

      assert Enum.find(res["settings"], fn child ->
               child["drivingBehaviour"] == settings.driving_behaviour
             end)

      assert Enum.find(res["settings"], fn child ->
               child["email"] == settings.email
             end)

      assert Enum.find(res["settings"], fn child ->
               child["fuelLevel"] == settings.fuel_level
             end)

      assert Enum.find(res["settings"], fn child ->
               child["language"] == settings.language
             end)

      assert Enum.find(res["settings"], fn child ->
               child["loggedIn"] == settings.logged_in
             end)

      assert Enum.find(res["settings"], fn child ->
               child["maintenance"] == settings.maintenance
             end)

      assert Enum.find(res["settings"], fn child ->
               child["notifAlert"] == settings.notif_alert
             end)

      assert Enum.find(res["settings"], fn child ->
               child["notifOffers"] == settings.notif_offers
             end)

      assert Enum.find(res["settings"], fn child ->
               child["notifStats"] == settings.notif_stats
             end)

      assert Enum.find(res["settings"], fn child ->
               child["theme"] == settings.theme
             end)

      assert Enum.find(res["settings"], fn child ->
               child["units"] == settings.units
             end)

      assert Enum.find(res["settings"], fn child ->
               child["carData"] == settings.car_data
             end)

      assert Enum.find(res["settings"], fn child ->
               child["carLocation"] == settings.car_location
             end)

      assert Enum.find(res["settings"], fn child ->
               child["carStopped"] == settings.car_stopped
             end)

      assert Enum.find(res["settings"], fn child ->
               child["carTracker"] == settings.car_tracker
             end)
    end
  end
end
