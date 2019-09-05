defmodule Backend.App.Web.Schema.Types.UsersType do
  @moduledoc """
  Provides types related to users.
  """
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :address, :string
    field :age, :integer
    field :country, :string
    field :email, :string
    field :gender, :integer
    field :name, :string
    field :phone, :integer
    field :user_id, non_null(:string)
    field :enable_wifi, :boolean
    field :wifi_pwd, :string
    field :wifi_ssid, :string
    field :application_id, :string
  end

  input_object :update_user_params do
    field :address, :string
    field :age, :integer
    field :country, :string
    field :email, :string
    field :gender, :integer
    field :name, :string
    field :phone, :integer
    field :user_id, non_null(:string)
    field :enable_wifi, :boolean
    field :wifi_pwd, :string
    field :wifi_ssid, :string
    field :application_id, :string
  end

  object :application do
    field :application_id, non_null(:id)
    field :version, :float
    field :default_language, :string
    field :users, list_of(:user)
  end

  input_object :update_application_params do
    field :application_id, non_null(:id)
    field :version, :float
    field :default_language, :string
  end

  object :application_status do
    field :done, :boolean
    field :application_id, :id
  end

  object :user_status do
    field :done, :boolean
    field :email, :string
    field :user_id, :string
  end

end
