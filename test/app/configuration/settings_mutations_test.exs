defmodule Backend.App.Configuration.SettingsMutationsTest do
  use Backend.App.ConnCase
  alias Backend.App.Configuration

  describe "settings mutations" do
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
    @update_attrs %{
      alerts: true,
      consumption: true,
      crash_detection: true,
      driving: true,
      driving_behaviour: 150,
      email: "updated email",
      fuel_level: true,
      language: "updated language",
      logged_in: true,
      maintenance: true,
      mileage: true,
      notif_alert: true,
      notif_offers: true,
      notif_stats: true,
      theme: true,
      units: "updated units",
      car_data: 150,
      car_location: true,
      car_stopped: true,
      car_tracker: true
    }
    @invalid_attrs %{
      alerts: nil,
      consumption: nil,
      crash_detection: nil,
      driving: nil,
      driving_behaviour: nil,
      email: nil,
      fuel_level: nil,
      language: nil,
      logged_in: nil,
      maintenance: nil,
      mileage: nil,
      notif_alert: nil,
      notif_offers: nil,
      notif_stats: nil,
      theme: nil,
      units: nil,
      car_data: nil,
      car_location: nil,
      car_stopped: nil,
      car_tracker: nil
    }

    @create """
     mutation CreateSetting($email: String, $setting: UpdateSettingParams){
      createSetting(email: $email, setting: $setting){
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

    @update """
    mutation UpdateSetting($email: String, $setting: UpdateSettingParams){
      updateSetting(email: $email, setting: $setting){
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

    test "create valid settings", context do
      variables = %{email: @valid_attrs.email, setting: @valid_attrs}

      res =
        context.conn
        |> post("/graphiql", query: @create, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["createSetting"]["alerts"] == @valid_attrs.alerts
      assert res["createSetting"]["consumption"] == @valid_attrs.consumption
      assert res["createSetting"]["crashDetection"] == @valid_attrs.crash_detection
      assert res["createSetting"]["driving"] == @valid_attrs.driving
      assert res["createSetting"]["drivingBehaviour"] == @valid_attrs.driving_behaviour
      assert res["createSetting"]["email"] == @valid_attrs.email
      assert res["createSetting"]["fuelLevel"] == @valid_attrs.fuel_level
      assert res["createSetting"]["language"] == @valid_attrs.language
      assert res["createSetting"]["loggedIn"] == @valid_attrs.logged_in
      assert res["createSetting"]["maintenance"] == @valid_attrs.maintenance
      assert res["createSetting"]["notifAlert"] == @valid_attrs.notif_alert
      assert res["createSetting"]["notifOffers"] == @valid_attrs.notif_offers
      assert res["createSetting"]["notifStats"] == @valid_attrs.notif_stats
      assert res["createSetting"]["theme"] == @valid_attrs.theme
      assert res["createSetting"]["units"] == @valid_attrs.units
      assert res["createSetting"]["carData"] == @valid_attrs.car_data
      assert res["createSetting"]["carLocation"] == @valid_attrs.car_location
      assert res["createSetting"]["carStopped"] == @valid_attrs.car_stopped
      assert res["createSetting"]["carTracker"] == @valid_attrs.car_tracker
    end

    test "create settings with an email that already exists", context do
      settings1_variables = %{email: @valid_attrs.email, setting: @valid_attrs}
      settings2_variables = %{email: @valid_attrs.email, setting: @update_attrs}

      context.conn
      |> post("/graphiql", query: @create, variables: settings1_variables)
      |> json_response(200)

      settings2_res =
        context.conn
        |> post("/graphiql", query: @create, variables: settings2_variables)
        |> json_response(200)

      assert Enum.at(settings2_res["errors"], 0)["message"] ==
               "this email some email already exist"
    end

    test "create invalid settings", context do
      variables = %{email: @invalid_attrs.email, setting: @invalid_attrs}

      res =
        context.conn
        |> post("/api", query: @create, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["createSetting"] == nil
    end

    test "update settings", context do
      create_variables = %{email: @valid_attrs.email, setting: @valid_attrs}
      update_variables = %{email: @valid_attrs.email, setting: @update_attrs}

      context.conn
      |> post("/graphiql", query: @create, variables: create_variables)
      |> json_response(200)

      update_res =
        context.conn
        |> post("/graphiql", query: @update, variables: update_variables)
        |> json_response(200)
        |> Map.get("data")

      assert update_res["updateSetting"]["alerts"] == @update_attrs.alerts
      assert update_res["updateSetting"]["consumption"] == @update_attrs.consumption
      assert update_res["updateSetting"]["crashDetection"] == @update_attrs.crash_detection
      assert update_res["updateSetting"]["driving"] == @update_attrs.driving
      assert update_res["updateSetting"]["drivingBehaviour"] == @update_attrs.driving_behaviour
      assert update_res["updateSetting"]["email"] == @update_attrs.email
      assert update_res["updateSetting"]["fuelLevel"] == @update_attrs.fuel_level
      assert update_res["updateSetting"]["language"] == @update_attrs.language
      assert update_res["updateSetting"]["loggedIn"] == @update_attrs.logged_in
      assert update_res["updateSetting"]["maintenance"] == @update_attrs.maintenance
      assert update_res["updateSetting"]["notifAlert"] == @update_attrs.notif_alert
      assert update_res["updateSetting"]["notifOffers"] == @update_attrs.notif_offers
      assert update_res["updateSetting"]["notifStats"] == @update_attrs.notif_stats
      assert update_res["updateSetting"]["theme"] == @update_attrs.theme
      assert update_res["updateSetting"]["units"] == @update_attrs.units
      assert update_res["updateSetting"]["carData"] == @update_attrs.car_data
      assert update_res["updateSetting"]["carLocation"] == @update_attrs.car_location
      assert update_res["updateSetting"]["carStopped"] == @update_attrs.car_stopped
      assert update_res["updateSetting"]["carTracker"] == @update_attrs.car_tracker
    end

    test "update invalid settings", context do
      create_variables = %{email: @valid_attrs.email, setting: @valid_attrs}
      update_variables = %{email: @update_attrs.email, setting: @update_attrs}

      context.conn
      |> post("/graphiql", query: @create, variables: create_variables)
      |> json_response(200)

      update_res =
        context.conn
        |> post("/graphiql", query: @update, variables: update_variables)
        |> json_response(200)

      assert Enum.at(update_res["errors"], 0)["message"] == "settings of updated email not found"
    end
  end
end
