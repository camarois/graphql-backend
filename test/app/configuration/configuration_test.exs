defmodule Backend.App.Configuration.ConfigurationTest do
  use ExUnit.Case
  alias Backend.App.Accounts
  alias Backend.App.Configuration
  alias Backend.App.Configuration.Applications
  alias Backend.App.Configuration.Settings
  alias Backend.App.Repo
  alias Ecto.Adapters.SQL.Sandbox

  setup do
    # Explicitly get a connection before each test
    # By default the test is wrapped in a transaction
    :ok = Sandbox.checkout(Repo)
    # The :shared mode allows a process to share
    # its connection with any other process automatically
    Sandbox.mode(Repo, {:shared, self()})
  end

  describe "settings" do
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

    def settings_fixture do
      {:ok, settings} = Configuration.create_setting(@valid_attrs)
      settings
    end

    test "list_settings/0 returns all settings" do
      settings = settings_fixture()
      assert Enum.member?(Configuration.list_settings(), settings)
    end

    test "get_settings!/1 returns the settings with given id" do
      settings = settings_fixture()
      assert Configuration.get_setting!(settings.id) == settings
    end

    test "create_settings/1 with valid data creates settings, than update and delete" do
      assert {:ok, %Settings{} = settings} = Configuration.create_setting(@valid_attrs)

      assert settings.alerts == @valid_attrs.alerts
      assert settings.consumption == @valid_attrs.consumption
      assert settings.crash_detection == @valid_attrs.crash_detection
      assert settings.driving == @valid_attrs.driving
      assert settings.driving_behaviour == @valid_attrs.driving_behaviour
      assert settings.email == @valid_attrs.email
      assert settings.fuel_level == @valid_attrs.fuel_level
      assert settings.language == @valid_attrs.language
      assert settings.logged_in == @valid_attrs.logged_in
      assert settings.maintenance == @valid_attrs.maintenance
      assert settings.mileage == @valid_attrs.mileage
      assert settings.notif_alert == @valid_attrs.notif_alert
      assert settings.notif_offers == @valid_attrs.notif_offers
      assert settings.notif_stats == @valid_attrs.notif_stats
      assert settings.theme == @valid_attrs.theme
      assert settings.units == @valid_attrs.units
      assert settings.car_data == @valid_attrs.car_data
      assert settings.car_location == @valid_attrs.car_location
      assert settings.car_stopped == @valid_attrs.car_stopped
      assert settings.car_tracker == @valid_attrs.car_tracker

      assert {:ok, %Settings{} = updated_settings} =
               Configuration.update_setting(settings, @update_attrs)

      assert updated_settings.alerts == @update_attrs.alerts
      assert updated_settings.consumption == @update_attrs.consumption
      assert updated_settings.crash_detection == @update_attrs.crash_detection
      assert updated_settings.driving == @update_attrs.driving
      assert updated_settings.driving_behaviour == @update_attrs.driving_behaviour
      assert updated_settings.email == @update_attrs.email
      assert updated_settings.fuel_level == @update_attrs.fuel_level
      assert updated_settings.language == @update_attrs.language
      assert updated_settings.logged_in == @update_attrs.logged_in
      assert updated_settings.maintenance == @update_attrs.maintenance
      assert updated_settings.mileage == @update_attrs.mileage
      assert updated_settings.notif_alert == @update_attrs.notif_alert
      assert updated_settings.notif_offers == @update_attrs.notif_offers
      assert updated_settings.notif_stats == @update_attrs.notif_stats
      assert updated_settings.theme == @update_attrs.theme
      assert updated_settings.units == @update_attrs.units
      assert updated_settings.car_data == @update_attrs.car_data
      assert updated_settings.car_location == @update_attrs.car_location
      assert updated_settings.car_stopped == @update_attrs.car_stopped
      assert updated_settings.car_tracker == @update_attrs.car_tracker

      assert {:ok, _} = Configuration.delete_setting(updated_settings)
    end

    test "create_settings/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Configuration.create_setting(@invalid_attrs)
    end
  end

  describe "application" do
    {:ok, uuid = Ecto.UUID.generate()}
    {:ok, app_uuid = Ecto.UUID.generate()}

    @user_attrs %{
      application: %{
        application_id: app_uuid,
        version: 0.1,
        default_language: "fr"
      },
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

    @valid_attrs %{
      application_id: app_uuid,
      users: [uuid],
      version: 0.1,
      default_language: "fr"
    }
    @update_attrs %{
      application_id: app_uuid,
      users: [uuid],
      version: 1.0,
      default_language: "en"
    }
    @invalid_attrs %{
      application_id: app_uuid,
      users: nil,
      version: nil,
      default_language: nil
    }

    def application_fixture do
      {:ok, application} = Configuration.create_application(@valid_attrs)
      Configuration.get_application!(application.application_id)
    end

    def user_fixture do
      {:ok, user} = Accounts.create_user(@user_attrs)
      user
    end

    test "list_applications/0 returns all applications" do
      application = application_fixture()
      user_fixture()
      assert Enum.member?(Configuration.list_applications(), application)
    end

    test "get_application!/1 returns the application with given id" do
      application = application_fixture()
      assert Configuration.get_application!(application.application_id) == application
    end

    test "create_application/1 with valid data creates application, than update and delete" do
      assert {:ok, %Applications{} = application} = Configuration.create_application(@valid_attrs)

      assert application.version == @valid_attrs.version
      assert application.default_language == @valid_attrs.default_language

      assert {:ok, %Applications{} = updated_application} =
               Configuration.update_application(application, @update_attrs)

      assert updated_application.version == @update_attrs.version
      assert updated_application.default_language == @update_attrs.default_language

      assert {:ok, _} = Configuration.delete_application(updated_application)
    end

    test "create_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Configuration.create_application(@invalid_attrs)
    end
  end
end
