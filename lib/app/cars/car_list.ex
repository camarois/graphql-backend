defmodule Backend.App.Cars.CarList do
  @moduledoc """
  Provides a schema for car list table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.App.Accounts.User

  @primary_key {:car_list_id, Ecto.UUID, autogenerate: true}
  schema "car_lists" do
    belongs_to(:user, User, references: :user_id, type: :string, primary_key: true)
    timestamps()
  end

  @doc false
  def changeset(car_list, attrs) do
    car_list
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
    |> foreign_key_constraint(:user_id)
  end
end
