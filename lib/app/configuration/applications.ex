defmodule Backend.App.Configuration.Applications do
  @moduledoc """
  Provides a schema for application table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.App.Accounts.User

  @primary_key {:application_id, Ecto.UUID, autogenerate: false}
  schema "applications" do
    has_many(:users, User, foreign_key: :application_id)
    field(:version, :float)
    field(:default_language, :string)

    timestamps()
  end

  @doc false
  def changeset(application, attrs) do
    application
    |> cast(attrs, [
      :application_id,
      :version,
      :default_language
    ])
    |> validate_required([
      :application_id,
      :version,
      :default_language
    ])
  end
end
