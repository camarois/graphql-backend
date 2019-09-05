defmodule Backend.App.Web.Schema.Types.SettingsType do
  @moduledoc """
  Provides types for settings.
  """
  use Absinthe.Schema.Notation

  object :setting do
  field :id, :id
  field :driving_behaviour, :integer
  field :consumption, :boolean
  field :crash_detection, :boolean
  field :driving, :boolean
  field :car_location, :boolean
  field :car_stopped, :boolean
  field :car_tracker, :boolean
  field :car_data, :integer
  field :alerts, :boolean
  field :fuel_level, :boolean
  field :maintenance, :boolean
  field :mileage, :boolean
  field :email, :string
  field :language, :string
  field :logged_in, :boolean
  field :theme, :boolean
  field :units, :string
  field :notif_alert, :boolean
  field :notif_offers, :boolean
  field :notif_stats, :boolean

end
input_object :update_setting_params do
  field :driving_behaviour, :integer
  field :consumption, :boolean
  field :crash_detection, :boolean
  field :driving, :boolean
  field :car_location, :boolean
  field :car_stopped, :boolean
  field :car_tracker, :boolean
  field :car_data, :integer
  field :alerts, :boolean
  field :fuel_level, :boolean
  field :maintenance, :boolean
  field :mileage, :boolean
  field :email, :string
  field :language, :string
  field :logged_in, :boolean
  field :theme, :boolean
  field :units, :string
  field :notif_alert, :boolean
  field :notif_offers, :boolean
  field :notif_stats, :boolean
end

end
