defmodule Backend.App.Repo.Migrations.Schema do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:applications, primary_key: false) do
      add :application_id, :uuid, primary_key: true
      add :version, :float
      add :default_language, :string
      timestamps()
    end

    create_if_not_exists table(:fields) do
      add :field_id, :serial, primary_key: true
      add :type, :string
      add :asset, :string
      add :field_name, :string
      add :field_value, :float
      add :latitude, :float
      add :longitude, :float
      add :timestamp, :string

      timestamps()
    end

    create_if_not_exists table(:trips) do
      add :trip_id, :serial, primary_key: true
      add :car_id, :uuid
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :breaks, :integer
      add :fuel_economy, :float
      add :fuel_consumption, :float
      add :start_address, :string
      add :stop_address, :string
      add :average_speed, :float

      timestamps()
    end

    create_if_not_exists table(:users) do
      add :address, :string
      add :age, :integer
      add :country, :string
      add :email, :string
      add :gender, :integer
      add :name, :string
      add :phone, :integer
      add :user_id, :string, primary_key: true
      add :enable_wifi, :boolean
      add :wifi_pwd, :string
      add :wifi_ssid, :string
      add :application_id, references(:applications, column: :application_id, type: :uuid, on_delete: :nothing)
      timestamps()
    end

    create_if_not_exists(unique_index(:users, [:user_id]))

    create_if_not_exists table(:cars, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :serial_id, :string
      add :plate, :string

      timestamps()
    end

    create_if_not_exists table(:car_descriptions) do
      add :advanced_model, :string
      add :country, :string
      add :day_of_first_circulation, :integer
      add :day_of_sale, :integer
      add :engine_code, :string
      add :engine_displacement, :integer
      add :engine_fuel_type, :string
      add :engine_ouput_power, :integer
      add :k_type, :string
      add :make, :string
      add :model, :string
      add :month_of_first_circulation, :integer
      add :month_of_sale, :integer
      add :url_image_car, :string
      add :vin, :string
      add :year_of_first_circulation, :integer
      add :year_of_sale, :integer 
      add :car_id, references(:cars, on_delete: :nothing, type: :uuid)
      timestamps()
    end

    create_if_not_exists index(:car_descriptions, [:car_id])

    create_if_not_exists table(:car_lists, primary_key: false) do
      add :car_list_id, :uuid, primary_key: true
      add :user_id, references(:users, column: :user_id, on_delete: :nothing, type: :string), primary_key: true
      timestamps()
    end

    create_if_not_exists(unique_index(:car_lists, [:car_list_id]))

    create_if_not_exists table(:car_list_cars, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :car_list_id, references(:car_lists, column: :car_list_id, on_delete: :nothing, type: :uuid), primary_key: true
      add :car_id, references(:cars, column: :id, on_delete: :nothing, type: :uuid), primary_key: true
      timestamps()
    end

    create_if_not_exists table(:settings) do
      add :alerts, :boolean, default: false
      add :consumption, :boolean, default: false
      add :crash_detection, :boolean, default: false
      add :driving, :boolean, default: false
      add :driving_behaviour, :integer
      add :email, :string
      add :fuel_level, :boolean, default: false
      add :language, :string
      add :logged_in, :boolean, default: false
      add :maintenance, :boolean, default: false
      add :mileage, :boolean, default: false
      add :notif_alert, :boolean, default: false
      add :notif_offers, :boolean, default: false
      add :notif_stats, :boolean, default: false
      add :theme, :boolean, default: false
      add :units, :string
      add :car_data, :integer
      add :car_location, :boolean, default: false
      add :car_stopped, :boolean, default: false
      add :car_tracker, :boolean, default: false
      timestamps()
    end
  end
end
