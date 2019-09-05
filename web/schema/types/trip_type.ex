defmodule Backend.App.Web.Schema.Types.TripContextType do
    @moduledoc """
    Provides types for trip contexts.
    """
    use Absinthe.Schema.Notation

    object :trip do
        field(:trip_id, non_null(:id))
        field(:average_speed, non_null(:float))
        field(:breaks, non_null(:integer))
        field(:start_time, non_null(:naive_datetime))
        field(:end_time, non_null(:naive_datetime))
        field(:start_address, non_null(:string))
        field(:stop_address, non_null(:string))
        field(:fuel_consumption, non_null(:float))
        field(:fuel_economy, non_null(:float))
        field(:car_id, non_null(:string))
      end
  end
