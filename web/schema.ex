defmodule Backend.App.Web.Schema do
    @moduledoc """
    App backend general schema.
    """
    use Absinthe.Schema
    alias Backend.App.Web.Schema.Applications
    alias Backend.App.Web.Schema.Dashboard
    alias Backend.App.Web.Schema.Middleware
    alias Backend.App.Web.Schema.Settings
    alias Backend.App.Web.Schema.Trip
    alias Backend.App.Web.Schema.Types
    alias Backend.App.Web.Schema.Users
    alias Backend.App.Web.Schema.Cars

    import_types(Absinthe.Type.Custom)

    # Types

    import_types(Types.TripType)
    import_types(Types.DashboardType)
    import_types(Types.SettingsType)
    import_types(Types.UsersType)
    import_types(Types.CarType)

    # Queries

    import_types(Trip.Queries.TripQueries)
    import_types(Dashboard.Queries.DashboardQueries)
    import_types(Settings.Queries.SettingsQueries)
    import_types(Users.Queries.UsersQueries)
    import_types(Cars.Queries.CarsQueries)
    import_types(Applications.Queries.ApplicationQueries)

    # Mutations

    import_types(Settings.Mutations.SettingsMutations)
    import_types(Users.Mutations.UsersMutations)
    import_types(Applications.Mutations.ApplicationMutations)
    import_types(Cars.Mutations.CarsMutations)

    query do
      import_fields(:trip_context_queries)
      import_fields(:dashboard_queries)
      import_fields(:cars_queries)
      import_fields(:settings_queries)
      import_fields(:users_queries)
      import_fields(:application_queries)
    end

    mutation do
      import_fields(:settings_mutations)
      import_fields(:users_mutations)
      import_fields(:application_mutations)
      import_fields(:car_mutations)
    end

    def middleware(middleware, _field, %{identifier: :mutation}) do
      middleware ++ [Middleware.ChangesetErrors]
    end

    def middleware(middleware, _field, _object) do
      middleware
    end

end
