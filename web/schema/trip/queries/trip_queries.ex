defmodule Backend.App.Web.Schema.Trip.Queries.TripQueries do
    @moduledoc """
    Provides trip context queries.
    """
    use Absinthe.Schema.Notation

    alias Backend.App.Web.Resolvers.TripResolvers

    object :trip_context_queries do
      @desc "Get a list of trips"
      field :trips, list_of(:trip) do
        resolve(&TripResolvers.trips/3)
      end

      @desc "Get a trip by its id"
      field :trip, :trip do
        arg(:id, non_null(:id))
        resolve(&TripResolvers.trip/3)
      end
    end
  end
