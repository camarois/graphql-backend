defmodule Backend.App.Configuration.Settings do
  @moduledoc """
  Provides a schema for settings table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "settings" do
    field(:alerts, :boolean, default: false)
    field(:consumption, :boolean, default: false)
    field(:crash_detection, :boolean, default: false)
    field(:driving, :boolean, default: false)
    field(:driving_behaviour, :integer)
    field(:email, :string)
    field(:fuel_level, :boolean, default: false)
    field(:language, :string)
    field(:logged_in, :boolean, default: false)
    field(:maintenance, :boolean, default: false)
    field(:mileage, :boolean, default: false)
    field(:notif_alert, :boolean, default: false)
    field(:notif_offers, :boolean, default: false)
    field(:notif_stats, :boolean, default: false)
    field(:theme, :boolean, default: false)
    field(:units, :string)
    field(:car_data, :integer)
    field(:car_location, :boolean, default: false)
    field(:car_stopped, :boolean, default: false)
    field(:car_tracker, :boolean, default: false)

    timestamps()
  end

  @doc false
  def changeset(settings, attrs) do
    settings
    |> cast(attrs, [
      :driving_behaviour,
      :consumption,
      :crash_detection,
      :driving,
      :car_location,
      :car_stopped,
      :car_tracker,
      :car_data,
      :alerts,
      :fuel_level,
      :maintenance,
      :mileage,
      :email,
      :language,
      :logged_in,
      :theme,
      :units,
      :notif_alert,
      :notif_offers,
      :notif_stats
    ])
    |> validate_required([
      :driving_behaviour,
      :consumption,
      :crash_detection,
      :driving,
      :car_location,
      :car_stopped,
      :car_tracker,
      :car_data,
      :alerts,
      :fuel_level,
      :maintenance,
      :mileage,
      :email,
      :language,
      :logged_in,
      :theme,
      :units,
      :notif_alert,
      :notif_offers,
      :notif_stats
    ])
  end
end
