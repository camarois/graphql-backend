defmodule Backend.App.Accounts.User do
  @moduledoc """
  Provides a schema for user table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.App.Configuration.Applications

  @primary_key {:user_id, :string, autogenerate: false}
  schema "users" do
    field(:address, :string)
    field(:age, :integer)
    field(:country, :string)
    field(:email, :string)
    field(:enable_wifi, :boolean)
    field(:gender, :integer)
    field(:name, :string)
    field(:phone, :integer)
    field(:wifi_pwd, :string)
    field(:wifi_ssid, :string)

    belongs_to(:application, Applications,
      type: Ecto.UUID,
      references: :application_id,
      foreign_key: :application_id,
      on_replace: :nilify
    )

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :user_id,
      :name,
      :gender,
      :age,
      :address,
      :country,
      :email,
      :phone,
      :enable_wifi,
      :wifi_ssid,
      :wifi_pwd,
      :application_id
    ])
    |> validate_required([
      :user_id,
      :name,
      :gender,
      :age,
      :address,
      :country,
      :email,
      :phone,
      :enable_wifi,
      :wifi_ssid,
      :wifi_pwd
    ])
    |> foreign_key_constraint(:application_id)
  end
end
