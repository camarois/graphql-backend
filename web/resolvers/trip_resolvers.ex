defmodule Backend.App.Web.Resolvers.TripResolvers do
  @moduledoc """
  Provides trip context query resolvers.
  """
  alias Backend.App.Trip

  def trips(_, _, _) do
    {:ok, Trip.list_trips()}
  end

  def trip(_, %{id: id}, _) do
    {:ok, Trip.get_trip!(id)}
  end
end
